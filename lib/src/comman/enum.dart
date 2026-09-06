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

enum AuthFlow {
  initial,
  SendOtp,
  VerifyOtp,
  ResendOtp,
  UserExist,
  UserNotExist,
}
