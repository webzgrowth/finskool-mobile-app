import 'dart:convert';
import 'dart:io' show Platform;
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';
import 'package:injectable/injectable.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:finskool/src/comman/exception.dart';
import 'package:finskool/src/data/social/social_config.dart';
import 'package:finskool/src/domain/model/auth/social_models.dart';
import 'package:finskool/src/utilities/logger.dart';

/// Gets an ID token from Google or Apple. The seam a test replaces: nothing
/// else in the flow touches a platform SDK.
abstract class SocialCredentialSource {
  /// Throws [SocialCancelledException] if the member closes the sheet, and
  /// [ServerException] (with a message fit to show) for anything else.
  Future<SocialCredential> obtain(SocialProvider provider);
}

@LazySingleton(as: SocialCredentialSource)
class PlatformSocialCredentialSource implements SocialCredentialSource {
  @override
  Future<SocialCredential> obtain(SocialProvider provider) =>
      switch (provider) {
        SocialProvider.google => _google(),
        SocialProvider.apple => _apple(),
      };

  /// A fresh random value for every sign-in; the server wants the raw form.
  String _nonce() {
    final random = Random.secure();
    final bytes = List<int>.generate(32, (_) => random.nextInt(256));
    return base64UrlEncode(bytes).replaceAll('=', '');
  }

  /// Talks to `GoogleSignInPlatform` directly rather than the `GoogleSignIn`
  /// facade. The nonce can only be given at `init`, and the facade insists
  /// `initialize` runs *exactly once* — which would pin one nonce for the life
  /// of the app, defeating replay protection. The platform layer just stores
  /// the parameters, so a new nonce per sign-in is safe.
  Future<SocialCredential> _google() async {
    final nonce = _nonce();
    final google = GoogleSignInPlatform.instance;
    try {
      await google.init(
        InitParameters(
          // iOS only — see `SocialConfig.googleIosClientId` for why this can't
          // be left to the plist. Android must not be given one.
          clientId: Platform.isIOS ? SocialConfig.googleIosClientId : null,
          serverClientId: SocialConfig.googleWebClientId,
          nonce: nonce,
        ),
      );
      final result = await google.authenticate(const AuthenticateParameters());
      final idToken = result.authenticationTokens.idToken;
      if (idToken == null || idToken.isEmpty) {
        throw ServerException('Google did not return a sign-in token.');
      }
      return SocialCredential(
        provider: SocialProvider.google,
        idToken: idToken,
        nonce: nonce,
        fullName: result.user.displayName,
      );
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled ||
          e.code == GoogleSignInExceptionCode.interrupted) {
        throw const SocialCancelledException();
      }
      logger.warning('Google sign-in failed: ${e.code.name}');
      throw ServerException('Google sign-in failed. Please try again.');
    } finally {
      // The token is used once; signing out of the plugin makes the next tap
      // show the account chooser instead of silently reusing this account.
      try {
        await google.signOut(const SignOutParams());
      } catch (_) {}
    }
  }

  Future<SocialCredential> _apple() async {
    if (!Platform.isIOS) {
      throw ServerException('Sign in with Apple is only available on iPhone.');
    }
    final raw = _nonce();
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        // Apple wants the hash; the server wants the raw value back.
        nonce: sha256.convert(utf8.encode(raw)).toString(),
      );
      final idToken = credential.identityToken;
      if (idToken == null || idToken.isEmpty) {
        throw ServerException('Apple did not return a sign-in token.');
      }
      final name = [
        credential.givenName,
        credential.familyName,
      ].whereType<String>().join(' ').trim();
      return SocialCredential(
        provider: SocialProvider.apple,
        idToken: idToken,
        nonce: raw,
        fullName: name.isEmpty ? null : name,
      );
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) {
        throw const SocialCancelledException();
      }
      logger.warning('Apple sign-in failed: ${e.code.name}');
      throw ServerException('Apple sign-in failed. Please try again.');
    }
  }
}
