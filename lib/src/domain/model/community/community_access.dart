/// Whether the user can already read a community, and on what terms.
///
/// Drives the card's call-to-action together with [CommunityPlanStyle] —
/// see `CommunityModel.ctaLabel`. Deliberately not a stored CTA string:
/// the label is a function of these two, so there's one place to change it.
enum CommunityAccess {
  /// Already paid for. Card pins to the top of the list and reads
  /// "Enter Community".
  subscribed,

  /// Buyable, with a price shown.
  locked,

  /// Buyable, but the price isn't public — the user asks and an admin
  /// handles it manually.
  pricingOnRequest,
}

/// How a locked community's plans are expressed.
enum CommunityPlanStyle {
  /// "3 months" / "6 months" / "12 months" — a subscription period.
  duration,

  /// "Beginner" / "Intermediate" / "Advanced" — an academy course tier,
  /// bought once rather than renewed.
  tier,
}

extension CommunityAccessX on CommunityAccess {
  bool get isSubscribed => this == CommunityAccess.subscribed;
  bool get isLocked => this == CommunityAccess.locked;
  bool get isPricingOnRequest => this == CommunityAccess.pricingOnRequest;

  static CommunityAccess fromName(String name) =>
      CommunityAccess.values.firstWhere((a) => a.name == name);
}

extension CommunityPlanStyleX on CommunityPlanStyle {
  bool get isTier => this == CommunityPlanStyle.tier;

  static CommunityPlanStyle fromName(String name) =>
      CommunityPlanStyle.values.firstWhere((s) => s.name == name);
}
