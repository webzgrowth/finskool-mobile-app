import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/auth/auth_session_model.dart';
import 'package:finskool/src/domain/repository/auth_repository.dart';

/// Exchanges credentials for the `mobile_session_id` cookie.
@lazySingleton
class LoginUser {
  LoginUser(this._repository);

  final AuthRepository _repository;

  Future<Either<Failure, AuthSessionModel>> execute({
    required String email,
    required String password,
  }) =>
      _repository.login(email: email, password: password);
}
