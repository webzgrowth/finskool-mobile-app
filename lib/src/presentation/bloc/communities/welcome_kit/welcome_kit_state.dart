part of 'welcome_kit_bloc.dart';

@freezed
sealed class WelcomeKitState with _$WelcomeKitState {
  const factory WelcomeKitState({
    required RequestState state,
    required String message,
    required String communityId,
    WelcomeKit? kit,
  }) = _WelcomeKitState;

  factory WelcomeKitState.initial() => const WelcomeKitState(
    state: RequestState.empty,
    message: '',
    communityId: '',
  );
}
