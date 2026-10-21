import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/exception.dart';
import 'package:finskool/src/data/api/api.dart';
import 'package:finskool/src/data/api/api_envelope.dart';
import 'package:finskool/src/data/api/api_logging_interceptor.dart';
import 'package:finskool/src/data/api/session_interceptor.dart';

/// The one [Dio] instance, plus the envelope unwrapping every endpoint
/// shares: `{ success, data, message, code, errors }`.
///
/// Datasources call [post], [get], [put] or [delete] and get back the `data` payload — or an
/// `ApiException`. They never see a [Response] or a status code.
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
    )..interceptors.addAll([SessionInterceptor(), ApiLoggingInterceptor()]);
  }

  late final Dio _dio;

  /// [headers] exists for `Idempotency-Key`, which `POST /mobile/tickets`
  /// requires: one per form submission, **reused on retry**, so a timeout or
  /// a double tap can't raise two tickets.
  Future<Map<String, dynamic>?> post(
    String path, {
    Object? body,
    Map<String, String>? headers,
  }) async => _asMap(
    await _dio.post<dynamic>(
      path,
      data: body,
      options: headers == null ? null : Options(headers: headers),
    ),
  );

  Future<Map<String, dynamic>?> get(
    String path, {
    Map<String, dynamic>? query,
  }) async => _asMap(await _dio.get<dynamic>(path, queryParameters: query));

  Future<Map<String, dynamic>?> put(String path, {Object? body}) async =>
      _asMap(await _dio.put<dynamic>(path, data: body));

  Future<Map<String, dynamic>?> delete(String path, {Object? body}) async =>
      _asMap(await _dio.delete<dynamic>(path, data: body));

  /// For the endpoints whose `data` is a top-level JSON **array** rather than
  /// an object — `GET /mobile/reaction-types`. [get] maps such a payload to
  /// null, so reaching for it there silently loses the whole response.
  Future<List<dynamic>?> getList(
    String path, {
    Map<String, dynamic>? query,
  }) async => _asList(await _dio.get<dynamic>(path, queryParameters: query));

  /// PUTs raw bytes to a **presigned storage URL**, outside this API.
  ///
  /// It deliberately uses its own `Dio`, not [_dio]: the URL is absolute
  /// (so the base URL is wrong), the body is raw bytes rather than the
  /// `{success, data}` envelope (so the unwrapping is wrong), and — the part
  /// that matters — `SessionInterceptor` would attach our `mobile_session_id`
  /// cookie, **sending the app's credential to a third-party host**. The
  /// link is valid about 5 minutes, so presign immediately before uploading.
  static Future<void> putBytes(
    String uploadUrl,
    List<int> bytes, {
    required String contentType,
  }) async {
    final response = await Dio().put<dynamic>(
      uploadUrl,
      data: Stream.fromIterable([bytes]),
      options: Options(
        headers: {
          Headers.contentTypeHeader: contentType,
          Headers.contentLengthHeader: bytes.length,
        },
        // Storage answers 200/204 with no body; anything else is a failure
        // we want as an exception rather than a silent success.
        validateStatus: (status) => status != null && status < 300,
      ),
    );
    if (response.statusCode == null) {
      throw ApiException('The upload did not complete. Please try again.');
    }
  }

  /// Returns the `data` object on success, throws `ApiException` otherwise.
  /// Endpoints such as `/logout` and `/select-community` legitimately answer
  /// `{ success: true }` with no `data` — hence the nullable return.
  Map<String, dynamic>? _asMap(Response<dynamic> response) {
    final data = unwrapEnvelope(response);
    return data is Map ? Map<String, dynamic>.from(data) : null;
  }

  List<dynamic>? _asList(Response<dynamic> response) {
    final data = unwrapEnvelope(response);
    return data is List ? List<dynamic>.from(data) : null;
  }
}
