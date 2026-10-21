import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:finskool/src/comman/storage_keys.dart';
import 'package:finskool/src/data/api/session_expiry.dart';
import 'package:finskool/src/data/socket/socket_frames.dart';
import 'package:finskool/src/data/socket/tickets_socket.dart';
import 'package:finskool/src/utilities/shared_pref_helper.dart';

/// A real WebSocket server on localhost, so these tests exercise the actual
/// `IOWebSocketChannel`: the cookie header on the upgrade, ack correlation,
/// pushed events, backoff and the 4401 rule. Nothing is mocked below the
/// server's own behaviour, which each test scripts.
class _Server {
  late final HttpServer http;
  final cookies = <String?>[];
  final sockets = <WebSocket>[];
  void Function(WebSocket socket, Map<String, dynamic> frame)? onFrame;

  Future<void> start() async {
    http = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    http.listen((request) async {
      cookies.add(request.headers.value('cookie'));
      final socket = await WebSocketTransformer.upgrade(request);
      sockets.add(socket);
      socket.listen((raw) {
        onFrame?.call(
          socket,
          jsonDecode(raw as String) as Map<String, dynamic>,
        );
      });
    });
  }

  Uri get uri => Uri.parse('ws://127.0.0.1:${http.port}/ws/tickets');
  int get connections => sockets.length;

  Future<void> stop() async {
    for (final s in sockets) {
      await s.close();
    }
    await http.close(force: true);
  }
}

class _TestSocket extends TicketsSocket {
  _TestSocket(this._uri);
  final Uri _uri;
  @override
  Uri get endpoint => _uri;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late _Server server;
  late _TestSocket socket;

