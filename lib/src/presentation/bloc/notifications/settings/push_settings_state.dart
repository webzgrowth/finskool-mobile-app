part of 'push_settings_bloc.dart';

@freezed
sealed class PushSettingsState with _$PushSettingsState {
  const factory PushSettingsState({
    /// The master switch; `true` is the server's default until we hear back.
    @Default(true) bool enabled,
    @Default(false) bool saving,
    @Default('') String message,
  }) = _PushSettingsState;

  factory PushSettingsState.initial() => const PushSettingsState();
}
