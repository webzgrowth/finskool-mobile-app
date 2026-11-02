import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/auth/user_model.dart';
import 'package:finskool/src/domain/repository/auth_repository.dart';

/// Edit Profile's photo change: uploads the picked file and saves it on the
/// account. The API can replace a picture but not remove one.
@lazySingleton
class UpdateAvatar {
  UpdateAvatar(this._repository);

  final AuthRepository _repository;

  Future<Either<Failure, UserModel>> execute(String sourcePath) =>
      _repository.updateAvatar(sourcePath);
}
