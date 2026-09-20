part of 'authenticator_watcher_bloc.dart';

@freezed
class AuthenticatorWatcherEvent with _$AuthenticatorWatcherEvent {
  const factory AuthenticatorWatcherEvent.authCheckRequest() =
      _AuthCheckRequest;
  const factory AuthenticatorWatcherEvent.signOut() = _SignOut;

  /// The Profile screen's Notifications toggle. Session/identity state
  /// (it lives on the cached [UserModel]), so it belongs on this bloc
  /// rather than a new one — see CLAUDE.md "Bloc granularity".
  const factory AuthenticatorWatcherEvent.notificationsToggled(bool enabled) =
      _NotificationsToggled;
}
