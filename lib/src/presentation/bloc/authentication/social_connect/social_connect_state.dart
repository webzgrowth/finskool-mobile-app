part of 'social_connect_bloc.dart';

@freezed
sealed class SocialConnectState with _$SocialConnectState {
  const factory SocialConnectState({
    @Default(RequestState.empty) RequestState state,

    /// The server's words for a failure (`SOCIAL_ALREADY_LINKED`,
    /// `SOCIAL_PROVIDER_ALREADY_LINKED`, `SOCIAL_TOKEN_INVALID`…), verbatim.
    @Default('') String message,

    /// Which row is busy — only that Connect button shows a spinner.
    SocialProvider? provider,
  }) = _SocialConnectState;

  factory SocialConnectState.initial() => const SocialConnectState();
}
