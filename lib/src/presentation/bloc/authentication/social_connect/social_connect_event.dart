part of 'social_connect_bloc.dart';

@freezed
class SocialConnectEvent with _$SocialConnectEvent {
  /// A Connect tap on the Profile.
  const factory SocialConnectEvent.requested(SocialProvider provider) =
      _Requested;

  /// Clears the last outcome once the screen has reacted to it.
  const factory SocialConnectEvent.reset() = _Reset;
}
