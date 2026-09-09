import 'package:dio/dio.dart';
import 'package:finskool/src/comman/storage_keys.dart';
import 'package:finskool/src/utilities/shared_pref_helper.dart';

/// Mobile auth is **cookie-based, not a Bearer token** — `POST /login`
/// returns no token in its body, it sets an httpOnly `mobile_session_id`
/// cookie and that cookie *is* the credential (see `docs/auth_api_doc.md`
/// §2). This interceptor is the whole session mechanism: it lifts the cookie
/// off `Set-Cookie`, persists the opaque value, and replays it as a `Cookie`
/// header on every later request. There is no refresh/rotation step.
///
/// Prefs are read *inside* the callbacks, never in the constructor: blocs are
/// registered eagerly (`gh.singleton`), so this object can be built before
/// `SharedPreferenceHelper().init()` has completed.
class SessionInterceptor extends Interceptor {
  static const _cookieName = 'mobile_session_id';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final session = SharedPreferenceHelper().getdata(StorageKeys.sessionCookie);
    if (session != null && session.isNotEmpty) {
      options.headers['Cookie'] = '$_cookieName=$session';
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _captureCookie(response);
    _clearOnInvalidatedSession(response);
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final response = err.response;
    if (response != null) {
      _captureCookie(response);
      _clearOnInvalidatedSession(response);
    }
    handler.next(err);
  }

  void _captureCookie(Response response) {
    final headers = response.headers.map['set-cookie'];
    if (headers == null) return;

    for (final header in headers) {
      final value = _readCookieValue(header);
      if (value == null) continue;

      // Logout clears the cookie by sending an expired one back.
      if (value.isEmpty || _isExpired(header)) {
        SharedPreferenceHelper().remove(StorageKeys.sessionCookie);
      } else {
        SharedPreferenceHelper().storedata(StorageKeys.sessionCookie, value);
      }
      return;
    }
  }

  /// One active session per account — logging in on another device kills
  /// this one. Drop the dead cookie so the app falls back to signed-out
  /// instead of retrying with a credential the server has already discarded.
  void _clearOnInvalidatedSession(Response response) {
    if (response.statusCode != 401) return;
    final body = response.data;
    if (body is Map && body['code'] == 'SESSION_INVALIDATED') {
      SharedPreferenceHelper().remove(StorageKeys.sessionCookie);
    }
  }

  String? _readCookieValue(String header) {
    for (final part in header.split(';')) {
      final pair = part.trim();
      if (pair.startsWith('$_cookieName=')) {
        return pair.substring(_cookieName.length + 1);
      }
    }
    return null;
  }

  bool _isExpired(String header) {
    final lower = header.toLowerCase();
    return lower.contains('max-age=0') || lower.contains('expires=thu, 01 jan 1970');
  }
}
