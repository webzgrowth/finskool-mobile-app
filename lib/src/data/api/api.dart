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

  /// The signed-in user plus **the communities they're subscribed to**, each
  /// with an `expiresAt`. The catalog endpoint below deliberately says
  /// nothing about membership, so this is the other half of the Communities
  /// tab — see `CommunitiesRemoteDatasource`.
  static const String me = '/auth/mobile/me';

  ///  =================================================================
  ///  ************************* Communities ***************************
  ///  =================================================================

  /// Every **purchasable** community — i.e. all of them except the one free
  /// community every account is auto-joined to at registration, which is
  /// excluded here and only ever appears via [me].
  static const String communities = '/mobile/communities';

  ///  =================================================================
  ///  ********************* Posts / reactions *************************
  ///  =================================================================
  static const String posts = '/mobile/posts';
  static const String reactionTypes = '/mobile/reaction-types';

  /// The first endpoint in this registry with a path parameter, hence a
  /// function rather than a `const String`. Keep new path-param endpoints in
  /// this shape instead of interpolating the id inside a datasource.
  static String postReactions(String postId) =>
      '/mobile/posts/$postId/reactions';
}
