part of 'social_auth_bloc.dart';

/// Where a social sign-in is. The server picks the branch after the provider
/// hands over its token, so the screens follow [step] rather than the order
/// the member tapped things in.
enum SocialStep {
  idle,

  /// An account with this email exists: ask for its password.
  linkRequired,

  /// A new member (or one an admin added): ask for the WhatsApp number.
  phoneRequired,

  /// The WhatsApp code is on its way.
  codeSent,

  /// Logged in; the cookie is stored.
  done,

  /// A step the server has closed (expired, locked): start again from login.
  restart,
}

@freezed
sealed class SocialAuthState with _$SocialAuthState {
  const factory SocialAuthState({
    @Default(SocialStep.idle) SocialStep step,
    @Default(RequestState.empty) RequestState state,

    /// Shown as a snackbar. Left empty when the error is drawn under a field.
    @Default('') String message,
    SocialProvider? provider,

    /// From the provider; shown on the phone step.
    String? email,
    String? name,

    // Each token authorises the next call only. In memory, never persisted.
    String? signupToken,
    String? linkToken,
    String? otpToken,

    @Default('') String password,
    String? passwordError,

    @Default('+91') String countryCode,
    @Default('') String phone,
    String? phoneError,

    /// Apple gives the name once and Google may omit it: ask when it is
    /// missing, or when the server answers `NAME_REQUIRED`.
    @Default('') String typedName,
    @Default(false) bool nameRequired,
    String? nameError,

    /// The number the code went to, as the server normalised it.
    @Default('') String sentTo,
    @Default('') String otp,
    String? otpError,
    @Default(0) int resendSeconds,
  }) = _SocialAuthState;

  factory SocialAuthState.initial() => const SocialAuthState();

  const SocialAuthState._();

  /// Ask for the name on the phone step.
  bool get needsName => nameRequired || (name == null || name!.isEmpty);

  /// The number in the form the server takes: `+919876543210`.
  String get fullPhone => '$countryCode${phone.trim()}';
}
