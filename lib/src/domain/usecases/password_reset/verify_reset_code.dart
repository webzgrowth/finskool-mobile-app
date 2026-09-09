import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/auth/reset_cypher_model.dart';
import 'package:finskool/src/domain/repository/password_reset_repository.dart';

/// Step 2 of 3. Returns the single-use cypher the reset call consumes.
@lazySingleton
class VerifyResetCode {
  VerifyResetCode(this._repository);

  final PasswordResetRepository _repository;

  Future<Either<Failure, ResetCypherModel>> execute({
    required String email,
    required String otp,
  }) =>
      _repository.verifyResetCode(email: email, otp: otp);
}
