part of 'signup_verification_bloc.dart';

@freezed
sealed class SignupVerificationState with _$SignupVerificationState {
  const factory SignupVerificationState({
    required RequestState state,
    required String message,
    required String phoneDisplay,
    required String email,
    required bool isFromSocial,
    required String phoneCode,
    required int phoneResendSeconds,
    required String emailCode,
    required int emailResendSeconds,
    String? phoneCodeError,
    String? emailCodeError,

    /// Handed over from `POST /register` via [SignupVerificationEvent.prefill]
    /// — the handle `verify-otp` and `resend-otp` are keyed on.
    ///
    /// Null on the Google path, which never registers against the backend
    /// (there is no social-auth endpoint yet). That path stays mocked, so a
    /// null here means "validate locally and move on" rather than an error.
    String? userId,

    /// The API's machine-readable failure code (`OTP_INVALID`, `OTP_LOCKED`,
    /// `OTP_COOLDOWN`, …).
    String? errorCode,
  }) = _SignupVerificationState;

  factory SignupVerificationState.initial() => const SignupVerificationState(
        state: RequestState.empty,
        message: '',
        phoneDisplay: '',
        email: '',
        isFromSocial: false,
        phoneCode: '',
        phoneResendSeconds: 0,
        emailCode: '',
        emailResendSeconds: 0,
      );

  const SignupVerificationState._();

  /// True when this flow is backed by a real registration. The Google path
  /// has no `userId` and stays entirely local.
  bool get isBackedByApi => userId != null && userId!.isNotEmpty;
}
