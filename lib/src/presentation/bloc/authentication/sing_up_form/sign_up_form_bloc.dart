import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:injectable/injectable.dart';

part 'sign_up_form_event.dart';
part 'sign_up_form_state.dart';
part 'sign_up_form_bloc.freezed.dart';

@singleton

class SignUpFormBloc extends Bloc<SignUpFormEvent, SignUpFormState> {
  SignUpFormBloc()
      : super(SignUpFormState.initial()) {
    on<SignUpFormEvent>((event, emit) async {
      await event.map(
        initial: (_) {
          emit(SignUpFormState.initial());
        },
        emailOnChanged: (event) {
          emit(state.copyWith(email: event.email, state: RequestState.empty));
        },
        registerUser: (_Register value) async {
         
        },
        firstNameChanged: (_FirstNameChanged value) {
          emit(
            state.copyWith(
              firstName: value.firstName,
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
          emit(
            state.copyWith(
              countryCode: value.countryCode,
              state: RequestState.empty,
            ),
          );
        },
        phonenumberChanged: (_PhonenumberChanged value) {
          emit(
            state.copyWith(
              phonenumber: value.phonenumber,
              state: RequestState.empty,
            ),
          );
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
