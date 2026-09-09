/// Every backend endpoint the app talks to, in one place.
///
/// Paths are relative — the host lives in [Api.baseUrl] and is applied by
/// `ApiClient`'s `BaseOptions`. Each new backend module (feed, comments,
/// notifications, recommendations) appends its own block below rather than
/// scattering path strings through the datasources.
///
/// See `docs/auth_api_doc.md` for the request/response shape of each one.
class Api {
  Api._();

  /// Switchable without a code edit:
  ///   flutter run                                (production)
  ///   flutter run --dart-define=API_ENV=local    (localhost)
  ///
  /// Note the iOS Simulator can reach `localhost`, but a physical device
  /// cannot — point it at the Mac's LAN IP instead.
  static const _env = String.fromEnvironment('API_ENV', defaultValue: 'prod');

  static const bool isLocal = _env == 'local';

  static const String baseUrl = isLocal
      ? 'http://localhost:3001/api/v1'
      : 'https://community.finskool21.in/api/v1';

  ///  =================================================================
  ///  ************************ Mobile auth ****************************
  ///  =================================================================
  static const String register = '/auth/mobile/register';
  static const String verifyOtp = '/auth/mobile/verify-otp';
  static const String resendOtp = '/auth/mobile/resend-otp';
  static const String login = '/auth/mobile/login';
  static const String logout = '/auth/mobile/logout';
  static const String selectCommunity = '/auth/mobile/select-community';

  ///  =================================================================
  ///  ********************** Forgot password **************************
  ///  =================================================================
  static const String forgotPassword = '/auth/mobile/forgot-password';
  static const String forgotPasswordOtp = '/auth/mobile/forgot-password/verify-otp';
  static const String forgotPasswordReset = '/auth/mobile/forgot-password/reset';
}
