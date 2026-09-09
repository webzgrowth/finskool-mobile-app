import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/comman/validators.dart';
import 'package:finskool/src/domain/usecases/auth/login_user.dart';
import 'package:injectable/injectable.dart';

part 'login_form_event.dart';
part 'login_form_state.dart';
part 'login_form_bloc.freezed.dart';

@singleton
class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  LoginFormBloc(this._loginUser) : super(LoginFormState.initial()) {
    on<LoginFormEvent>((event, emit) async {
      await event.map(
        initial: (_) async {
          emit(LoginFormState.initial());
        },
        emailChanged: (value) async {
          emit(state.copyWith(
              email: value.email,
              emailError: null,
              state: RequestState.empty));
        },
        passwordChanged: (value) async {
          emit(state.copyWith(
              password: value.password,
              passwordError: null,
              state: RequestState.empty));
        },
        togglePasswordVisibility: (_) async {
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
          await _authenticate(emit, state.email, state.password);
        },
        loginWith: (value) async {
          emit(state.copyWith(email: value.email, password: value.password));
          await _authenticate(emit, value.email, value.password);
        },
      );
    });
  }

  final LoginUser _loginUser;

  Future<void> _authenticate(
    Emitter<LoginFormState> emit,
    String email,
    String password,
  ) async {
    emit(state.copyWith(
      state: RequestState.loading,
      message: '',
      errorCode: null,
      emailError: null,
      passwordError: null,
    ));

    final result = await _loginUser.execute(email: email, password: password);

    // Success carries the session model, but nothing here needs it — the
    // credential is the cookie SessionInterceptor already stored, and the
    // user is cached by the repository.
    emit(result.fold(_onFailure, (_) => state.copyWith(
          state: RequestState.loaded,
          message: '',
        )));
  }

  LoginFormState _onFailure(Failure failure) {
    // A 422 names the offending fields, so show them inline instead of
    // collapsing everything into one snackbar.
    if (failure is ValidationFailure) {
      return state.copyWith(
        state: RequestState.error,
        message: failure.message,
        errorCode: failure.code,
        emailError: failure.forField('email'),
        passwordError: failure.forField('password'),
      );
    }
    return state.copyWith(
      state: RequestState.error,
      message: failure.message,
      errorCode: failure.code,
    );
  }
}
