part of 'authenticator_watcher_bloc.dart';

@freezed
class AuthenticatorWatcherState with _$AuthenticatorWatcherState {
  const factory AuthenticatorWatcherState.initial() = _Initial;
  const factory AuthenticatorWatcherState.authenticating() = _Authenticating;
  /// [user] is the cached profile from the last successful login. Null when
  /// we hold a session cookie but the cache is missing or unreadable — the
  /// session is still valid, we just can't name the user offline.
  const factory AuthenticatorWatcherState.authenticated({UserModel? user}) =
      _Authenticated;
  const factory AuthenticatorWatcherState.unauthenticated() = _Unauthenticated;
  const factory AuthenticatorWatcherState.isFirstTime() = _IsFirstTime;
}
