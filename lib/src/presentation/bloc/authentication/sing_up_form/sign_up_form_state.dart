part of 'sign_up_form_bloc.dart';

@freezed
sealed class SignUpFormState with _$SignUpFormState {
  const factory SignUpFormState({
    required RequestState state,
    required String message,
    required String firstName,
    required String lastName,
    required String countryCode,
    required String phonenumber,
    required String email,
    required String password,
    required String confirmPassword,
    required bool obscurePassword,
    required bool obscureConfirmPassword,
    required bool isFromSocial,
    String? fullNameError,
    String? emailError,
    String? phoneError,
    String? passwordError,
    String? confirmPasswordError,
  }) = _SignUpFormState;

  factory SignUpFormState.initial() => const SignUpFormState(
        state: RequestState.empty,
        message: '',
        email: '',
        firstName: "",
        lastName: "",
        countryCode: "+91",
        phonenumber: "",
        password: "",
        confirmPassword: "",
        obscurePassword: true,
        obscureConfirmPassword: true,
        isFromSocial: false,
      );
}
