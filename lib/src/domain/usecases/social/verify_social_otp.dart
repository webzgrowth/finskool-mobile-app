import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/auth/auth_session_model.dart';
import 'package:finskool/src/domain/repository/social_auth_repository.dart';

/// Confirms the WhatsApp code; on success the member is created and logged in.
@lazySingleton
class VerifySocialOtp {
  VerifySocialOtp(this._repository);

  final SocialAuthRepository _repository;

  Future<Either<Failure, AuthSessionModel>> execute({
    required String otpToken,
    required String otp,
  }) => _repository.verifyOtp(otpToken: otpToken, otp: otp);
}
