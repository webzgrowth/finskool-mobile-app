import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:injectable/injectable.dart';
import 'sign_up_form_validation.dart';

part 'sign_up_form_event.dart';
part 'sign_up_form_state.dart';
part 'sign_up_form_bloc.freezed.dart';

@singleton
class SignUpFormBloc extends Bloc<SignUpFormEvent, SignUpFormState> {
  SignUpFormBloc() : super(SignUpFormState.initial()) {
    on<SignUpFormEvent>((event, emit) async {
      await event.map(
        initial: (_) {
          emit(SignUpFormState.initial());
        },
        emailOnChanged: (event) {
          emit(state.copyWith(
              email: event.email,
              emailError: null,
              state: RequestState.empty));
        },
        registerUser: (_Register value) async {
          emit(state.validated());
        },
        firstNameChanged: (_FirstNameChanged value) {
          emit(
            state.copyWith(
              firstName: value.firstName,
              fullNameError: null,
              state: RequestState.empty,
            ),
          );
        },
        lastNameChanged: (_LastNameChanged value) {
          emit(
            state.copyWith(
              lastName: value.lastName,
              state: RequestState.empty,
            ),
          );
        },
        countryCodeChanged: (_CountryCodeChanged value) {
          // Expected digit count depends on the country, so a previously
          // shown length error may no longer apply.
          emit(
            state.copyWith(
              countryCode: value.countryCode,
              phoneError: null,
              state: RequestState.empty,
            ),
          );
        },
        phonenumberChanged: (_PhonenumberChanged value) {
          emit(
            state.copyWith(
              phonenumber: value.phonenumber,
              phoneError: null,
              state: RequestState.empty,
            ),
          );
        },
        passwordChanged: (_PasswordChanged value) {
          emit(
            state.copyWith(
              password: value.password,
              passwordError: null,
              state: RequestState.empty,
            ),
          );
        },
        confirmPasswordChanged: (_ConfirmPasswordChanged value) {
          emit(
            state.copyWith(
              confirmPassword: value.confirmPassword,
              confirmPasswordError: null,
              state: RequestState.empty,
            ),
          );
        },
        togglePasswordVisibility: (_) {
          emit(state.copyWith(obscurePassword: !state.obscurePassword));
        },
        toggleConfirmPasswordVisibility: (_) {
          emit(state.copyWith(
              obscureConfirmPassword: !state.obscureConfirmPassword));
        },
        isFromSocial: (_IsFromSocial value) {
          emit(
            state.copyWith(
              isFromSocial: value.isFromSocial,
              state: RequestState.empty,
            ),
          );
        },
      );
    });
  }

}
