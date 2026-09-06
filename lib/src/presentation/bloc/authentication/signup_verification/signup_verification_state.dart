part of 'signup_verification_bloc.dart';

@freezed
sealed class SignupVerificationState with _$SignupVerificationState {
  const factory SignupVerificationState({
    required RequestState state,
    required String phoneDisplay,
    required String email,
    required bool isFromSocial,
    required String phoneCode,
    required int phoneResendSeconds,
    required String emailCode,
    required int emailResendSeconds,
    String? phoneCodeError,
    String? emailCodeError,
  }) = _SignupVerificationState;

  factory SignupVerificationState.initial() => const SignupVerificationState(
        state: RequestState.empty,
        phoneDisplay: '',
        email: '',
        isFromSocial: false,
        phoneCode: '',
        phoneResendSeconds: 0,
        emailCode: '',
        emailResendSeconds: 0,
      );
}
