import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:finskool/src/comman/enum.dart';

import 'package:injectable/injectable.dart';

part 'google_signin_event.dart';
part 'google_signin_state.dart';
part 'google_signin_bloc.freezed.dart';

@singleton
class GoogleSigninBloc extends Bloc<GoogleSigninEvent, GoogleSigninState> {
  GoogleSigninBloc() : super(GoogleSigninState.initial()) {
    on<GoogleSigninEvent>(_onEvent);
  }

  Future<void> _onEvent(
      GoogleSigninEvent event, Emitter<GoogleSigninState> emit) async {
    await event.map(signin: (e) async {
      emit(state.copyWith(requestState: RequestState.loading));
      try {
        final googleUser = await _handleGoogleSignIn();
        if (googleUser == null) {
          emit(state.copyWith(
              requestState: RequestState.error,
              message: 'Google Sign-In failed'));
          return;
        }

        final email = googleUser.email;

        final isAlreadyUser = await _checkIfUserAlreadyRegistered(email);
        if (isAlreadyUser) {
          emit(state.copyWith(
            requestState: RequestState.loaded,
            authFlow: AuthFlow.UserExist,
            email: email,
          ));
        } else {
          // await _signUpNewUser(googleUser, user.user?.uid);

          emit(state.copyWith(
            requestState: RequestState.loaded,
            authFlow: AuthFlow.UserNotExist,
            email: email,
          ));
        }
      } catch (e) {
        emit(state.copyWith(
            requestState: RequestState.error, message: e.toString()));
      }
    }, initial: (_Initial value) {
      emit(GoogleSigninState.initial());
    });
  }

  Future<GoogleSignInAccount?> _handleGoogleSignIn() async {
    return await GoogleSignIn.instance.authenticate();
  }

  Future<bool> _checkIfUserAlreadyRegistered(String email) async {
    // final result = await _isUserAlreadyRegistered.execute(email);
    // return result.fold(
    //   (failure) => throw Exception(failure.message),
    //   (isAlreadyUser) => isAlreadyUser,
    // );/
    return false;
  }

  Future<void> _signUpNewUser(
      GoogleSignInAccount googleUser, String? uid) async {
    final nameParts = googleUser.displayName?.split(" ") ?? [];
    final firstName = nameParts.isNotEmpty ? nameParts[0] : "";
    final lastName = nameParts.length > 1 ? nameParts[1] : "";

    // await _signUp.execute(
    //   usermodel: CreateUser((b) {
    //     b.firstName = firstName.isNotEmpty ? firstName : null;
    //     b.lastName = lastName.isNotEmpty ? lastName : null;
    //     b.email = googleUser.email;
    //   }),
    //   isSocialLogin: true,
    // );
  }
}
