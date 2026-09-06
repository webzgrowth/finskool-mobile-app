import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/comman/validators.dart';
import 'package:injectable/injectable.dart';

part 'login_form_event.dart';
part 'login_form_state.dart';
part 'login_form_bloc.freezed.dart';

@singleton
class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  LoginFormBloc() : super(LoginFormState.initial()) {
    on<LoginFormEvent>((event, emit) async {
      await event.map(
        initial: (_) {
          emit(LoginFormState.initial());
        },
        emailChanged: (value) {
          emit(state.copyWith(
              email: value.email,
              emailError: null,
              state: RequestState.empty));
        },
        passwordChanged: (value) {
          emit(state.copyWith(
              password: value.password,
              passwordError: null,
              state: RequestState.empty));
        },
        togglePasswordVisibility: (_) {
          emit(state.copyWith(obscurePassword: !state.obscurePassword));
        },
        submit: (_) async {
          final emailError = Validators.email(state.email);
          final passwordError = Validators.required(state.password, 'Password');
          if (emailError != null || passwordError != null) {
            emit(state.copyWith(
              emailError: emailError,
              passwordError: passwordError,
              state: RequestState.error,
            ));
            return;
          }
          emit(state.copyWith(state: RequestState.loading));
          // await _login.execute(email: state.email, password: state.password);
        },
      );
    });
  }
}
