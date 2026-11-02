part of 'push_settings_bloc.dart';

@freezed
class PushSettingsEvent with _$PushSettingsEvent {
  const factory PushSettingsEvent.load() = _Load;

  const factory PushSettingsEvent.toggled(bool enabled) = _Toggled;

  /// Signed out — don't show the previous account's switch to the next.
  const factory PushSettingsEvent.reset() = _Reset;
}
