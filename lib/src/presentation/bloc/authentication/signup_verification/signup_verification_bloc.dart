import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/domain/usecases/auth/resend_otp.dart';
import 'package:finskool/src/domain/usecases/auth/verify_otp.dart';
import 'package:injectable/injectable.dart';
import 'signup_verification_validation.dart';

part 'signup_verification_event.dart';
part 'signup_verification_state.dart';
part 'signup_verification_bloc.freezed.dart';

const _resendWindowSeconds = 24;

/// Drives the post-signup "verify your number" screen. One singleton bloc,
/// mirroring [PasswordResetBloc]'s pattern — see CLAUDE.md's "Signup
/// verification flow" section.
///
/// The backend has a **single** OTP step (`/verify-otp`, delivered by email
/// as a stand-in for WhatsApp), so only the phone channel is API-backed. The
/// email-channel events below are kept because `verify_email/` still exists
/// on disk, but that screen is no longer routed — they stay local-validation
/// only until the backend grows a second channel.
///
/// Every branch is `Future<void>`: freezed's `map` requires one return type
/// across all of them, and two now await the network.
@singleton
class SignupVerificationBloc
    extends Bloc<SignupVerificationEvent, SignupVerificationState> {
  SignupVerificationBloc(this._verifyOtp, this._resendOtp)
      : super(SignupVerificationState.initial()) {
    on<SignupVerificationEvent>((event, emit) async {
      await event.map(
        initial: (_Initial value) async {
          _phoneTimer?.cancel();
          _emailTimer?.cancel();
          emit(SignupVerificationState.initial());
        },
        prefill: (_Prefill value) async => emit(state.copyWith(
          phoneDisplay: value.phoneDisplay,
          email: value.email,
          isFromSocial: value.isFromSocial,
          userId: value.userId,
        )),
        // `/register` already sent the code, so arriving here only starts the
        // resend countdown — there's nothing left to send.
        sendPhoneCode: (_SendPhoneCode value) async => _startPhoneTimer(emit),
        phoneCodeChanged: (_PhoneCodeChanged value) async => emit(
          state.copyWith(phoneCode: value.code, phoneCodeError: null),
        ),
        verifyPhoneCode: (_VerifyPhoneCode value) => _verifyPhone(emit),
        resendPhoneCode: (_ResendPhoneCode value) => _resendPhone(emit),
        phoneTick: (_PhoneTick value) async {
          if (state.phoneResendSeconds > 0) {
            emit(state.copyWith(
                phoneResendSeconds: state.phoneResendSeconds - 1));
          } else {
            _phoneTimer?.cancel();
          }
        },
        emailCodeChanged: (_EmailCodeChanged value) async => emit(
          state.copyWith(emailCode: value.code, emailCodeError: null),
        ),
        verifyEmailCode: (_VerifyEmailCode value) async =>
            emit(state.validatedEmailCode()),
        resendEmailCode: (_ResendEmailCode value) async =>
            _startEmailTimer(emit),
        emailTick: (_EmailTick value) async {
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

  final VerifyOtp _verifyOtp;
  final ResendOtp _resendOtp;

  Future<void> _verifyPhone(Emitter<SignupVerificationState> emit) async {
    final validated = state.validatedPhoneCode();
    // The Google path has no userId — it never registered — so it keeps the
    // old local-only behaviour.
    if (!validated.isBackedByApi || validated.phoneCodeError != null) {
      emit(validated);
      return;
    }

    emit(validated.copyWith(state: RequestState.loading, message: ''));
    final result = await _verifyOtp.execute(
      userId: state.userId!,
      otp: state.phoneCode,
    );
    emit(result.fold(
      (failure) => state.withFailure(failure, onPhone: true),
      (_) => state.copyWith(state: RequestState.loaded, message: ''),
    ));
  }

  Future<void> _resendPhone(Emitter<SignupVerificationState> emit) async {
    if (!state.isBackedByApi) {
      _startPhoneTimer(emit);
      return;
    }

    emit(state.copyWith(state: RequestState.loading, message: ''));
    final result = await _resendOtp.execute(state.userId!);
    result.fold(
      // A 429 OTP_COOLDOWN means nothing was sent — surface the server's
      // "N seconds remain" message and leave the countdown alone rather than
      // restarting it on a request that didn't happen.
      (failure) => emit(state.withFailure(failure, onPhone: true)),
      (_) {
        emit(state.copyWith(state: RequestState.empty, message: ''));
        _startPhoneTimer(emit);
      },
    );
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
