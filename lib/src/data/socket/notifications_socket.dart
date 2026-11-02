import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:web_socket_channel/io.dart';
import 'package:finskool/src/comman/storage_keys.dart';
import 'package:finskool/src/data/api/api.dart';
import 'package:finskool/src/data/api/session_expiry.dart';
import 'package:finskool/src/data/socket/socket_frames.dart';
import 'package:finskool/src/domain/model/notification/app_notification.dart';
import 'package:finskool/src/utilities/logger.dart';
import 'package:finskool/src/utilities/shared_pref_helper.dart';

/// A `notification.created` frame: the new inbox row and the member's new
/// unread total, so a list and a badge update without a refetch.
class NotificationEvent {
  const NotificationEvent(this.notification, this.unreadCount);

  final AppNotification notification;
  final int? unreadCount;
}

/// `wss://<host>/ws/notifications` — receive-only, **foreground only**.
///
/// Rules from the push guide §8, each load-bearing:
/// * the upgrade carries the `mobile_session_id` cookie (`IOWebSocketChannel`
///   is the one that can set headers);
/// * **close code 4401 means the session ended — do not reconnect**; it goes
///   to the existing [SessionExpiry] which sends the member to login;
/// * any other close reconnects with exponential backoff;
/// * **events are not replayed**, so a transition back to `live` is the cue
///   for listeners to refetch the inbox and the count;
/// * it is closed in the background (the push banner covers that) and reopened
///   on return.
///
/// A separate service from [TicketsSocket]: the two endpoints, rate budgets and
/// lifecycles are unrelated.
@lazySingleton
class NotificationsSocket with WidgetsBindingObserver {
  NotificationsSocket();

  static const _maxBackoff = Duration(seconds: 30);

  /// Overridable so a test can point at a local server.
  @visibleForTesting
  Uri get endpoint => Uri.parse(Api.notificationsSocketUrl);

  @visibleForTesting
  Duration baseBackoff = const Duration(seconds: 1);

  final _events = StreamController<NotificationEvent>.broadcast();
  final _status = StreamController<SocketStatus>.broadcast();

  IOWebSocketChannel? _channel;
  StreamSubscription<dynamic>? _sub;
  Timer? _reconnect;
  int _attempt = 0;
  bool _wanted = false;
  bool _foreground = true;
  bool _observing = false;
  SocketStatus _current = SocketStatus.idle;

  Stream<NotificationEvent> get events => _events.stream;
  Stream<SocketStatus> get status => _status.stream;
  bool get isLive => _current == SocketStatus.live;

  /// Safe to call repeatedly.
  void connect() {
    _wanted = true;
    if (!_observing) {
      WidgetsBinding.instance.addObserver(this);
      _observing = true;
    }
    if (_channel == null && _foreground) _open();
  }

  /// For a logout: the socket authenticates once, at upgrade, so left open it
  /// would keep streaming this account into the next sign-in.
  Future<void> disconnect() async {
    _wanted = false;
    final channel = _channel;
    _attempt = 0;
    _teardown();
    _emit(SocketStatus.idle);
    await channel?.sink.close();
  }

  Future<void> _open() async {
    final cookie = SharedPreferenceHelper().getdata(StorageKeys.sessionCookie);
    if (cookie == null || cookie.isEmpty) {
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
        onError: (Object e) => logger.warning('Notifications socket: $e'),
        cancelOnError: true,
      );
      await channel.ready; // throws if the upgrade is refused (401)
      _attempt = 0;
      _emit(SocketStatus.live);
    } catch (e) {
      logger.warning('Notifications socket could not connect: $e');
      _teardown();
      _scheduleReconnect();
    }
  }

  void _onFrame(dynamic raw) {
    if (raw is! String) return;
    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      if (json['event'] != 'notification.created') return;
      final n = json['notification'];
      if (n is! Map<String, dynamic>) return;
      _events.add(
        NotificationEvent(
          AppNotification.fromJson(n),
          (json['unreadCount'] as num?)?.toInt(),
        ),
      );
    } catch (_) {
      // A frame we can't read is dropped, never fatal.
    }
  }

  void _onDone() {
    final code = _channel?.closeCode;
    _teardown();
    if (code == 4401) {
      logger.info('Notifications socket closed 4401; session ended.');
      _emit(SocketStatus.offline);
      SessionExpiry.instance.notifyExpired();
      return;
    }
    _scheduleReconnect();
  }

  void _scheduleReconnect() {
    _emit(SocketStatus.offline);
    if (!_wanted || !_foreground) return;
    final ms = (baseBackoff.inMilliseconds * (1 << _attempt)).clamp(
      baseBackoff.inMilliseconds,
      _maxBackoff.inMilliseconds,
    );
    _attempt = (_attempt + 1).clamp(0, 5);
    _reconnect?.cancel();
    _reconnect = Timer(Duration(milliseconds: ms), _open);
  }

  void _teardown() {
    _reconnect?.cancel();
    _sub?.cancel();
    _sub = null;
    _channel = null;
  }

  void _emit(SocketStatus next) {
    if (_current == next) return;
    _current = next;
    if (!_status.isClosed) _status.add(next);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final foreground = state == AppLifecycleState.resumed;
    if (foreground == _foreground) return;
    _foreground = foreground;
    if (!_wanted) return;
    if (foreground) {
      _attempt = 0;
      if (_channel == null) _open();
    } else {
      // Closed in the background; the OS banner covers that time.
      final channel = _channel;
      _teardown();
      _emit(SocketStatus.idle);
      channel?.sink.close();
    }
  }
}
