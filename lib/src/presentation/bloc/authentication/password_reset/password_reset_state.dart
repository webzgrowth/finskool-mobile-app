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
    String? emailError,
    String? codeError,
    String? newPasswordError,
    String? confirmPasswordError,
  }) = _PasswordResetState;

  factory PasswordResetState.initial() => const PasswordResetState(
        state: RequestState.empty,
        message: '',
        email: '',
        code: '',
        resendSeconds: 0,
        newPassword: '',
        confirmPassword: '',
        obscureNewPassword: true,
        obscureConfirmPassword: true,
      );
}
