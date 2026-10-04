import 'package:dio/dio.dart';
import 'package:finskool/src/comman/exception.dart';

/// The envelope every endpoint shares: `{ success, data, message, code, errors }`.
///
/// Extracted from `ApiClient` so that every verb — get, post, put, delete —
/// shares one error path, and so a `data` payload that is a top-level JSON
/// array (`GET /mobile/reaction-types`) can be unwrapped by the same code
/// that unwraps an object.
///
/// Returns the raw `data` (a `Map`, a `List`, or null) on success and throws
/// [ApiException] otherwise. Callers narrow the type.
Object? unwrapEnvelope(Response<dynamic> response) {
  final body = response.data;

  if (body is! Map) {
    throw ApiException(
      'Unexpected response from the server.',
      statusCode: response.statusCode,
    );
  }

  if (body['success'] == true) return body['data'];

  throw ApiException(
    body['message'] as String? ?? 'Something went wrong. Please try again.',
    code: body['code'] as String?,
    errors: parseFieldErrors(body['errors']),
    statusCode: response.statusCode,
  );
}

/// `{"email": ["Invalid email address"]}` from a 422.
Map<String, List<String>>? parseFieldErrors(Object? errors) {
  if (errors is! Map) return null;
  return {
    for (final entry in errors.entries)
      entry.key.toString(): entry.value is List
          ? (entry.value as List).map((m) => m.toString()).toList()
          : [entry.value.toString()],
  };
}
