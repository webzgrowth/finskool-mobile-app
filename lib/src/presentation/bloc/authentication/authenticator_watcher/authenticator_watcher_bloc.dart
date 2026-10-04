import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:finskool/src/data/api/session_expiry.dart';
import 'package:finskool/src/domain/model/auth/user_model.dart';
import 'package:finskool/src/domain/usecases/auth/get_auth_status.dart';
import 'package:finskool/src/domain/usecases/auth/logout_user.dart';
import 'package:finskool/src/domain/usecases/auth/refresh_session.dart';
import 'package:finskool/src/domain/usecases/auth/set_post_notifications_enabled.dart';
import 'package:finskool/src/utilities/logger.dart';

import 'package:injectable/injectable.dart';
part 'authenticator_watcher_event.dart';
part 'authenticator_watcher_state.dart';
part 'authenticator_watcher_bloc.freezed.dart';

/// Resolves, on launch, whether we already hold a session — the splash screen
/// waits on this instead of routing to `/login` on a timer.
///
/// The check **asks the server**: `GET /auth/mobile/me` is the source of
/// truth for both the user and whether the session is still honoured. The
/// prefs cache is only a fallback, so the Profile tab can't drift from the
/// account it belongs to.
///
/// Two failures are deliberately treated differently. A dead session (401)
/// signs the user out. Any other failure — no network, a 5xx — keeps the
/// cached user signed in, because losing connectivity is not the same as
/// losing your account.
///
/// It also listens to [SessionExpiry], so a session killed *mid-use* (one
/// active session per account, so a login on another device ends this one)
/// flips the app to `unauthenticated` straight away instead of leaving the
/// user in a shell where every request quietly fails.
@singleton
class AuthenticatorWatcherBloc
    extends Bloc<AuthenticatorWatcherEvent, AuthenticatorWatcherState> {
  AuthenticatorWatcherBloc(
    this._authStatus,
    this._refreshSession,
    this._logoutUser,
    this._setPostNotificationsEnabled,
  ) : super(const AuthenticatorWatcherState.initial()) {
    _expiry = SessionExpiry.instance.stream.listen(
      (_) => add(const AuthenticatorWatcherEvent.sessionExpired()),
    );
    on<AuthenticatorWatcherEvent>((event, emit) async {
      await event.map(
        authCheckRequest: (_) async => _resolve(emit),
        sessionExpired: (_) async {
          // The credential is already gone — SessionInterceptor dropped it
          // before firing this. Nothing to call; just stop being signed in.
          if (state is _Unauthenticated) return;
          logger.info('Session expired; signing out.');
          emit(const AuthenticatorWatcherState.unauthenticated());
        },
        signOut: (_) async {
          emit(const AuthenticatorWatcherState.authenticating());
          // Best-effort on the server; the repository clears the local
          // credential either way, so a failed call can't strand the user in
          // a signed-in shell they can't leave.
          await _logoutUser.execute();
          await GoogleSignIn.instance.signOut();
          emit(const AuthenticatorWatcherState.unauthenticated());
        },
        notificationsToggled: (value) async {
          final result =
              await _setPostNotificationsEnabled.execute(value.enabled);
          result.fold(
            // A failed toggle shouldn't disturb whatever's on screen —
            // there's no signed-in user to update, which shouldn't happen
            // from a screen that's only reachable while authenticated.
            (failure) =>
                logger.warning('Could not update notification pref: '
                    '${failure.message}'),
            (updated) =>
                emit(AuthenticatorWatcherState.authenticated(user: updated)),
          );
        },
      );
    });
  }

  final GetAuthStatus _authStatus;
  final RefreshSession _refreshSession;
  final LogoutUser _logoutUser;
  final SetPostNotificationsEnabled _setPostNotificationsEnabled;

  late final StreamSubscription<void> _expiry;

  Future<void> _resolve(Emitter<AuthenticatorWatcherState> emit) async {
    // No cookie at all: no point asking, and no point showing a spinner.
    if (!_authStatus.hasSession) {
      emit(const AuthenticatorWatcherState.unauthenticated());
      return;
    }
    emit(const AuthenticatorWatcherState.authenticating());

    final result = await _refreshSession.execute();
    emit(result.fold(
      (failure) {
        // `hasSession` is re-read, not remembered: SessionInterceptor clears
        // the cookie on a 401 while this call is in flight, so an empty one
        // here means the server rejected us. Anything else is a bad network,
        // and the cached user keeps the app usable offline.
        if (!_authStatus.hasSession) {
          return const AuthenticatorWatcherState.unauthenticated();
        }
        logger.warning('Could not refresh session: ${failure.message}');
        return AuthenticatorWatcherState.authenticated(
            user: _authStatus.cachedUser);
      },
      (user) => AuthenticatorWatcherState.authenticated(user: user),
    ));
  }

  @override
  Future<void> close() {
    _expiry.cancel();
    return super.close();
  }
}
