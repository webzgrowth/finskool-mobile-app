import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:injectable/injectable.dart';
import 'signup_verification_validation.dart';

part 'signup_verification_event.dart';
part 'signup_verification_state.dart';
part 'signup_verification_bloc.freezed.dart';

const _resendWindowSeconds = 24;

/// Drives the post-signup "verify your number" / "verify your email"
/// screens. One singleton bloc shared across both, mirroring
/// [PasswordResetBloc]'s pattern — see CLAUDE.md's "Signup verification
/// flow" section. Two independent [Timer]s (one per channel) back the
/// resend countdowns, since a user could in principle land back on either
/// screen while the other's timer is still running.
@singleton
class SignupVerificationBloc
    extends Bloc<SignupVerificationEvent, SignupVerificationState> {
  SignupVerificationBloc() : super(SignupVerificationState.initial()) {
    on<SignupVerificationEvent>((event, emit) {
      event.map(
        initial: (_Initial value) {
          _phoneTimer?.cancel();
          _emailTimer?.cancel();
          emit(SignupVerificationState.initial());
        },
        prefill: (_Prefill value) => emit(state.copyWith(
          phoneDisplay: value.phoneDisplay,
          email: value.email,
          isFromSocial: value.isFromSocial,
        )),
        sendPhoneCode: (_SendPhoneCode value) => _startPhoneTimer(emit),
        phoneCodeChanged: (_PhoneCodeChanged value) => emit(
          state.copyWith(phoneCode: value.code, phoneCodeError: null),
        ),
        verifyPhoneCode: (_VerifyPhoneCode value) =>
            emit(state.validatedPhoneCode()),
        resendPhoneCode: (_ResendPhoneCode value) => _startPhoneTimer(emit),
        phoneTick: (_PhoneTick value) {
          if (state.phoneResendSeconds > 0) {
            emit(state.copyWith(
                phoneResendSeconds: state.phoneResendSeconds - 1));
          } else {
            _phoneTimer?.cancel();
          }
        },
        emailCodeChanged: (_EmailCodeChanged value) => emit(
          state.copyWith(emailCode: value.code, emailCodeError: null),
        ),
        verifyEmailCode: (_VerifyEmailCode value) =>
            emit(state.validatedEmailCode()),
        resendEmailCode: (_ResendEmailCode value) => _startEmailTimer(emit),
        emailTick: (_EmailTick value) {
          if (state.emailResendSeconds > 0) {
            emit(state.copyWith(
                emailResendSeconds: state.emailResendSeconds - 1));
          } else {
            _emailTimer?.cancel();
          }
        },
      );
    });
  }

  Timer? _phoneTimer;
  Timer? _emailTimer;

  void _startPhoneTimer(Emitter<SignupVerificationState> emit) {
    _phoneTimer?.cancel();
    emit(state.copyWith(phoneResendSeconds: _resendWindowSeconds));
    _phoneTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      add(const SignupVerificationEvent.phoneTick());
    });
  }

  void _startEmailTimer(Emitter<SignupVerificationState> emit) {
    _emailTimer?.cancel();
    emit(state.copyWith(emailResendSeconds: _resendWindowSeconds));
    _emailTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      add(const SignupVerificationEvent.emailTick());
    });
  }

  @override
  Future<void> close() {
    _phoneTimer?.cancel();
    _emailTimer?.cancel();
    return super.close();
  }
}
