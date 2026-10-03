import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/auth/user_model.dart';
import 'package:finskool/src/domain/repository/auth_repository.dart';

/// Profile screen's Notifications toggle. Local-only — no backend field
/// exists yet, so this updates and re-persists the cached [UserModel].
@lazySingleton
class SetPostNotificationsEnabled {
  SetPostNotificationsEnabled(this._repository);

  final AuthRepository _repository;

  Future<Either<Failure, UserModel>> execute(bool enabled) =>
      _repository.setPostNotificationsEnabled(enabled);
}
