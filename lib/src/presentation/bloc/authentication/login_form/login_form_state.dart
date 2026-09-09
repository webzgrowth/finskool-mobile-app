part of 'login_form_bloc.dart';

@freezed
sealed class LoginFormState with _$LoginFormState {
  const factory LoginFormState({
    required RequestState state,
    required String message,
    required String email,
    required String password,
    required bool obscurePassword,
    String? emailError,
    String? passwordError,

    /// The API's machine-readable failure code, so the UI can route on
    /// `NOT_REGISTERED` / `PHONE_NOT_VERIFIED` rather than parse [message].
    String? errorCode,
  }) = _LoginFormState;

  factory LoginFormState.initial() => const LoginFormState(
        state: RequestState.empty,
        message: '',
        email: '',
        password: '',
        obscurePassword: true,
      );
}
