import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/repository/auth_repository.dart';

/// Requests a fresh signup OTP. Fails with `OTP_COOLDOWN` inside 60s.
@lazySingleton
class ResendOtp {
  ResendOtp(this._repository);

  final AuthRepository _repository;

  Future<Either<Failure, Unit>> execute(String userId) =>
      _repository.resendOtp(userId);
}
