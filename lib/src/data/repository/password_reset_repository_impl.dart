import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/error_handler.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/data/datasource/password_reset_remote_datasource.dart';
import 'package:finskool/src/domain/model/auth/reset_cypher_model.dart';
import 'package:finskool/src/domain/repository/password_reset_repository.dart';

@LazySingleton(as: PasswordResetRepository)
class PasswordResetRepositoryImpl implements PasswordResetRepository {
  PasswordResetRepositoryImpl(this._remote);

  final PasswordResetRemoteDatasource _remote;

  @override
  Future<Either<Failure, Unit>> sendResetCode(String email) =>
      handleErrors(() async {
        await _remote.sendResetCode(email);
        return unit;
      });

  @override
  Future<Either<Failure, ResetCypherModel>> verifyResetCode({
    required String email,
    required String otp,
  }) =>
      handleErrors(() => _remote.verifyResetOtp(email: email, otp: otp));

  @override
  Future<Either<Failure, Unit>> resetPassword({
    required String cypher,
    required String newPassword,
    required String confirmNewPassword,
  }) =>
      handleErrors(() async {
        await _remote.resetPassword(
          cypher: cypher,
          newPassword: newPassword,
          confirmNewPassword: confirmNewPassword,
        );
        return unit;
      });
}
