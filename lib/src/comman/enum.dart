enum LocationNavigate { isPickup, isDrop, fromSaved, fromcourier }

enum RequestState {
  empty,
  loading,
  error,
  loaded;

  bool get isEmpty => this == RequestState.empty;
  bool get isLoading => this == RequestState.loading;
  bool get isLoaded => this == RequestState.loaded;
  bool get isError => this == RequestState.error;
}

enum LocationState { init, unpermission, permission, success, error, loading }

/// Which step of the three-part forgot-password flow last completed.
///
/// All four reset screens share one bloc *and* stay mounted on the navigation
/// stack, so every one of their listeners sees every state change. Without
/// this discriminator, finishing step 3 would also re-trigger step 1's
/// "navigate forward" listener.
enum PasswordResetStep {
  none,
  codeSent,
  codeVerified,
  passwordUpdated;

  bool get isCodeSent => this == PasswordResetStep.codeSent;
  bool get isCodeVerified => this == PasswordResetStep.codeVerified;
  bool get isPasswordUpdated => this == PasswordResetStep.passwordUpdated;
}

enum AuthFlow {
  initial,
  SendOtp,
  VerifyOtp,
  ResendOtp,
  UserExist,
  UserNotExist,
}
