import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/exception.dart';
import 'package:finskool/src/data/api/api.dart';
import 'package:finskool/src/data/api/api_logging_interceptor.dart';
import 'package:finskool/src/data/api/session_interceptor.dart';

/// The one [Dio] instance, plus the envelope unwrapping every endpoint
/// shares: `{ success, data, message, code, errors }`.
///
/// Datasources call [post]/[get] and get back the `data` payload — or an
/// [ApiException]. They never see a [Response] or a status code.
@lazySingleton
class ApiClient {
  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: Api.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        // Let documented 4xx bodies through as ordinary responses instead of
        // DioExceptions. Without this the `code` field — OTP_INVALID,
        // EMAIL_TAKEN, SESSION_INVALIDATED — never reaches the UI, and every
        // failure collapses into one generic message.
        validateStatus: (status) => status != null && status < 500,
      ),
    )..interceptors.addAll([
        SessionInterceptor(),
        ApiLoggingInterceptor(),
      ]);
  }

  late final Dio _dio;

  Future<Map<String, dynamic>?> post(String path, {Object? body}) async {
    final response = await _dio.post<dynamic>(path, data: body);
    return _unwrap(response);
  }

  Future<Map<String, dynamic>?> get(
    String path, {
    Map<String, dynamic>? query,
  }) async {
    final response = await _dio.get<dynamic>(path, queryParameters: query);
    return _unwrap(response);
  }

  /// Returns the `data` object on success, throws [ApiException] otherwise.
  /// Endpoints such as `/logout` and `/select-community` legitimately answer
  /// `{ success: true }` with no `data` — hence the nullable return.
  Map<String, dynamic>? _unwrap(Response<dynamic> response) {
    final body = response.data;

    if (body is! Map) {
      throw ApiException(
        'Unexpected response from the server.',
        statusCode: response.statusCode,
      );
    }

    if (body['success'] == true) {
      final data = body['data'];
      return data is Map ? Map<String, dynamic>.from(data) : null;
    }

    throw ApiException(
      body['message'] as String? ?? 'Something went wrong. Please try again.',
      code: body['code'] as String?,
      errors: _parseFieldErrors(body['errors']),
      statusCode: response.statusCode,
    );
  }

  /// `{"email": ["Invalid email address"]}` from a 422.
  Map<String, List<String>>? _parseFieldErrors(Object? errors) {
    if (errors is! Map) return null;
    return {
      for (final entry in errors.entries)
        entry.key.toString(): entry.value is List
            ? (entry.value as List).map((m) => m.toString()).toList()
            : [entry.value.toString()],
    };
  }
}
