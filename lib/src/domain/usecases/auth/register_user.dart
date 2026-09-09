import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/auth/register_request_model.dart';
import 'package:finskool/src/domain/model/auth/register_result_model.dart';
import 'package:finskool/src/domain/repository/auth_repository.dart';

/// Creates an unverified account and triggers the signup OTP.
@lazySingleton
class RegisterUser {
  RegisterUser(this._repository);

  final AuthRepository _repository;

  Future<Either<Failure, RegisterResultModel>> execute(
          RegisterRequestModel request) =>
      _repository.register(request);
}
