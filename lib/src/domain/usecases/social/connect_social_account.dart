import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/auth/social_models.dart';
import 'package:finskool/src/domain/repository/social_auth_repository.dart';

/// Links Google or Apple to the account the member is logged in to.
@lazySingleton
class ConnectSocialAccount {
  ConnectSocialAccount(this._repository);

  final SocialAuthRepository _repository;

  Future<Either<Failure, List<String>>> execute(SocialProvider provider) =>
      _repository.connect(provider);
}
