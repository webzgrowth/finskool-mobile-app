part of 'google_signin_bloc.dart';

@freezed
sealed class GoogleSigninState with _$GoogleSigninState {
  const factory GoogleSigninState({
    required RequestState requestState,
    required String message,
    required AuthFlow authFlow,
    required String? email,
  }) = _GoogleSigninState;

  factory GoogleSigninState.initial() => GoogleSigninState(
        requestState: RequestState.empty,
        message: '',
        authFlow: AuthFlow.initial,
        email: null,
      );
}
