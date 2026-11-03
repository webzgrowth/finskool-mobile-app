part of 'community_purchase_bloc.dart';

/// Where a purchase is. Linear, with two ways out of [checking] and
/// [confirming]: [confirmed] and (only for [confirming]) [pending].
enum PurchaseStatus {
  idle,

  /// Asking the backend for a checkout page.
  starting,

  /// The checkout page is open (or about to be).
  checkout,

  /// The page was closed without a word; one quiet look at `/me`.
  checking,

  /// The page said `paid`/`error`; polling `/me` until the server agrees.
  confirming,

  /// `/me` shows the new expiry: access is real.
  confirmed,

  /// Still not visible after the retries. Money may have been taken — the
  /// webhook will grant access shortly, and the member must **not** pay again.
  pending,

  /// A checkout could not even be started (429, no plan, network…).
  failed,
}

@freezed
sealed class CommunityPurchaseState with _$CommunityPurchaseState {
  const factory CommunityPurchaseState({
    CommunityModel? community,
    CommunityPlanModel? plan,
    @Default(PurchaseStatus.idle) PurchaseStatus status,

    /// Handed to the webview and nowhere else. Holds a single-use token, so it
    /// is never logged, persisted or put in a route.
    String? checkoutUrl,
    @Default('') String message,

    /// Access end *before* this purchase — a renewal is only confirmed once
    /// `/me` reports a later date than this.
    DateTime? previousExpiry,
    DateTime? expiresAt,
    DateTime? paidAt,

    /// Set when the purchase is confirmed: the server doesn't have the
    /// member's date of birth + PAN yet, so the next step is the SEBI form.
    @Default(false) bool needsKyc,
  }) = _CommunityPurchaseState;

  factory CommunityPurchaseState.initial() => const CommunityPurchaseState();

  const CommunityPurchaseState._();

  /// True once a purchase is underway — guards the post-payment screens
  /// against being opened cold (e.g. a deep link) with nothing to show.
  bool get hasPurchase => community != null && plan != null;

  /// A purchase that has left the starting blocks and not finished: a second
  /// tap on Buy must not start another.
  bool get isBusy => const {
    PurchaseStatus.starting,
    PurchaseStatus.checkout,
    PurchaseStatus.checking,
    PurchaseStatus.confirming,
  }.contains(status);
}
