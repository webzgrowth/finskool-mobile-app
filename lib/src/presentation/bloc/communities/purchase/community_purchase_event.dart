part of 'community_purchase_bloc.dart';

@freezed
class CommunityPurchaseEvent with _$CommunityPurchaseEvent {
  /// The member tapped Buy: ask the backend for a checkout page.
  const factory CommunityPurchaseEvent.started({
    required CommunityModel community,
    required CommunityPlanModel plan,
  }) = _Started;

  /// A `postMessage` from the checkout page. `paid` and `error` both start a
  /// confirmation (money may have moved even on `error`); `closed` is just the
  /// Razorpay popup being dismissed and changes nothing.
  const factory CommunityPurchaseEvent.paymentReported(PaymentOutcome outcome) =
      _PaymentReported;

  /// The member left the checkout page without the page reporting anything.
  /// Does one quiet check — they may have paid and closed it in the same beat.
  const factory CommunityPurchaseEvent.checkoutDismissed() = _CheckoutDismissed;

  /// "Check again" from the still-confirming screen.
  const factory CommunityPurchaseEvent.recheck() = _Recheck;

  const factory CommunityPurchaseEvent.cleared() = _Cleared;
}
