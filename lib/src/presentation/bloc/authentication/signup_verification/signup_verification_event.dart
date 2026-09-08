part of 'signup_verification_bloc.dart';

@freezed
class SignupVerificationEvent with _$SignupVerificationEvent {
  const factory SignupVerificationEvent.initial() = _Initial;
  const factory SignupVerificationEvent.prefill({
    required String phoneDisplay,
    required String email,
    required bool isFromSocial,
  }) = _Prefill;
  const factory SignupVerificationEvent.sendPhoneCode() = _SendPhoneCode;
  const factory SignupVerificationEvent.phoneCodeChanged(String code) =
      _PhoneCodeChanged;
  const factory SignupVerificationEvent.verifyPhoneCode() = _VerifyPhoneCode;
  const factory SignupVerificationEvent.resendPhoneCode() = _ResendPhoneCode;
  const factory SignupVerificationEvent.phoneTick() = _PhoneTick;
  const factory SignupVerificationEvent.emailCodeChanged(String code) =
      _EmailCodeChanged;
  const factory SignupVerificationEvent.verifyEmailCode() = _VerifyEmailCode;
  const factory SignupVerificationEvent.resendEmailCode() = _ResendEmailCode;
  const factory SignupVerificationEvent.emailTick() = _EmailTick;
}
