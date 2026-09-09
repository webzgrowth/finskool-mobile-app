import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/repository/auth_repository.dart';

/// Ends the session server-side and clears the cached credential.
@lazySingleton
class LogoutUser {
  LogoutUser(this._repository);

  final AuthRepository _repository;

  Future<Either<Failure, Unit>> execute() => _repository.logout();
}
