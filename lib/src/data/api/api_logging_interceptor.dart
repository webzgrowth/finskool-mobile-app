import 'package:dio/dio.dart';
import 'package:finskool/src/utilities/logger.dart';

/// Routes traffic through the app's own [logger], which already suppresses
/// itself in release builds.
///
/// Everything sensitive is redacted before it reaches a log line: passwords,
/// OTPs, the single-use password-reset `cypher`, and the session cookie
/// itself — which is the credential, so logging it would be the same as
/// logging a password.
class ApiLoggingInterceptor extends Interceptor {
  static const _redactedKeys = {
    'password',
    'confirmPassword',
    'newPassword',
    'confirmNewPassword',
    'otp',
    'cypher',
  };

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.debug('→ ${options.method} ${options.uri}  ${_redact(options.data)}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.debug('← ${response.statusCode} ${response.requestOptions.uri}  '
        '${_redact(response.data)}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.error('✗ ${err.type.name} ${err.requestOptions.uri}  ${err.message}');
    handler.next(err);
  }

  Object? _redact(Object? body) {
    if (body is! Map) return body;
    return {
      for (final entry in body.entries)
        entry.key: _redactedKeys.contains(entry.key)
            ? '***'
            : _redact(entry.value),
    };
  }
}
