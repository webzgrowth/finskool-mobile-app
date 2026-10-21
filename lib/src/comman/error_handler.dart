import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:finskool/src/comman/exception.dart';
import 'package:finskool/src/comman/failure.dart';

/// Wraps a datasource call so repositories can stay one-liners. Everything
/// below the repository layer *throws*; everything above it gets an
/// `Either<Failure, T>`.
Future<Either<Failure, T>> handleErrors<T>(Future<T> Function() action) async {
  try {
    return Right(await action());
  } on ApiException catch (e) {
    // The backend answered, and said no. Its `message` is shown to the user
    // **verbatim** — the backend is the single source of truth for failure
    // copy, so there is deliberately no client-side code-to-copy mapping
    // here. Preserve `code` too: the UI branches on it.
    //
    // A 422 is promoted to a ValidationFailure so per-field messages survive
    // all the way to the form.
    final errors = e.errors;
    if (errors != null && errors.isNotEmpty) {
      return Left(ValidationFailure(e.message, errors: errors, code: e.code));
    }
    return Left(ServerFailure(e.message, code: e.code));
  } on ServerException catch (e) {
    return Left(ServerFailure(e.message));
  } on SocketException {
    return const Left(ConnectionFailure('No internet connection.'));
  } on DioException catch (e) {
    return Left(ServerFailure(_dioMessage(e)));
  } catch (e) {
    return Left(ServerFailure(e.toString()));
  }
}

/// `ApiClient` sets `validateStatus` to let 4xx bodies through, so a
/// DioException here means the request never completed — timeout, DNS, TLS,
/// or a 5xx. None of those have a useful server message.
String _dioMessage(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return 'The request timed out. Please try again.';
    case DioExceptionType.connectionError:
      return 'Could not reach the server. Check your connection.';
    case DioExceptionType.badCertificate:
      return 'Could not establish a secure connection.';
    case DioExceptionType.cancel:
      return 'Request cancelled.';
    default:
      return 'Something went wrong on our end. Please try again.';
  }
}
