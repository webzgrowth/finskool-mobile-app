import 'package:finskool/src/domain/model/community/community_access.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';
import 'package:finskool/src/domain/model/community/community_plan_model.dart';
import 'package:finskool/src/domain/model/community/subscription_info.dart';

/// Stand-in purchase receipts for the Subscription Detail screen.
///
/// **Temporary, and for demos.** Nothing in the API describes a past
/// purchase: there is no transaction id, paid date or payment method on
/// `GET /auth/mobile/me`, and no endpoint that returns one. Without this the
/// screen's Plan Details and Transaction Details cards simply don't render
/// (they're guarded on null), which is honest but leaves the screen looking
/// half-built.
///
/// So this *derives* a receipt from data that is real — the community's own
/// plan and its `expiresAt` — rather than hardcoding one row for every
/// community. The dates and amount line up with what the user actually has;
/// only the transaction id and payment method are invented.
///
/// Delete this once a purchase-history endpoint exists. Grep
/// `demoSubscriptionInfo` to find the call site.
class DemoSubscriptionDatasource {
  DemoSubscriptionDatasource._();

  /// A plausible receipt for [community], or null when there is nothing
  /// plausible to invent — the free community has no plans and was never
  /// bought, so it correctly shows no Plan or Transaction section.
  static SubscriptionInfo? forCommunity(CommunityModel community) {
    if (!community.access.isSubscribed) return null;
    final until = community.subscribedUntil;
    if (until == null) return null;

    // The free community is excluded from the catalog, so it reaches here
    // with no plans at all. It still gets a card — but a truthful one, at
    // ₹0, rather than a price it never charged.
    final plan =
        community.headlinePlan ??
        const CommunityPlanModel(
          id: 'free',
          label: 'Free membership',
          price: 0,
          months: 12,
        );

    // Work backwards from the expiry the server gave us, so "started on" and
    // "valid till" actually bracket the plan's own duration.
    final started = DateTime(
      until.year,
      until.month - (plan.months ?? 12),
      until.day,
    );

    return SubscriptionInfo(
      plan: plan,
      startedOn: started,
      // Deterministic, so the same community shows the same receipt between
      // launches instead of a number that changes as you navigate.
      transactionId: plan.price == 0
          ? 'INCLUDED-${_reference(community.id)}'
          : 'PAY-${started.year}-${_reference(community.id)}',
      paidOn: started,
      paymentMethod: plan.price == 0
          ? 'Included with your account'
          : 'UPI · PayU',
      autoRenew: true,
    );
  }

  static String _reference(String communityId) {
    final hash = communityId.codeUnits.fold<int>(
      7,
      (acc, c) => (acc * 31 + c) % 9999999,
    );
    return hash.toString().padLeft(7, '0');
  }
}
