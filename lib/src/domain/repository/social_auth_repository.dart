import 'package:dartz/dartz.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/auth/auth_session_model.dart';
import 'package:finskool/src/domain/model/auth/social_models.dart';

/// Sign in with Google / Apple (`docs`: `social-logins.md`). Implemented by
/// `data/repository/social_auth_repository_impl.dart`.
///
/// Every call that ends with the member logged in has already stored the
/// session cookie and cached the user, exactly as a password login does.
abstract class SocialAuthRepository {
  /// Asks the provider for an ID token and sends it to `POST /social/login`.
  /// A member who closes the provider's sheet comes back as a
  /// [CancelledFailure] — not an error to show.
  Future<Either<Failure, SocialLoginResult>> signIn(SocialProvider provider);

  /// `link_required`: proves the existing account's password, then links.
  Future<Either<Failure, AuthSessionModel>> link({
    required String linkToken,
    required String password,
  });

  /// `phone_required`: sends the WhatsApp code.
  Future<Either<Failure, SocialOtpChallenge>> requestPhone({
    required String signupToken,
    required String phone,
    String? fullName,
  });

  /// Confirms the code; creates (or claims) the account and logs in.
  Future<Either<Failure, AuthSessionModel>> verifyOtp({
    required String otpToken,
    required String otp,
  });
}
