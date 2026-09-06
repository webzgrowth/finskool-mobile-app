part of 'password_reset_bloc.dart';

@freezed
class PasswordResetEvent with _$PasswordResetEvent {
  const factory PasswordResetEvent.initial() = _Initial;
  const factory PasswordResetEvent.emailChanged(String email) =
      _EmailChanged;
  const factory PasswordResetEvent.sendResetCode() = _SendResetCode;
  const factory PasswordResetEvent.codeChanged(String code) = _CodeChanged;
  const factory PasswordResetEvent.verifyCode() = _VerifyCode;
  const factory PasswordResetEvent.resendCode() = _ResendCode;
  const factory PasswordResetEvent.tick() = _Tick;
  const factory PasswordResetEvent.changeEmail() = _ChangeEmail;
  const factory PasswordResetEvent.newPasswordChanged(String value) =
      _NewPasswordChanged;
  const factory PasswordResetEvent.confirmPasswordChanged(String value) =
      _ConfirmPasswordChanged;
  const factory PasswordResetEvent.toggleNewPasswordVisibility() =
      _ToggleNewPasswordVisibility;
  const factory PasswordResetEvent.toggleConfirmPasswordVisibility() =
      _ToggleConfirmPasswordVisibility;
  const factory PasswordResetEvent.updatePassword() = _UpdatePassword;
}
