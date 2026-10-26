part of 'welcome_kit_bloc.dart';

@freezed
class WelcomeKitEvent with _$WelcomeKitEvent {
  /// Fetch the kit for this community.
  const factory WelcomeKitEvent.load(String communityId) = _Load;

  /// The retry button: loads the community this bloc was already asked about.
  const factory WelcomeKitEvent.retried() = _Retried;
}
