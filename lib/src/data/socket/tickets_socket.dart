import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/io.dart';
import 'package:finskool/src/comman/storage_keys.dart';
import 'package:finskool/src/data/api/api.dart';
import 'package:finskool/src/data/api/session_expiry.dart';
import 'package:finskool/src/utilities/logger.dart';
import 'package:finskool/src/utilities/shared_pref_helper.dart';

import 'socket_frames.dart';

/// The one live connection. A `@lazySingleton` **service, not a bloc**: it
/// is infrastructure, it emits from stream callbacks rather than event
/// handlers, and it has to outlive any single screen.
///
/// Everything here is from §6.3, and each rule is load-bearing:
///
/// * **`IOWebSocketChannel.connect`, never `WebSocketChannel.connect`** —
///   only the IO one can set headers, and the upgrade must carry the
///   `mobile_session_id` cookie. Many socket clients don't share the HTTP
///   cookie jar, so we set it ourselves (§3).
/// * One ack per request, matched by `id`, with a 15s timeout.
/// * **Nothing is replayed after a disconnect** — callers must refetch on
///   reconnect; this class only reports the transition.
/// * **Close code 4401 means the session died, not "retry"**. It routes
///   into the existing [SessionExpiry], which `AuthenticatorWatcherBloc`
///   already listens to and the dashboard shell already turns into a trip
///   to login.
@lazySingleton
class TicketsSocket with WidgetsBindingObserver {
  TicketsSocket();

  static const _maxBackoff = Duration(seconds: 30);

  /// 64 KB per frame (§9). Checked before sending so an oversized message
  /// fails locally with a useful error instead of killing the connection.
  static const _maxFrameBytes = 64 * 1024;

  /// 30 requests per 10 seconds, per connection — and the budget is shared
  /// with the services module on the same socket.
  static const _rateWindow = Duration(seconds: 10);
  static const _rateLimit = 30;

  /// How long a request waits for its ack. 15s per the spec; a field rather
  /// than a constant so a test doesn't have to wait that long.
  @visibleForTesting
  Duration requestTimeout = const Duration(seconds: 15);

  /// The socket URL. Overridable so a test can point it at a local server
  /// instead of production.
  @visibleForTesting
  Uri get endpoint => Uri.parse(Api.socketUrl);

  /// First reconnect delay; doubles each attempt up to [_maxBackoff].
  @visibleForTesting
  Duration baseBackoff = const Duration(seconds: 1);

  final _uuid = const Uuid();
  final _events = StreamController<SocketEvent>.broadcast();
  final _status = StreamController<SocketStatus>.broadcast();
  final _pending = <String, Completer<Map<String, dynamic>?>>{};
  final _sentAt = <DateTime>[];

  IOWebSocketChannel? _channel;
  StreamSubscription<dynamic>? _sub;
  Timer? _reconnect;
  int _attempt = 0;
  bool _disposed = false;
  bool _observing = false;
  bool _foreground = true;
  SocketStatus _current = SocketStatus.idle;

  Stream<SocketEvent> get events => _events.stream;
  Stream<SocketStatus> get status => _status.stream;
  SocketStatus get currentStatus => _current;

  /// Safe to call repeatedly — opening an already-live socket is a no-op.
  void connect() {
    if (_disposed || _channel != null) return;
    // Guarded: connect/disconnect cycles with every login and logout, and
    // `addObserver` does not de-duplicate — each cycle would otherwise stack
    // another lifecycle callback.
    if (!_observing) {
      WidgetsBinding.instance.addObserver(this);
      _observing = true;
    }
    _open();
  }

  /// Resolves `true` once the socket is live, or `false` after [timeout].
  ///
  /// Opening a conversation straight after login races the connection: the
  /// history request would be refused as OFFLINE for the sake of a few
  /// hundred milliseconds. A bounded wait turns that race into a short
  /// spinner, and the timeout stops a genuinely dead socket from hanging the
  /// screen — the chat then resyncs when the connection does come up.
  Future<bool> whenLive({Duration timeout = const Duration(seconds: 6)}) async {
    if (_current == SocketStatus.live) return true;
    try {
      await _status.stream
          .firstWhere((s) => s == SocketStatus.live)
          .timeout(timeout);
      return true;
    } on TimeoutException {
      return false;
    }
  }

  /// Closes the connection for a **logout**. The socket authenticates once,
  /// at upgrade, with whatever cookie was stored then — so leaving it open
  /// across a logout would keep the previous account's session streaming
  /// into the next user's app until the server happened to close it.
  Future<void> disconnect() async {
    final channel = _channel;
    _attempt = 0;
    _teardown();
    _emit(SocketStatus.idle);
    await channel?.sink.close();
  }

