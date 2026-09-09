import 'package:dartz/dartz.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/auth/reset_cypher_model.dart';

/// The contract for the three-step forgot-password flow. Implemented by
/// `data/repository/password_reset_repository_impl.dart`.
abstract class PasswordResetRepository {
  Future<Either<Failure, Unit>> sendResetCode(String email);

  Future<Either<Failure, ResetCypherModel>> verifyResetCode({
    required String email,
    required String otp,
  });

  Future<Either<Failure, Unit>> resetPassword({
    required String cypher,
    required String newPassword,
    required String confirmNewPassword,
  });
}
