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
    // A Razorpay proof — not needed in a log line, and the signature is what
    // authorises a payment.
    'razorpaySignature',
    'razorpayPaymentId',
    // KYC: the PAN and date of birth are personal data, in both directions.
    'panNumber',
    'dateOfBirth',
  };

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.debug(
      '→ ${options.method} ${options.uri}  ${_redact(options.data)}',
    );
    logger.debug('→ headers ${_safeHeaders(options.headers)}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // The checkout URL's `#t=` token is a credential (single use, but live
    // for two minutes), so that body is never printed.
    final body = response.requestOptions.path.contains('checkout-sessions')
        ? '<checkout session redacted>'
        : _redact(response.data);
    logger.debug(
      '← ${response.statusCode} ${response.requestOptions.uri}  $body',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final req = err.requestOptions;
    // A 5xx lands here (4xx are returned as ordinary responses). Print enough
    // to hand to the backend: what was sent *and* what they answered.
    logger.error(
      '✗ ${err.type.name} ${req.method} ${req.uri}\n'
      '   status:   ${err.response?.statusCode}\n'
      '   request:  ${_redact(req.data)}\n'
      '   headers:  ${_safeHeaders(req.headers)}\n'
      '   response: ${_redact(err.response?.data)}\n'
      '   message:  ${err.message}',
    );
    handler.next(err);
  }

  /// Headers for a log line — the session cookie is the credential, so it is
  /// masked; everything else (content type, idempotency key…) is shown.
  Map<String, dynamic> _safeHeaders(Map<String, dynamic> headers) => {
    for (final e in headers.entries)
      e.key: e.key.toLowerCase() == 'cookie' ? '<session cookie>' : e.value,
  };

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
