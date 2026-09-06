part of 'google_signin_bloc.dart';

@freezed
class GoogleSigninEvent with _$GoogleSigninEvent {
  const factory GoogleSigninEvent.signin() = _Signin;

  // initial
  const factory GoogleSigninEvent.initial() = _Initial;
}
