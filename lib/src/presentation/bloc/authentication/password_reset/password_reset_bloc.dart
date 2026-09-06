import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:injectable/injectable.dart';
import 'password_reset_validation.dart';

part 'password_reset_event.dart';
part 'password_reset_state.dart';
part 'password_reset_bloc.freezed.dart';

const _resendWindowSeconds = 24;

@singleton
class PasswordResetBloc extends Bloc<PasswordResetEvent, PasswordResetState> {
  PasswordResetBloc() : super(PasswordResetState.initial()) {
    on<PasswordResetEvent>((event, emit) async {
      event.map(
        initial: (_Initial value) {
          _timer?.cancel();
          emit(PasswordResetState.initial());
        },
        emailChanged: (_EmailChanged value) =>
            emit(state.copyWith(email: value.email, emailError: null)),
        sendResetCode: (_SendResetCode value) async {
          final validated = state.validatedEmail();
          emit(validated);
          if (validated.emailError == null) _startResendTimer(emit);
        },
        codeChanged: (_CodeChanged value) =>
            emit(state.copyWith(code: value.code, codeError: null)),
        verifyCode: (_VerifyCode value) => emit(state.validatedCode()),
        resendCode: (_ResendCode value) => _startResendTimer(emit),
        tick: (_Tick value) {
          if (state.resendSeconds > 0) {
            emit(state.copyWith(resendSeconds: state.resendSeconds - 1));
          } else {
            _timer?.cancel();
          }
        },
        changeEmail: (_ChangeEmail value) =>
            emit(state.copyWith(code: '', codeError: null)),
        newPasswordChanged: (_NewPasswordChanged value) => emit(state
            .copyWith(newPassword: value.value, newPasswordError: null)),
        confirmPasswordChanged: (_ConfirmPasswordChanged value) => emit(
            state.copyWith(
                confirmPassword: value.value, confirmPasswordError: null)),
        toggleNewPasswordVisibility: (_ToggleNewPasswordVisibility value) =>
            emit(state.copyWith(
                obscureNewPassword: !state.obscureNewPassword)),
        toggleConfirmPasswordVisibility:
            (_ToggleConfirmPasswordVisibility value) => emit(state.copyWith(
                obscureConfirmPassword: !state.obscureConfirmPassword)),
        updatePassword: (_UpdatePassword value) =>
            emit(state.validatedNewPassword()),
      );
    });
  }

  Timer? _timer;

  void _startResendTimer(Emitter<PasswordResetState> emit) {
    _timer?.cancel();
    emit(state.copyWith(resendSeconds: _resendWindowSeconds));
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      add(const PasswordResetEvent.tick());
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
