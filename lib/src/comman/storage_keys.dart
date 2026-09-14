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

  /// Set once the user has submitted their SEBI compliance details (DOB +
  /// PAN). The step is required before the *first* paid community only, so
  /// this gates it for every purchase afterwards.
  ///
  /// Local because the backend has no compliance endpoint yet; move it onto
  /// `UserModel` when it does, so it survives a reinstall.
  static const String complianceCompleted = 'compliance_completed';

  /// Ids of communities unlocked in-app, as a JSON list. Mock-only: the
  /// real subscription list arrives with the login payload.
  static const String unlockedCommunityIds = 'unlocked_community_ids';
}
