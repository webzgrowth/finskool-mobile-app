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
    required bool isFromSocial,
  }) = _SignUpFormState;

  factory SignUpFormState.initial() => const SignUpFormState(
        state: RequestState.empty,
        message: '',
        email: '',
        firstName: "",
        lastName: "",
        countryCode: "",
        phonenumber: "",
        isFromSocial: false,
      );
}
