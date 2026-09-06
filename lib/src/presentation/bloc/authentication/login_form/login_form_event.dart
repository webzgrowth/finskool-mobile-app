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
}
