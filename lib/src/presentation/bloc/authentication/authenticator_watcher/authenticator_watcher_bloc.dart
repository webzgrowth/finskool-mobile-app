import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:finskool/src/domain/model/auth/user_model.dart';
import 'package:finskool/src/domain/usecases/auth/get_auth_status.dart';
import 'package:finskool/src/domain/usecases/auth/logout_user.dart';

import 'package:injectable/injectable.dart';
part 'authenticator_watcher_event.dart';
part 'authenticator_watcher_state.dart';
part 'authenticator_watcher_bloc.freezed.dart';

/// Resolves, on launch, whether we already hold a session — the splash screen
/// waits on this instead of routing to `/login` on a timer.
///
/// The check is deliberately **local and offline**: mobile auth has no token
/// to refresh and no cheap "is this session still good?" endpoint, so we
/// trust the stored `mobile_session_id` cookie and let the first real request
/// discover if it's dead. `SessionInterceptor` clears it on a
/// `401 SESSION_INVALIDATED` (i.e. after a login on another device), so the
/// app self-corrects on the next launch.
@singleton
class AuthenticatorWatcherBloc
    extends Bloc<AuthenticatorWatcherEvent, AuthenticatorWatcherState> {
  AuthenticatorWatcherBloc(this._authStatus, this._logoutUser)
      : super(const AuthenticatorWatcherState.initial()) {
    on<AuthenticatorWatcherEvent>((event, emit) async {
      await event.map(
        authCheckRequest: (_) async {
          emit(const AuthenticatorWatcherState.authenticating());
          emit(_authStatus.hasSession
              ? AuthenticatorWatcherState.authenticated(
                  user: _authStatus.cachedUser)
              : const AuthenticatorWatcherState.unauthenticated());
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
      );
    });
  }

  final GetAuthStatus _authStatus;
  final LogoutUser _logoutUser;
}
