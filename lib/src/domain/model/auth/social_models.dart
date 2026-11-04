import 'package:finskool/src/comman/exception.dart';
import 'package:finskool/src/domain/model/auth/auth_session_model.dart';

/// The identity providers the server accepts. [name] is the wire value.
enum SocialProvider { google, apple }

/// What a provider hands the app: an ID token to give the server, and the
/// raw nonce that token was issued against (the server rejects a token that
/// does not carry it, so a stolen one cannot be replayed).
///
/// Held only long enough to make one request — **never log or store it**.
class SocialCredential {
  const SocialCredential({
    required this.provider,
    required this.idToken,
    required this.nonce,
    this.fullName,
  });

  final SocialProvider provider;
  final String idToken;
  final String nonce;

  /// Apple gives the name to the app once, outside the token.
  final String? fullName;
}

/// What `POST /social/login` decided should happen next.
enum SocialStatus { loggedIn, phoneRequired, linkRequired }

/// `POST /social/login`'s `data`. Which fields are set depends on [status]:
/// a session for `logged_in`, a [signupToken] for `phone_required`, a
/// [linkToken] for `link_required` (with the account's [email]).
class SocialLoginResult {
  const SocialLoginResult({
    required this.status,
    this.session,
    this.signupToken,
    this.linkToken,
    this.email,
    this.name,
  });

  final SocialStatus status;
  final AuthSessionModel? session;
  final String? signupToken;
  final String? linkToken;
  final String? email;
  final String? name;

  factory SocialLoginResult.fromJson(Map<String, dynamic> json) {
    final status = switch (json['status']) {
      'logged_in' => SocialStatus.loggedIn,
      'phone_required' => SocialStatus.phoneRequired,
      'link_required' => SocialStatus.linkRequired,
      _ => throw ApiException('The server sent an unexpected sign-in step.'),
    };
    return SocialLoginResult(
      status: status,
      session: status == SocialStatus.loggedIn
          ? AuthSessionModel.fromJson(json)
          : null,
      signupToken: json['signupToken'] as String?,
      linkToken: json['linkToken'] as String?,
      email: json['email'] as String?,
      name: (json['name'] as String?)?.trim().isEmpty ?? true
          ? null
          : (json['name'] as String).trim(),
    );
  }
}

/// `POST /social/phone`'s `data`: the WhatsApp code was sent, and [otpToken]
/// is what `verify-otp` and `resend-otp` take in place of a user id.
class SocialOtpChallenge {
  const SocialOtpChallenge({
    required this.otpToken,
    required this.phone,
    required this.expiresInSeconds,
  });

  final String otpToken;
  final String phone;
  final int expiresInSeconds;

  factory SocialOtpChallenge.fromJson(Map<String, dynamic> json) =>
      SocialOtpChallenge(
        otpToken: json['otpToken'] as String? ?? '',
        phone: json['phone'] as String? ?? '',
        expiresInSeconds: (json['otpExpiresInSeconds'] as num?)?.toInt() ?? 0,
      );
}
