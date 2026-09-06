import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:finskool/src/comman/exception.dart';

import 'package:finskool/src/comman/failure.dart';

Future<Either<Failure, T>> handleErrors<T>(Future<T> Function() action) async {
  try {
    final result = await action();
    return Right(result);
  } on ServerException catch (e) {
    return Left(ServerFailure(e.message));
  } on SocketException {
    return const Left(ConnectionFailure('No internet connection'));
  } on FirebaseAuthException catch (e) {
    return Left(ServerFailure(getMessageFromErrorCode(e.code, e.message)));
  } on DioException catch (e) {
    return Left(ServerFailure(e.response?.data['error'].toString() ??
        "Error occurred. Please try again."));
  } catch (e) {
    return Left(ServerFailure(e.toString()));
  }
}

String getMessageFromErrorCode(errorCode, errorMessage) {
  switch (errorCode) {
    case "invalid-credential":
      return "Invalid credential. Please try again.";
    case "email-already-exists":
      return "Email already exists. Use a different email.";
    case "invalid-email":
      return "Invalid email. Please enter a valid email.";
    case "too-many-requests":
      return "Too many requests. Try again later.";
    case "user-not-found":
      return "User not found. Please check your email.";
    case "invalid-password":
      return "Invalid password. Please try again.";
    case "email-already-in-use":
      return "Email already in use. Use a different email.";
    default:
      return errorMessage;
  }
}
