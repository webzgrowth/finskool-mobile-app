import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/repository/auth_repository.dart';

/// Confirms the signup OTP. Does not create a session — log in afterwards.
@lazySingleton
class VerifyOtp {
  VerifyOtp(this._repository);

  final AuthRepository _repository;

  Future<Either<Failure, Unit>> execute({
    required String userId,
    required String otp,
  }) =>
      _repository.verifyOtp(userId: userId, otp: otp);
}
