part of 'social_auth_bloc.dart';

@freezed
class SocialAuthEvent with _$SocialAuthEvent {
  /// The Google / Apple button.
  const factory SocialAuthEvent.signIn(SocialProvider provider) = _SignIn;

  // link_required
  const factory SocialAuthEvent.passwordChanged(String value) =
      _PasswordChanged;
  const factory SocialAuthEvent.link() = _Link;

  // phone_required
  const factory SocialAuthEvent.phoneChanged(String value) = _PhoneChanged;
  const factory SocialAuthEvent.countryChanged(String dialCode) =
      _CountryChanged;
  const factory SocialAuthEvent.nameChanged(String value) = _NameChanged;
  const factory SocialAuthEvent.sendCode() = _SendCode;

  // the WhatsApp code
  const factory SocialAuthEvent.otpChanged(String value) = _OtpChanged;
  const factory SocialAuthEvent.verify() = _Verify;
  const factory SocialAuthEvent.resend() = _Resend;
  const factory SocialAuthEvent.tick() = _Tick;

  /// Back to the start; also what sign-out and a finished flow dispatch.
  const factory SocialAuthEvent.reset() = _Reset;
}
