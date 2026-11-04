import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/country_codes.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/comman/validators.dart';
import 'package:finskool/src/domain/model/auth/social_models.dart';
import 'package:finskool/src/domain/usecases/auth/resend_otp.dart';
import 'package:finskool/src/domain/usecases/social/link_social_account.dart';
import 'package:finskool/src/domain/usecases/social/request_social_phone.dart';
import 'package:finskool/src/domain/usecases/social/social_sign_in.dart';
import 'package:finskool/src/domain/usecases/social/verify_social_otp.dart';

part 'social_auth_event.dart';
part 'social_auth_state.dart';
part 'social_auth_steps.dart';
part 'social_auth_bloc.freezed.dart';

/// Sign in with Google / Apple, start to finish: the provider's button, then
/// whichever branch the server picks — already linked (done), an existing
/// account to link by password, or a new member who confirms a WhatsApp number.
///
/// One singleton shared by the login screen and the three screens it can push
/// (same shape as `PasswordResetBloc`); the screens follow [SocialAuthState
/// .step]. The tokens it carries are in memory only and the whole thing is
/// wiped by `reset` — on a finished flow and on sign-out.
@singleton
class SocialAuthBloc extends Bloc<SocialAuthEvent, SocialAuthState> {
  SocialAuthBloc(
    this._signIn,
    this._link,
    this._requestPhone,
    this._verifyOtp,
    this._resendOtp,
  ) : super(SocialAuthState.initial()) {
    on<SocialAuthEvent>((event, emit) async {
      await event.map(
        signIn: (e) => _signInWith(e.provider, emit),
        passwordChanged: (e) async =>
            emit(state.copyWith(password: e.value, passwordError: null)),
        link: (_) => _linkAccount(emit),
        phoneChanged: (e) async =>
            emit(state.copyWith(phone: e.value, phoneError: null)),
        countryChanged: (e) async =>
            emit(state.copyWith(countryCode: e.dialCode, phoneError: null)),
        nameChanged: (e) async =>
            emit(state.copyWith(typedName: e.value, nameError: null)),
        sendCode: (_) => _sendCode(emit),
        otpChanged: (e) async =>
            emit(state.copyWith(otp: e.value, otpError: null)),
        verify: (_) => _verifyCode(emit),
        resend: (_) => _resendCode(emit),
        tick: (_) async => _tick(emit),
        reset: (_) async {
          _timer?.cancel();
          emit(_fresh());
        },
      );
    });
  }

  final SocialSignIn _signIn;
  final LinkSocialAccount _link;
  final RequestSocialPhone _requestPhone;
  final VerifySocialOtp _verifyOtp;
  final ResendOtp _resendOtp;

  Timer? _timer;

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
