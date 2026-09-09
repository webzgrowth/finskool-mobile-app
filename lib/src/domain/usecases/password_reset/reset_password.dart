import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/repository/password_reset_repository.dart';

/// Step 3 of 3. Consumes the cypher even on failure — a retry needs a fresh
/// code, so callers must send the user back to step 2 rather than re-submit.
@lazySingleton
class ResetPassword {
  ResetPassword(this._repository);

  final PasswordResetRepository _repository;

  Future<Either<Failure, Unit>> execute({
    required String cypher,
    required String newPassword,
    required String confirmNewPassword,
  }) =>
      _repository.resetPassword(
        cypher: cypher,
        newPassword: newPassword,
        confirmNewPassword: confirmNewPassword,
      );
}
