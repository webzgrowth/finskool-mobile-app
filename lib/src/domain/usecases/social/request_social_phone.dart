import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/auth/social_models.dart';
import 'package:finskool/src/domain/repository/social_auth_repository.dart';

/// Sends the WhatsApp code to a new social member's phone.
@lazySingleton
class RequestSocialPhone {
  RequestSocialPhone(this._repository);

  final SocialAuthRepository _repository;

  Future<Either<Failure, SocialOtpChallenge>> execute({
    required String signupToken,
    required String phone,
    String? fullName,
  }) => _repository.requestPhone(
    signupToken: signupToken,
    phone: phone,
    fullName: fullName,
  );
}
