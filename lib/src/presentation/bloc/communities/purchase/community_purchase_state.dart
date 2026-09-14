part of 'community_purchase_bloc.dart';

@freezed
sealed class CommunityPurchaseState with _$CommunityPurchaseState {
  const factory CommunityPurchaseState({
    CommunityModel? community,
    CommunityPlanModel? plan,
    String? transactionId,
    DateTime? paidAt,
    String? paymentMethod,
  }) = _CommunityPurchaseState;

  factory CommunityPurchaseState.initial() => const CommunityPurchaseState();

  const CommunityPurchaseState._();

  /// True once a purchase is underway — guards the post-payment screens
  /// against being opened cold (e.g. a deep link) with nothing to show.
  bool get hasPurchase => community != null && plan != null;
}
