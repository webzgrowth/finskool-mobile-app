class ServerException implements Exception {
  ServerException(this.message);

  final String message;
}

class DatabaseException implements Exception {
  DatabaseException(this.message);

  final String message;
}

class CacheException implements Exception {
  CacheException(this.message);

  final String message;
}

/// Thrown by `ApiClient` when the backend answers with `success: false`.
///
/// [code] is the machine-readable string the API sends alongside the human
/// message (`OTP_INVALID`, `EMAIL_TAKEN`, `SESSION_INVALIDATED`, …) — it's
/// what lets the UI branch, since [message] is prose and may change.
/// [errors] carries the per-field map from a `422` validation response,
/// e.g. `{"email": ["Invalid email address"]}`.
class ApiException implements Exception {
  ApiException(
    this.message, {
    this.code,
    this.errors,
    this.statusCode,
  });

  final String message;
  final String? code;
  final Map<String, List<String>>? errors;
  final int? statusCode;

  @override
  String toString() => 'ApiException($statusCode, $code): $message';
}
