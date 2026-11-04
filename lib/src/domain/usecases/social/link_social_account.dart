import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/auth/auth_session_model.dart';
import 'package:finskool/src/domain/repository/social_auth_repository.dart';

/// Links the provider to the existing account whose password the member gave.
@lazySingleton
class LinkSocialAccount {
  LinkSocialAccount(this._repository);

  final SocialAuthRepository _repository;

  Future<Either<Failure, AuthSessionModel>> execute({
    required String linkToken,
    required String password,
  }) => _repository.link(linkToken: linkToken, password: password);
}
