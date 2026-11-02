import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:finskool/src/comman/storage_keys.dart';
import 'package:finskool/src/data/api/session_expiry.dart';
import 'package:finskool/src/data/socket/notifications_socket.dart';
import 'package:finskool/src/utilities/shared_pref_helper.dart';

/// A real WebSocket server on localhost, so the cookie on the upgrade, the
/// frame parsing, the 4401 rule and the reconnect are exercised on the actual
/// `IOWebSocketChannel`.
class _Server {
  late final HttpServer http;
  final cookies = <String?>[];
  final sockets = <WebSocket>[];

  Future<void> start() async {
    http = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    http.listen((request) async {
      cookies.add(request.headers.value('cookie'));
      sockets.add(await WebSocketTransformer.upgrade(request));
    });
  }

  Uri get uri => Uri.parse('ws://127.0.0.1:${http.port}/ws/notifications');

  Future<void> stop() async {
    for (final s in sockets) {
      await s.close();
    }
    await http.close(force: true);
  }
}

class _TestSocket extends NotificationsSocket {
  _TestSocket(this._uri);
  final Uri _uri;
  @override
  Uri get endpoint => _uri;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late _Server server;
  late _TestSocket socket;

  Future<void> until(bool Function() test, {int ms = 3000}) async {
    final deadline = DateTime.now().add(Duration(milliseconds: ms));
    while (!test()) {
      if (DateTime.now().isAfter(deadline)) fail('timed out waiting');
      await Future<void>.delayed(const Duration(milliseconds: 10));
    }
  }

  String frame({int unread = 3}) => jsonEncode({
    'event': 'notification.created',
    'notification': {
      'id': 'n1',
      'type': 'ticket-update',
      'title': 'Support replied to your ticket',
      'message': 'We are looking into it',
      'data': {'type': 'ticket', 'id': 't1', 'event': 'reply'},
      'isRead': false,
      'createdAt': '2026-10-30T09:00:00.000Z',
    },
    'unreadCount': unread,
  });

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await SharedPreferenceHelper().init();
    // Written explicitly: `init()` keeps the first instance.
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
    await socket.disconnect();
    await server.stop();
  });

  test('the upgrade carries the session cookie', () async {
    socket.connect();
    await until(() => socket.isLive);
    expect(server.cookies.single, 'mobile_session_id=abc123');
  });

  test('a notification.created frame arrives with its unread total', () async {
    final seen = <NotificationEvent>[];
    socket.events.listen(seen.add);
    socket.connect();
    await until(() => socket.isLive);
    server.sockets.single.add(frame(unread: 7));
    await until(() => seen.isNotEmpty);
    expect(seen.single.unreadCount, 7);
    expect(seen.single.notification.id, 'n1');
    expect(seen.single.notification.data?['type'], 'ticket');
  });

  test('frames it does not understand are dropped, not fatal', () async {
    final seen = <NotificationEvent>[];
    socket.events.listen(seen.add);
    socket.connect();
    await until(() => socket.isLive);
    final s = server.sockets.single;
    s.add('not json');
    s.add(jsonEncode({'event': 'something.else'}));
    s.add(jsonEncode({'event': 'notification.created', 'notification': 5}));
    s.add(frame());
    await until(() => seen.isNotEmpty);
    expect(seen, hasLength(1));
  });

  test('close code 4401 reports the expiry and does NOT reconnect', () async {
    var expired = 0;
    final sub = SessionExpiry.instance.stream.listen((_) => expired++);
    addTearDown(sub.cancel);
    socket.connect();
    await until(() => socket.isLive);
    await server.sockets.single.close(4401, 'reauthenticate');
    await until(() => expired > 0);
    await Future<void>.delayed(const Duration(milliseconds: 300));
    expect(server.sockets, hasLength(1));
    expect(socket.isLive, isFalse);
  });

  test('any other close reconnects', () async {
    socket.connect();
    await until(() => socket.isLive);
    await server.sockets.single.close(1001);
    await until(() => server.sockets.length >= 2);
    await until(() => socket.isLive);
  });

  test('disconnect (logout) closes it and stays closed', () async {
    socket.connect();
    await until(() => socket.isLive);
    await socket.disconnect();
    await Future<void>.delayed(const Duration(milliseconds: 300));
    expect(socket.isLive, isFalse);
    expect(server.sockets, hasLength(1));
  });
}
