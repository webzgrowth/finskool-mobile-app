import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/repository/password_reset_repository.dart';

/// Step 1 of 3. Always succeeds, whether or not the email exists.
@lazySingleton
class SendResetCode {
  SendResetCode(this._repository);

  final PasswordResetRepository _repository;

  Future<Either<Failure, Unit>> execute(String email) =>
      _repository.sendResetCode(email);
}