  Future<void> _open() async {
    final cookie = SharedPreferenceHelper().getdata(StorageKeys.sessionCookie);
    if (cookie == null || cookie.isEmpty) {
      // No credential to present: the upgrade would 401. Don't hammer it.
      _emit(SocketStatus.offline);
      return;
    }
    _emit(SocketStatus.connecting);
    try {
      final channel = IOWebSocketChannel.connect(
        endpoint,
        headers: {'Cookie': 'mobile_session_id=$cookie'},
        pingInterval: const Duration(seconds: 30),
      );
      _channel = channel;
      _sub = channel.stream.listen(
        _onFrame,
        onDone: _onDone,
        onError: (Object e) => logger.warning('Ticket socket error: $e'),
        cancelOnError: true,
      );
      // `ready` throws if the upgrade is refused — a 401 lands here.
      await channel.ready;
      _attempt = 0;
      _emit(SocketStatus.live);
    } catch (e) {
      logger.warning('Ticket socket could not connect: $e');
      _teardown();
      _scheduleReconnect();
    }
  }

  void _onFrame(dynamic raw) {
    if (raw is! String) return;
    final Map<String, dynamic> json;
    try {
      json = jsonDecode(raw) as Map<String, dynamic>;
    } catch (_) {
      return;
    }
    if (json['event'] == 'ack') {
      final ack = SocketAck.fromJson(json);
      final completer = _pending.remove(ack.id);
      if (completer == null || completer.isCompleted) return;
      if (ack.ok) {
        completer.complete(ack.data);
      } else {
        completer.completeError(
          ack.error ?? const SocketError('INTERNAL_ERROR', 'Request failed.'),
        );
      }
      return;
    }
    _events.add(SocketEvent.fromJson(json));
  }

  /// Sends a request and waits for its ack.
  Future<Map<String, dynamic>?> send(
    String action,
    Map<String, dynamic> payload,
  ) async {
    final channel = _channel;
    if (channel == null || _current != SocketStatus.live) {
      throw const SocketError(
        'OFFLINE',
        'You are offline. Reconnecting to support…',
      );
    }
    _checkRate();

    final frame = SocketRequest(
      id: _uuid.v4(),
      action: action,
      payload: payload,
    );
    final text = jsonEncode(frame.toJson());
    if (text.length > _maxFrameBytes) {
      throw const SocketError(
        'FRAME_TOO_LARGE',
        'That message is too large to send.',
      );
    }

    final completer = Completer<Map<String, dynamic>?>();
    _pending[frame.id] = completer;
    channel.sink.add(text);

    try {
      return await completer.future.timeout(requestTimeout);
    } on TimeoutException {
      _pending.remove(frame.id);
      throw const SocketError(
        'TIMEOUT',
        'Support did not respond. Please try again.',
      );
    }
  }

  /// Fails locally rather than letting the server answer `RATE_LIMITED` and
  /// spend one of the next window's slots doing it.
  void _checkRate() {
    final now = DateTime.now();
    _sentAt.removeWhere((t) => now.difference(t) > _rateWindow);
    if (_sentAt.length >= _rateLimit) {
      throw const SocketError(
        'RATE_LIMITED',
        'Too many requests. Please wait a moment.',
      );
    }
    _sentAt.add(now);
  }

  void _onDone() {
    final code = _channel?.closeCode;
    _teardown();

    // 4401 is "your session is no longer valid", **not** "try again" — so
    // reconnecting blindly would loop forever against a dead cookie.
    if (code == 4401) {
      logger.info('Ticket socket closed 4401; session is no longer valid.');
      _emit(SocketStatus.offline);
      SessionExpiry.instance.notifyExpired();
      return;
    }
    _scheduleReconnect();
  }

  /// 1s, 2s, 4s … capped at 30s, reset on a successful connect, and paused
  /// entirely while the app is backgrounded.
  void _scheduleReconnect() {
    if (_disposed || !_foreground) {
      _emit(SocketStatus.offline);
      return;
    }
    _emit(SocketStatus.offline);
    final delay = Duration(
      milliseconds: (baseBackoff.inMilliseconds * (1 << _attempt)).clamp(
        baseBackoff.inMilliseconds,
        _maxBackoff.inMilliseconds,
      ),
    );
    _attempt = (_attempt + 1).clamp(0, 5);
    _reconnect?.cancel();
    _reconnect = Timer(delay, _open);
  }

  void _teardown() {
    _reconnect?.cancel();
    _sub?.cancel();
    _sub = null;
    _channel = null;
    for (final c in _pending.values) {
      if (!c.isCompleted) {
        c.completeError(
          const SocketError('OFFLINE', 'The connection dropped.'),
        );
      }
    }
    _pending.clear();
  }

  void _emit(SocketStatus next) {
    if (_current == next) return;
    _current = next;
    if (!_status.isClosed) _status.add(next);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _foreground = state == AppLifecycleState.resumed;
    if (_foreground) {
      // Nothing is replayed, so whoever is on screen must refetch — the
      // status transition back to `live` is their cue.
      _attempt = 0;
      if (_channel == null) _open();
    } else {
      _reconnect?.cancel();
    }
  }

  Future<void> dispose() async {
    _disposed = true;
    if (_observing) WidgetsBinding.instance.removeObserver(this);
    _observing = false;
    _teardown();
    await _channel?.sink.close();
    await _events.close();
    await _status.close();
  }
}
