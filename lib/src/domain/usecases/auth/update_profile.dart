import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/auth/user_model.dart';
import 'package:finskool/src/domain/repository/auth_repository.dart';

/// Edit Profile's save. Local-only — the API has no profile-update
/// endpoint, so this updates and re-persists the cached [UserModel].
@lazySingleton
class UpdateProfile {
  UpdateProfile(this._repository);

  final AuthRepository _repository;

  Future<Either<Failure, UserModel>> execute({
    required String name,
    required String email,
    required String phone,
  }) =>
      _repository.updateProfile(name: name, email: email, phone: phone);
}
