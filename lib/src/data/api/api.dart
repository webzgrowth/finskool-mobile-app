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
  static const String forgotPasswordOtp =
      '/auth/mobile/forgot-password/verify-otp';
  static const String forgotPasswordReset =
      '/auth/mobile/forgot-password/reset';

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

  ///  =================================================================
  ///  ********************** Support tickets **************************
  ///  =================================================================

  /// `GET` the member's tickets (cursor-paged, optional `status`), `POST` to
  /// raise one. A `POST` **requires** an `Idempotency-Key` header.
  static const String tickets = '/mobile/tickets';

  /// The communities this member may raise a ticket against — every one they
  /// hold or ever held a subscription for, the free community included. An
  /// empty array means they can't raise a ticket at all.
  static const String ticketCommunities = '/mobile/tickets/communities';

  /// Exchanges `{fileName, sizeBytes}` for `{uploadUrl, objectKey}`. The
  /// bytes are then PUT to `uploadUrl` **directly**, outside this API and
  /// without our session cookie — see `TicketUploader`.
  static const String ticketPresign = '/mobile/tickets/attachments/presign';

  /// Total unread admin replies across every ticket; drives the Profile
  /// row's badge.
  static const String ticketUnreadCount = '/mobile/tickets/unread-count';

  static String ticket(String ticketId) => '/mobile/tickets/$ticketId';

  static String ticketRating(String ticketId) =>
      '/mobile/tickets/$ticketId/rating';

  /// A fresh signed link for an attachment whose earlier one expired —
  /// they last about 5 minutes.
  static String ticketAttachmentUrl(String ticketId, String attachmentId) =>
      '/mobile/tickets/$ticketId/attachments/$attachmentId/url';

  /// The chat socket. **Not under `/api/v1`** — it hangs off the host root,
  /// so it is derived from [baseUrl]'s origin rather than appended to it,
  /// and the scheme has to become `ws`/`wss`.
  ///
  /// One connection carries every live update. The services module shares
  /// this same endpoint, hence the generic `/ws/tickets` path staying as the
  /// backend named it.
  static String get socketUrl {
    final base = Uri.parse(baseUrl);
    return base
        .replace(
          scheme: base.scheme == 'https' ? 'wss' : 'ws',
          path: '/ws/tickets',
          query: null,
        )
        .toString();
  }
}
