import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/auth/user_model.dart';
import 'package:finskool/src/domain/repository/auth_repository.dart';

/// Re-reads the signed-in user from the server, which is also the only
/// positive check that the session is still valid.
@lazySingleton
class RefreshSession {
  RefreshSession(this._repository);

  final AuthRepository _repository;

  Future<Either<Failure, UserModel>> execute() => _repository.refreshSession();
}
