import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/auth/social_models.dart';
import 'package:finskool/src/domain/repository/social_auth_repository.dart';

/// Gets the provider's ID token and asks the server what to do with it.
@lazySingleton
class SocialSignIn {
  SocialSignIn(this._repository);

  final SocialAuthRepository _repository;

  Future<Either<Failure, SocialLoginResult>> execute(SocialProvider provider) =>
      _repository.signIn(provider);
}
