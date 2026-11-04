part of 'social_auth_bloc.dart';

/// The server closes a step for good with these (expired, locked out, token
/// refused); the only way on is to start again from the provider's button.
const _restartCodes = {
  'SOCIAL_STEP_EXPIRED',
  'SOCIAL_LINK_LOCKED',
  'SOCIAL_TOKEN_INVALID',
};

const _resendWindowSeconds = 60;

/// The steps after the provider's button. Kept out of the bloc file to stay
/// under the line limit; each takes the [Emitter] of the event being handled.
extension _SocialSteps on SocialAuthBloc {
  /// A failure with no field of its own: the server's words, as a snackbar.
  /// A closed sheet is not a failure at all.
  SocialAuthState _quiet(Failure failure) => failure is CancelledFailure
      ? state.copyWith(state: RequestState.empty, message: '')
      : state.copyWith(state: RequestState.error, message: failure.message);

  Future<void> _signInWith(
    SocialProvider provider,
    Emitter<SocialAuthState> emit,
  ) async {
    emit(
      SocialAuthState.initial().copyWith(
        state: RequestState.loading,
        provider: provider,
      ),
    );
    final result = await _signIn.execute(provider);
    emit(
      result.fold(_quiet, (login) {
        final next = switch (login.status) {
          SocialStatus.loggedIn => SocialStep.done,
          SocialStatus.phoneRequired => SocialStep.phoneRequired,
          SocialStatus.linkRequired => SocialStep.linkRequired,
        };
        return state.copyWith(
          step: next,
          state: RequestState.loaded,
          email: login.email,
          name: login.name,
          signupToken: login.signupToken,
          linkToken: login.linkToken,
        );
      }),
    );
  }

  Future<void> _linkAccount(Emitter<SocialAuthState> emit) async {
    final passwordError = Validators.required(state.password, 'Password');
    if (passwordError != null) {
      return emit(state.copyWith(passwordError: passwordError));
    }
    emit(state.copyWith(state: RequestState.loading, message: ''));
    final result = await _link.execute(
      linkToken: state.linkToken ?? '',
      password: state.password,
    );
    emit(
      result.fold((failure) {
        if (_restartCodes.contains(failure.code)) return _restart(failure);
        if (failure.code == 'SOCIAL_LINK_PASSWORD_INVALID') {
          // Under the field, not also as a snackbar.
          return state.copyWith(
            state: RequestState.error,
            message: '',
            passwordError: failure.message,
          );
        }
        return _quiet(failure);
      }, (_) => _done()),
    );
  }

  Future<void> _sendCode(Emitter<SocialAuthState> emit) async {
    final digits = CountryCodes.byDialCode(state.countryCode).digits;
    final phoneError = Validators.phone(state.phone, expectedDigits: digits);
    final nameError = state.needsName
        ? Validators.required(state.typedName, 'Full name')
        : null;
    if (phoneError != null || nameError != null) {
      return emit(state.copyWith(phoneError: phoneError, nameError: nameError));
    }
    // Step back to `phoneRequired` while sending: if the member came back
    // from the code screen, the next `codeSent` must be a change the
    // listener sees, or "Send again" would never open the code screen.
    emit(
      state.copyWith(
        step: SocialStep.phoneRequired,
        state: RequestState.loading,
        message: '',
      ),
    );
    final result = await _requestPhone.execute(
      signupToken: state.signupToken ?? '',
      phone: state.fullPhone,
      fullName: state.needsName ? state.typedName.trim() : null,
    );
    emit(
      result.fold(
        (failure) {
          if (_restartCodes.contains(failure.code)) return _restart(failure);
          if (failure.code == 'NAME_REQUIRED') {
            return state.copyWith(
              state: RequestState.error,
              message: '',
              nameRequired: true,
              nameError: failure.message,
            );
          }
          if (failure is ValidationFailure) {
            return state.copyWith(
              state: RequestState.error,
              message: failure.forField('phone') == null ? failure.message : '',
              phoneError: failure.forField('phone'),
            );
          }
          return _quiet(failure);
        },
        (challenge) {
          _startResendTimer();
          return state.copyWith(
            step: SocialStep.codeSent,
            state: RequestState.loaded,
            otpToken: challenge.otpToken,
            sentTo: challenge.phone.isEmpty ? state.fullPhone : challenge.phone,
            otp: '',
            otpError: null,
            resendSeconds: _resendWindowSeconds,
          );
        },
      ),
    );
  }

  Future<void> _verifyCode(Emitter<SocialAuthState> emit) async {
    final otpError = Validators.otp(state.otp);
    if (otpError != null) return emit(state.copyWith(otpError: otpError));
    emit(state.copyWith(state: RequestState.loading, message: ''));
    final result = await _verifyOtp.execute(
      otpToken: state.otpToken ?? '',
      otp: state.otp,
    );
    emit(
      result.fold((failure) {
        if (_restartCodes.contains(failure.code)) return _restart(failure);
        if (const {
          'OTP_INVALID',
          'OTP_EXPIRED',
          'OTP_LOCKED',
        }.contains(failure.code)) {
          return state.copyWith(
            state: RequestState.error,
            message: '',
            otpError: failure.message,
          );
        }
        return _quiet(failure);
      }, (_) => _done()),
    );
  }

  /// `resend-otp` takes the `otpToken` where signup takes a user id. A
  /// `429 OTP_COOLDOWN` shows the server's "N seconds remain" and leaves the
  /// countdown alone.
  Future<void> _resendCode(Emitter<SocialAuthState> emit) async {
    if (state.resendSeconds > 0 || state.state.isLoading) return;
    final result = await _resendOtp.execute(state.otpToken ?? '');
    emit(
      result.fold(
        (failure) => _restartCodes.contains(failure.code)
            ? _restart(failure)
            : state.copyWith(
                state: RequestState.error,
                message: failure.message,
              ),
        (_) {
          _startResendTimer();
          return state.copyWith(
            state: RequestState.empty,
            message: '',
            otpError: null,
            resendSeconds: _resendWindowSeconds,
          );
        },
      ),
    );
  }

  void _tick(Emitter<SocialAuthState> emit) {
    if (state.resendSeconds > 1) {
      return emit(state.copyWith(resendSeconds: state.resendSeconds - 1));
    }
    _timer?.cancel();
    emit(state.copyWith(resendSeconds: 0));
  }

  void _startResendTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => add(const SocialAuthEvent.tick()),
    );
  }

  /// Logged in — and every token, the password and the number go with it.
  SocialAuthState _done() {
    _timer?.cancel();
    return SocialAuthState.initial().copyWith(
      step: SocialStep.done,
      state: RequestState.loaded,
    );
  }

  SocialAuthState _restart(Failure failure) {
    _timer?.cancel();
    return SocialAuthState.initial().copyWith(
      step: SocialStep.restart,
      state: RequestState.error,
      message: failure.message,
    );
  }
}
