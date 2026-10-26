import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/auth/user_model.dart';
import 'package:finskool/src/domain/repository/auth_repository.dart';

/// Edit Profile's photo change — a path to set it, null to remove it.
/// Local-only: the API has no avatar-upload endpoint.
@lazySingleton
class UpdateAvatar {
  UpdateAvatar(this._repository);

  final AuthRepository _repository;

  Future<Either<Failure, UserModel>> execute(String? sourcePath) =>
      _repository.updateAvatar(sourcePath);
}