  /// Waits until [test] is true, polling real time — these are real sockets.
  Future<void> until(bool Function() test, {int ms = 3000}) async {
    final deadline = DateTime.now().add(Duration(milliseconds: ms));
    while (!test()) {
      if (DateTime.now().isAfter(deadline)) {
        fail('timed out waiting for condition');
      }
      await Future<void>.delayed(const Duration(milliseconds: 10));
    }
  }

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await SharedPreferenceHelper().init();
    // Written explicitly every time: `init()` keeps the first instance, so
    // seeding the mock store only works for whichever test runs first.
    await SharedPreferenceHelper().storedata(
      StorageKeys.sessionCookie,
      'abc123',
    );
    server = _Server();
    await server.start();
    socket = _TestSocket(server.uri)
      ..baseBackoff = const Duration(milliseconds: 50);
  });

  tearDown(() async {
    await socket.dispose();
    await server.stop();
  });

  test('the upgrade carries the session cookie (§3)', () async {
    socket.connect();
    await until(() => socket.currentStatus == SocketStatus.live);
    expect(server.cookies.single, 'mobile_session_id=abc123');
  });

  test('connecting twice opens one connection', () async {
    socket.connect();
    socket.connect();
    await until(() => socket.currentStatus == SocketStatus.live);
    await Future<void>.delayed(const Duration(milliseconds: 100));
    expect(server.connections, 1);
  });

  group('request / ack', () {
    setUp(() async {
      socket.connect();
      await until(() => socket.currentStatus == SocketStatus.live);
    });

    test('an ok ack resolves with its data, matched by id', () async {
      server.onFrame = (ws, f) => ws.add(
        jsonEncode({
          'event': 'ack',
          'id': f['id'],
          'ok': true,
          'data': {'echo': f['action']},
        }),
      );
      final data = await socket.send('history.get', {'ticketId': 't1'});
      expect(data, {'echo': 'history.get'});
    });

    test('a failed ack becomes a SocketError carrying its code', () async {
      server.onFrame = (ws, f) => ws.add(
        jsonEncode({
          'event': 'ack',
          'id': f['id'],
          'ok': false,
          'error': {'code': 'TICKET_RESOLVED', 'message': 'Closed.'},
        }),
      );
      await expectLater(
        socket.send('message.send', {}),
        throwsA(
          isA<SocketError>().having((e) => e.isResolved, 'isResolved', true),
        ),
      );
    });

    test('concurrent requests are each matched to their own ack', () async {
      // Replies arrive in REVERSE order, so only id-matching gets this right.
      final held = <Map<String, dynamic>>[];
      WebSocket? ws;
      server.onFrame = (s, f) {
        ws = s;
        held.add(f);
        if (held.length == 2) {
          for (final frame in held.reversed) {
            s.add(
              jsonEncode({
                'event': 'ack',
                'id': frame['id'],
                'ok': true,
                'data': {'for': frame['payload']['n']},
              }),
            );
          }
        }
      };
      final results = await Future.wait([
        socket.send('a', {'n': 1}),
        socket.send('b', {'n': 2}),
      ]);
      expect(ws, isNotNull);
      expect(results[0], {'for': 1});
      expect(results[1], {'for': 2});
    });

    test('a request nobody answers times out rather than hanging', () async {
      socket.requestTimeout = const Duration(milliseconds: 100);
      server.onFrame = (_, _) {}; // never acks
      await expectLater(
        socket.send('history.get', {}),
        throwsA(isA<SocketError>().having((e) => e.code, 'code', 'TIMEOUT')),
      );
    });

    test(
      'pushed events reach the stream and are not mistaken for acks',
      () async {
        final seen = <SocketEvent>[];
        final sub = socket.events.listen(seen.add);
        server.sockets.single.add(
          jsonEncode({
            'event': 'ticket.message',
            'ticketId': 't9',
            'data': {
              'message': {'id': 'm1'},
            },
          }),
        );
        await until(() => seen.isNotEmpty);
        expect(seen.single.event, 'ticket.message');
        expect(seen.single.ticketId, 't9');
        await sub.cancel();
      },
    );
  });

  group('connection loss', () {
    test('sending while offline fails fast with a clear error', () async {
      // Never connected.
      await expectLater(
        socket.send('history.get', {}),
        throwsA(isA<SocketError>().having((e) => e.code, 'code', 'OFFLINE')),
      );
    });

    test('a dropped connection reconnects with backoff', () async {
      socket.connect();
      await until(() => socket.currentStatus == SocketStatus.live);
      expect(server.connections, 1);

      await server.sockets.first.close(1001); // going away: not a session death
      await until(() => server.connections == 2);
      await until(() => socket.currentStatus == SocketStatus.live);
    });

    test(
      'in-flight requests fail immediately when the connection drops',
      () async {
        socket.connect();
        await until(() => socket.currentStatus == SocketStatus.live);
        server.onFrame = (ws, _) => ws.close(1001);
        await expectLater(
          socket.send('history.get', {}),
          throwsA(isA<SocketError>().having((e) => e.code, 'code', 'OFFLINE')),
        );
      },
    );

    test(
      'close code 4401 means the session died: tell the app, DO NOT retry',
      () async {
        socket.connect();
        await until(() => socket.currentStatus == SocketStatus.live);

        var expired = 0;
        final sub = SessionExpiry.instance.stream.listen((_) => expired++);

        await server.sockets.first.close(4401);
        await until(() => expired == 1);

        // Plenty of time for several backoff rounds (50ms base) — none may
        // happen, or a dead cookie would be hammered forever.
        await Future<void>.delayed(const Duration(milliseconds: 500));
        expect(
          server.connections,
          1,
          reason: 'reconnecting blindly is the bug',
        );
        expect(socket.currentStatus, SocketStatus.offline);
        await sub.cancel();
      },
    );

    test('disconnect() closes for good and does not reconnect', () async {
      socket.connect();
      await until(() => socket.currentStatus == SocketStatus.live);
      await socket.disconnect();
      expect(socket.currentStatus, SocketStatus.idle);
      await Future<void>.delayed(const Duration(milliseconds: 400));
      expect(server.connections, 1);
    });

    test('with no stored session it does not even try to connect', () async {
      // `SharedPreferenceHelper.init()` is `??=`, so re-seeding the mock
      // store does nothing once an instance exists — remove the cookie.
      await SharedPreferenceHelper().remove(StorageKeys.sessionCookie);
      socket.connect();
      await Future<void>.delayed(const Duration(milliseconds: 200));
      expect(server.connections, 0, reason: 'the upgrade would only 401');
      expect(socket.currentStatus, SocketStatus.offline);
    });
  });

  group('guards', () {
    setUp(() async {
      socket.connect();
      await until(() => socket.currentStatus == SocketStatus.live);
    });

    test(
      'an oversized frame fails locally instead of killing the socket',
      () async {
        await expectLater(
          socket.send('message.send', {'body': 'x' * (70 * 1024)}),
          throwsA(
            isA<SocketError>().having((e) => e.code, 'code', 'FRAME_TOO_LARGE'),
          ),
        );
        expect(socket.currentStatus, SocketStatus.live);
      },
    );

    test('the 30-per-10s budget is enforced client-side', () async {
      server.onFrame = (ws, f) => ws.add(
        jsonEncode({'event': 'ack', 'id': f['id'], 'ok': true, 'data': {}}),
      );
      for (var i = 0; i < 30; i++) {
        await socket.send('x', {});
      }
      await expectLater(
        socket.send('x', {}),
        throwsA(
          isA<SocketError>().having(
            (e) => e.isRateLimited,
            'rateLimited',
            true,
          ),
        ),
      );
    });

    test(
      'whenLive resolves true when already live, false after a dead wait',
      () async {
        expect(await socket.whenLive(), isTrue);
        await socket.disconnect();
        expect(
          await socket.whenLive(timeout: const Duration(milliseconds: 80)),
          isFalse,
        );
      },
    );
  });
}
