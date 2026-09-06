import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:injectable/injectable.dart';
part 'authenticator_watcher_event.dart';
part 'authenticator_watcher_state.dart';
part 'authenticator_watcher_bloc.freezed.dart';


@singleton
class AuthenticatorWatcherBloc
    extends Bloc<AuthenticatorWatcherEvent, AuthenticatorWatcherState> {
  AuthenticatorWatcherBloc()
      : super(const AuthenticatorWatcherState.initial()) {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    on<AuthenticatorWatcherEvent>((event, emit) async {
      await event.map(
        authCheckRequest: (_) async {
          // emit(const AuthenticatorWatcherState.authenticating());
          // final isFirstTime =
          //     SharedPreferenceHelper().getBool(IS_FIRST_TIME) ?? true;

          // final Is_user_left_on_half_way = SharedPreferenceHelper()
          //         .getBool(USER_LEFT_ON_HALF_WAY_REGISTRATION) ??
          //     false;
          // if (Is_user_left_on_half_way) {
          //   emit(const AuthenticatorWatcherState.unauthenticated());
          // } else {
          //   final user = _firebaseAuth.currentUser;
          //   if (isFirstTime) {
          //     SharedPreferenceHelper().storeBool(IS_FIRST_TIME, false);

          //     emit(const AuthenticatorWatcherState.isFirstTime());
          //   } else if (user == null) {
          //     emit(const AuthenticatorWatcherState.unauthenticated());
          //   } else {
          //     // _userWatcherBloc.add(const UserWatcherEvent.fetchUser());
          //     emit(const AuthenticatorWatcherState.authenticated());
          //   }
          // }
        },
        signOut: (_) async {
          await _firebaseAuth.signOut();
          GoogleSignIn.instance.signOut();
          emit(const AuthenticatorWatcherState.unauthenticated());
          emit(const AuthenticatorWatcherState.initial());
        },
      );
    });
  }
}
