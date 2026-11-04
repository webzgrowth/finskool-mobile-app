import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/error_handler.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/data/datasource/social_auth_remote_datasource.dart';
import 'package:finskool/src/data/social/social_credential_source.dart';
import 'package:finskool/src/domain/model/auth/auth_session_model.dart';
import 'package:finskool/src/domain/model/auth/social_models.dart';
import 'package:finskool/src/domain/repository/auth_repository.dart';
import 'package:finskool/src/domain/repository/social_auth_repository.dart';

@LazySingleton(as: SocialAuthRepository)
class SocialAuthRepositoryImpl implements SocialAuthRepository {
  SocialAuthRepositoryImpl(this._remote, this._credentials, this._auth);

  final SocialAuthRemoteDatasource _remote;
  final SocialCredentialSource _credentials;
  final AuthRepository _auth;

  @override
  Future<Either<Failure, SocialLoginResult>> signIn(SocialProvider provider) =>
      handleErrors(() async {
        final credential = await _credentials.obtain(provider);
        final result = await _remote.login(credential);
        final session = result.session;
        if (session != null) await _auth.adoptSession(session);
        return result;
      });

  @override
  Future<Either<Failure, AuthSessionModel>> link({
    required String linkToken,
    required String password,
  }) => _adopting(() => _remote.link(linkToken: linkToken, password: password));

  @override
  Future<Either<Failure, SocialOtpChallenge>> requestPhone({
    required String signupToken,
    required String phone,
    String? fullName,
  }) => handleErrors(
    () => _remote.requestPhone(
      signupToken: signupToken,
      phone: phone,
      fullName: fullName,
    ),
  );

  @override
  Future<Either<Failure, AuthSessionModel>> verifyOtp({
    required String otpToken,
    required String otp,
  }) => _adopting(() => _remote.verifyOtp(otpToken: otpToken, otp: otp));

  /// A call that ends with the member logged in: keep the user, as a password
  /// login does, before handing the session back.
  Future<Either<Failure, AuthSessionModel>> _adopting(
    Future<AuthSessionModel> Function() call,
  ) => handleErrors(() async {
    final session = await call();
    await _auth.adoptSession(session);
    return session;
  });
}
