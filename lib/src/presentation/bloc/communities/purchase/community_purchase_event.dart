part of 'community_purchase_bloc.dart';

@freezed
class CommunityPurchaseEvent with _$CommunityPurchaseEvent {
  /// Begins a purchase. Until a payment gateway exists this immediately
  /// produces a successful mock transaction.
  const factory CommunityPurchaseEvent.started({
    required CommunityModel community,
    required CommunityPlanModel plan,
  }) = _Started;

  const factory CommunityPurchaseEvent.cleared() = _Cleared;
}
