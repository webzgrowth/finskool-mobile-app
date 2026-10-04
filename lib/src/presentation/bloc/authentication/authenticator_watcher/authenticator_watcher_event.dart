part of 'authenticator_watcher_bloc.dart';

@freezed
class AuthenticatorWatcherEvent with _$AuthenticatorWatcherEvent {
  const factory AuthenticatorWatcherEvent.authCheckRequest() =
      _AuthCheckRequest;
  const factory AuthenticatorWatcherEvent.signOut() = _SignOut;

  /// The server rejected the session we were holding — raised by
  /// [SessionExpiry] from inside `SessionInterceptor`, not by any screen.
  const factory AuthenticatorWatcherEvent.sessionExpired() = _SessionExpired;

  /// The Profile screen's Notifications toggle. Session/identity state
  /// (it lives on the cached [UserModel]), so it belongs on this bloc
  /// rather than a new one — see CLAUDE.md "Bloc granularity".
  const factory AuthenticatorWatcherEvent.notificationsToggled(bool enabled) =
      _NotificationsToggled;
}
