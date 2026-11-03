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

  /// The retired local "compliance done" flag. KYC lives on the server now
  /// (`GET /auth/mobile/me/kyc`); `main()` deletes this key from devices that
  /// still have it. Never read it.
  static const String legacyComplianceCompleted = 'compliance_completed';

  /// The last billing details used to pay a service quote (name, state,
  /// GSTIN, address), so the sheet is pre-filled next time. Personal data on a
  /// possibly shared phone: cleared on logout.
  static const String lastBilling = 'last_billing_details';
}
