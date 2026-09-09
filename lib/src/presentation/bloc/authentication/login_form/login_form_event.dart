part of 'login_form_bloc.dart';

@freezed
class LoginFormEvent with _$LoginFormEvent {
  const factory LoginFormEvent.initial() = _Initial;
  const factory LoginFormEvent.emailChanged(String email) = _EmailChanged;
  const factory LoginFormEvent.passwordChanged(String password) =
      _PasswordChanged;
  const factory LoginFormEvent.togglePasswordVisibility() =
      _TogglePasswordVisibility;
  const factory LoginFormEvent.submit() = _Submit;

  /// Logs in with credentials supplied by another screen rather than typed
  /// into this form — used for the silent login right after signup OTP
  /// verification, which the API requires as a separate call.
  const factory LoginFormEvent.loginWith({
    required String email,
    required String password,
  }) = _LoginWith;
}
