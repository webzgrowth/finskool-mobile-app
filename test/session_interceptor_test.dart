import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:finskool/src/comman/storage_keys.dart';
import 'package:finskool/src/data/api/session_interceptor.dart';
import 'package:finskool/src/utilities/shared_pref_helper.dart';

/// Mobile auth has no token — the `mobile_session_id` cookie *is* the
/// credential — so this is the single most load-bearing piece of the
/// networking layer. Exercised against a real local HTTP server rather than a
/// mock, so the actual `Set-Cookie` header parsing is what's under test.
void main() {
  late HttpServer server;
  late Dio dio;

  /// The `Cookie` header the server saw on the most recent request.
  String? seenCookie;

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    HttpOverrides.global = null;
    SharedPreferences.setMockInitialValues({});
    await SharedPreferenceHelper().init();
    // SharedPreferenceHelper caches its SharedPreferences in a static field,
    // so setMockInitialValues alone doesn't reset state between tests.
    await SharedPreferenceHelper().clear();
    seenCookie = null;

    server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    server.listen((request) async {
      seenCookie = request.headers.value('cookie');
      final response = request.response
        ..statusCode = 200
        ..headers.contentType = ContentType.json;

      switch (request.uri.path) {
        case '/login':
          response.headers.add('set-cookie',
              'mobile_session_id=abc123xyz; Path=/; HttpOnly; Max-Age=34560000');
          response.write(jsonEncode({'success': true, 'data': {}}));
        case '/logout':
          // Verbatim from the live backend — it expires the cookie with an
          // Expires date, not Max-Age=0.
          response.headers.add(
              'set-cookie',
              'mobile_session_id=; Path=/; Expires=Thu, 01 Jan 1970 00:00:00 '
                  'GMT; HttpOnly; SameSite=Lax');
          response.write(jsonEncode({'success': true}));
        case '/stale':
          response.statusCode = 401;
          response.write(jsonEncode(
              {'success': false, 'code': 'SESSION_INVALIDATED'}));
        default:
          response.write(jsonEncode({'success': true, 'data': {}}));
      }
      await response.close();
    });

    dio = Dio(BaseOptions(
      baseUrl: 'http://${server.address.host}:${server.port}',
      validateStatus: (s) => s != null && s < 500,
    ))
      ..interceptors.add(SessionInterceptor());
  });

  tearDown(() => server.close(force: true));

  String? storedCookie() =>
      SharedPreferenceHelper().getdata(StorageKeys.sessionCookie);

  test('captures the session cookie off Set-Cookie on login', () async {
    expect(storedCookie(), isNull);
    await dio.post<dynamic>('/login');
    expect(storedCookie(), 'abc123xyz',
        reason: 'the opaque value only, without attributes');
  });

  test('replays it as a Cookie header on every later request', () async {
    await dio.post<dynamic>('/login');
    await dio.get<dynamic>('/feed');
    expect(seenCookie, 'mobile_session_id=abc123xyz');
  });

  test('survives a new client — i.e. an app restart', () async {
    await dio.post<dynamic>('/login');

    // A fresh Dio + interceptor, as if the app had been killed and relaunched
    // against the same persisted prefs.
    final restarted = Dio(BaseOptions(baseUrl: dio.options.baseUrl))
      ..interceptors.add(SessionInterceptor());
    await restarted.get<dynamic>('/feed');

    expect(seenCookie, 'mobile_session_id=abc123xyz');
  });

  test('logout clears it — the server sends an expired Set-Cookie', () async {
    await dio.post<dynamic>('/login');
    await dio.post<dynamic>('/logout');
    expect(storedCookie(), isNull);
  });

  test('a 401 SESSION_INVALIDATED drops the dead cookie', () async {
    await dio.post<dynamic>('/login');
    await dio.get<dynamic>('/stale');
    expect(storedCookie(), isNull,
        reason: 'logged in on another device — do not keep retrying');
  });

  test('sends no Cookie header when signed out', () async {
    await dio.get<dynamic>('/feed');
    expect(seenCookie, isNull);
  });
}
