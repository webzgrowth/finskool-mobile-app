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
    // The backend answered, and said no. Preserve `code` — it's what the
    // UI branches on — and promote a 422 to a ValidationFailure so per-field
    // messages survive all the way to the form.
    final errors = e.errors;
    if (errors != null && errors.isNotEmpty) {
      return Left(ValidationFailure(
        messageForCode(e.code, e.message),
        errors: errors,
        code: e.code,
      ));
    }
    return Left(ServerFailure(messageForCode(e.code, e.message), code: e.code));
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

/// Maps the codes documented in `docs/auth_api_doc.md` to copy that tells the
/// user what to *do*. Anything unrecognised falls through to the server's own
/// message, which is already human-readable.
String messageForCode(String? code, String fallback) {
  switch (code) {
    // -- registration --
    case 'ALREADY_REGISTERED':
      return 'This number is already registered. Try logging in instead.';
    case 'EMAIL_TAKEN':
      return 'That email is already in use.';
    case 'PHONE_INACTIVE':
      return 'This number has been deactivated. Please contact support.';
    // -- login --
    case 'NOT_REGISTERED':
      return 'No account found for that email. Please sign up first.';
    case 'PHONE_NOT_VERIFIED':
      return 'Your number isn\'t verified yet. Please verify it to continue.';
    case 'SUBSCRIPTION_EXPIRED':
      return 'Your subscription has expired. Renew it to continue.';
    case 'SESSION_INVALIDATED':
      return 'You were signed out because your account was used on another '
          'device.';
    // -- OTP --
    case 'OTP_INVALID':
      return 'That code isn\'t right. Please check and try again.';
    case 'OTP_EXPIRED':
      return 'That code has expired. Request a new one.';
    case 'OTP_LOCKED':
      return 'Too many incorrect attempts. Request a new code.';
    case 'OTP_COOLDOWN':
      // The server's message names the exact remaining seconds — keep it.
      return fallback;
    case 'ALREADY_VERIFIED':
      return 'This number is already verified. Please log in.';
    // -- password reset --
    case 'RESET_TOKEN_INVALID':
      return 'That reset link has expired. Please request a new code.';
    // -- communities --
    case 'COMMUNITY_ACCESS_DENIED':
      return 'You don\'t have access to that community.';
    default:
      return fallback;
  }
}
