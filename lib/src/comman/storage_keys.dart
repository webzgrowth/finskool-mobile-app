/// Keys written through `SharedPreferenceHelper`.
///
/// Kept separate from `constant.dart`, which is entirely commented-out
/// leftovers from a different app.
class StorageKeys {
  StorageKeys._();

  /// The opaque `mobile_session_id` cookie value. This *is* the credential —
  /// mobile auth is cookie-based, not a Bearer token, and there is no
  /// refresh step (see `docs/auth_api_doc.md` §2).
  static const String sessionCookie = 'session_cookie';

  /// Last logged-in `UserModel`, as JSON, so the splash screen can restore a
  /// session without a round-trip.
  static const String cachedUser = 'cached_user';

  /// The community whose feed/recommendations we're scoped to.
  static const String selectedCommunityId = 'selected_community_id';
}
