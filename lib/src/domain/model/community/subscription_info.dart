import 'community_plan_model.dart';

/// Active-subscription metadata for a subscribed community.
///
/// `CommunityModel.subscribedUntil` carries the validity end date (used
/// by the Profile row's "Active till" / "Expires in" label); this class
/// holds everything else the Subscription Detail screen needs: which
/// plan, when it started, the transaction receipt, and auto-renew state.
class SubscriptionInfo {
  const SubscriptionInfo({
    required this.plan,
    required this.startedOn,
    required this.transactionId,
    required this.paidOn,
    required this.paymentMethod,
    this.autoRenew = false,
  });

  final CommunityPlanModel plan;
  final DateTime startedOn;
  final String transactionId;
  final DateTime paidOn;
  final String paymentMethod;
  final bool autoRenew;

  factory SubscriptionInfo.fromJson(Map<String, dynamic> json) =>
      SubscriptionInfo(
        plan: CommunityPlanModel.fromJson(
            json['plan'] as Map<String, dynamic>),
        startedOn: DateTime.parse(json['startedOn'] as String),
        transactionId: json['transactionId'] as String,
        paidOn: DateTime.parse(json['paidOn'] as String),
        paymentMethod: json['paymentMethod'] as String,
        autoRenew: json['autoRenew'] as bool? ?? false,
      );

  Map<String, dynamic> toJson() => {
        'plan': plan.toJson(),
        'startedOn': startedOn.toIso8601String(),
        'transactionId': transactionId,
        'paidOn': paidOn.toIso8601String(),
        'paymentMethod': paymentMethod,
        'autoRenew': autoRenew,
      };
}
