part of 'password_reset_bloc.dart';

@freezed
sealed class PasswordResetState with _$PasswordResetState {
  const factory PasswordResetState({
    required RequestState state,
    required String message,
    required String email,
    required String code,
    required int resendSeconds,
    required String newPassword,
    required String confirmPassword,
    required bool obscureNewPassword,
    required bool obscureConfirmPassword,

    /// Which step last completed, so each screen's listener only reacts to
    /// its own. See [PasswordResetStep].
    required PasswordResetStep step,
    String? emailError,
    String? codeError,
    String? newPasswordError,
    String? confirmPasswordError,

    /// The single-use token from `forgot-password/verify-otp`, spent by
    /// `forgot-password/reset`. Consumed by that call **even when it fails**,
    /// so a failed reset must send the user back for a fresh code rather than
    /// retry with this value.
    String? cypher,

    /// The API's machine-readable failure code (`OTP_INVALID`,
    /// `RESET_TOKEN_INVALID`, …).
    String? errorCode,
  }) = _PasswordResetState;

  factory PasswordResetState.initial() => const PasswordResetState(
        state: RequestState.empty,
        message: '',
        step: PasswordResetStep.none,
        email: '',
        code: '',
        resendSeconds: 0,
        newPassword: '',
        confirmPassword: '',
        obscureNewPassword: true,
        obscureConfirmPassword: true,
      );
}
