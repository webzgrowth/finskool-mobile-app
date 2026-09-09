import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/domain/usecases/password_reset/reset_password.dart';
import 'package:finskool/src/domain/usecases/password_reset/send_reset_code.dart';
import 'package:finskool/src/domain/usecases/password_reset/verify_reset_code.dart';
import 'package:injectable/injectable.dart';
import 'password_reset_validation.dart';

part 'password_reset_event.dart';
part 'password_reset_state.dart';
part 'password_reset_bloc.freezed.dart';

const _resendWindowSeconds = 24;

/// Carries `email` / `code` / `cypher` / `newPassword` across the four reset
/// screens, which share this one singleton rather than passing data through
/// route params.
///
/// Every branch is `Future<void>` — freezed's `map` needs one return type
/// across all of them, and three now await the network.
@singleton
class PasswordResetBloc extends Bloc<PasswordResetEvent, PasswordResetState> {
  PasswordResetBloc(
    this._sendResetCode,
    this._verifyResetCode,
    this._resetPassword,
  ) : super(PasswordResetState.initial()) {
    on<PasswordResetEvent>((event, emit) async {
      await event.map(
        initial: (_Initial value) async {
          _timer?.cancel();
          emit(PasswordResetState.initial());
        },
        emailChanged: (_EmailChanged value) async =>
            emit(state.copyWith(email: value.email, emailError: null)),
        sendResetCode: (_SendResetCode value) => _send(emit, resend: false),
        codeChanged: (_CodeChanged value) async =>
            emit(state.copyWith(code: value.code, codeError: null)),
        verifyCode: (_VerifyCode value) => _verify(emit),
        resendCode: (_ResendCode value) => _send(emit, resend: true),
        tick: (_Tick value) async {
          if (state.resendSeconds > 0) {
            emit(state.copyWith(resendSeconds: state.resendSeconds - 1));
          } else {
            _timer?.cancel();
          }
        },
        changeEmail: (_ChangeEmail value) async =>
            emit(state.copyWith(code: '', codeError: null)),
        newPasswordChanged: (_NewPasswordChanged value) async => emit(
            state.copyWith(newPassword: value.value, newPasswordError: null)),
        confirmPasswordChanged: (_ConfirmPasswordChanged value) async => emit(
            state.copyWith(
                confirmPassword: value.value, confirmPasswordError: null)),
        toggleNewPasswordVisibility:
            (_ToggleNewPasswordVisibility value) async => emit(
                state.copyWith(obscureNewPassword: !state.obscureNewPassword)),
        toggleConfirmPasswordVisibility:
            (_ToggleConfirmPasswordVisibility value) async => emit(state
                .copyWith(
                    obscureConfirmPassword: !state.obscureConfirmPassword)),
        updatePassword: (_UpdatePassword value) => _update(emit),
      );
    });
  }

  final SendResetCode _sendResetCode;
  final VerifyResetCode _verifyResetCode;
  final ResetPassword _resetPassword;

  /// Step 1. Note the API answers 200 whether or not the email exists — a
  /// deliberate anti-enumeration measure — so success here proves nothing was
  /// rejected, not that a mail went out.
  Future<void> _send(Emitter<PasswordResetState> emit, {required bool resend}) async {
    final validated = state.validatedEmail();
    if (validated.emailError != null) {
      emit(validated);
      return;
    }

    emit(state.copyWith(
        state: RequestState.loading, message: '', errorCode: null));
    final result = await _sendResetCode.execute(state.email);
    result.fold(
      (failure) => emit(state.withFailure(failure, field: ResetField.email)),
      (_) {
        emit(state.copyWith(
          state: RequestState.loaded,
          message: '',
          // A resend isn't a step transition — the user is already on the
          // code screen, and re-emitting `codeSent` would push a duplicate.
          step: resend ? state.step : PasswordResetStep.codeSent,
        ));
        _startResendTimer(emit);
      },
    );
  }

  /// Step 2. Returns the single-use cypher that step 3 spends.
  Future<void> _verify(Emitter<PasswordResetState> emit) async {
    final validated = state.validatedCode();
    if (validated.codeError != null) {
      emit(validated);
      return;
    }

    emit(state.copyWith(
        state: RequestState.loading, message: '', errorCode: null));
    final result =
        await _verifyResetCode.execute(email: state.email, otp: state.code);
    emit(result.fold(
      (failure) => state.withFailure(failure, field: ResetField.code),
      (verified) => state.copyWith(
        state: RequestState.loaded,
        message: '',
        cypher: verified.cypher,
        step: PasswordResetStep.codeVerified,
      ),
    ));
  }

  /// Step 3. The cypher is spent by this call even on failure, so a failure
  /// clears it — `new_password_form` sends the user back for a fresh code
  /// rather than letting them re-submit a token the server has discarded.
  Future<void> _update(Emitter<PasswordResetState> emit) async {
    final validated = state.validatedNewPassword();
    if (validated.newPasswordError != null ||
        validated.confirmPasswordError != null) {
      emit(validated);
      return;
    }

    final cypher = state.cypher;
    if (cypher == null || cypher.isEmpty) {
      emit(state.copyWith(
        state: RequestState.error,
        message: 'Your reset code has expired. Please request a new one.',
        errorCode: 'RESET_TOKEN_INVALID',
      ));
      return;
    }

    emit(state.copyWith(
        state: RequestState.loading, message: '', errorCode: null));
    final result = await _resetPassword.execute(
      cypher: cypher,
      newPassword: state.newPassword,
      confirmNewPassword: state.confirmPassword,
    );
    emit(result.fold(
      (failure) => state
          .withFailure(failure, field: ResetField.newPassword)
          .copyWith(cypher: null),
      (_) => state.copyWith(
        state: RequestState.loaded,
        message: '',
        cypher: null,
        step: PasswordResetStep.passwordUpdated,
      ),
    ));
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
