/// One purchasable option on a locked community.
///
/// Covers both shapes Figma shows: a subscription period ("6 months",
/// ₹7,000, "Save ₹ 1k") and an academy tier ("Intermediate", ₹15,000) —
/// they differ only in which optional fields are set. See
/// [CommunityPlanStyle].
class CommunityPlanModel {
  const CommunityPlanModel({
    required this.id,
    required this.label,
    required this.price,
    this.months,
    this.saveLabel,
    this.perMonthLabel,
    this.featured = false,
  });

  final String id;

  /// "3 months" or "Intermediate".
  final String label;

  /// Whole rupees. Formatted for display by [priceLabel].
  final int price;

  /// Null for tier plans, which aren't time-bound.
  final int? months;

  /// "Save ₹ 1k" pill shown on the better-value options.
  final String? saveLabel;

  /// "≈ ₹1,333/month" shown under the headline price.
  final String? perMonthLabel;

  /// The plan the card leads with. Figma features the 6-month option on
  /// Swing Alpha — *not* the cheapest or the dearest — so which plan
  /// headlines the card is an editorial choice, not something derivable
  /// from price.
  final bool featured;

  /// `12345` -> `₹12,345`, grouped Indian-style (the design only ever
  /// shows 4–5 digit amounts, where Indian and Western grouping agree).
  String get priceLabel {
    final digits = price.toString();
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) buffer.write(',');
      buffer.write(digits[i]);
    }
    return '₹$buffer';
  }

  /// "/ 6 months" — the suffix beside the headline price.
  String? get periodLabel => months == null ? null : '/ $label';

  /// `GET /mobile/communities`' inline `plans`, which carry only
  /// `{id, name, durationMonths, price}`.
  ///
  /// Takes the **whole list** because two of Figma's fields are relative to
  /// the other plans: `perMonthLabel` is this plan's own arithmetic, but
  /// `saveLabel` is what you save against the shortest plan's monthly rate.
  /// Both are *derived* — the API has no field for either — which is fine,
  /// because they're arithmetic. [featured] stays false: which plan
  /// headlines a card is editorial (CLAUDE.md), nothing in the payload
  /// expresses it, and `CommunityModel.headlinePlan` already falls back to
  /// the cheapest.
  static List<CommunityPlanModel> fromCatalogList(List<dynamic> rows) {
    final plans = rows.whereType<Map<String, dynamic>>().toList();
    if (plans.isEmpty) return const [];

    double? monthlyRate(Map<String, dynamic> p) {
      final months = (p['durationMonths'] as num?)?.toInt() ?? 0;
      if (months <= 0) return null;
      return ((p['price'] as num?)?.toDouble() ?? 0) / months;
    }

    // The baseline every saving is measured against: the dearest per-month
    // rate on offer, which is what a shorter commitment costs.
    final rates = plans.map(monthlyRate).whereType<double>();
    final baseline = rates.isEmpty
        ? null
        : rates.reduce((a, b) => a > b ? a : b);

    return plans.map((row) {
      final months = (row['durationMonths'] as num?)?.toInt();
      final price = ((row['price'] as num?)?.toDouble() ?? 0).round();
      final rate = monthlyRate(row);
      final saved = (baseline == null || rate == null)
          ? 0
          : (baseline - rate) * months!;

      return CommunityPlanModel(
        id: row['id'] as String,
        label: row['name'] as String? ?? _durationLabel(months),
        price: price,
        months: months,
        saveLabel: saved >= 1 ? 'Save ${_compact(saved.round())}' : null,
        perMonthLabel: rate == null ? null : '≈ ₹${rate.round()}/month',
      );
    }).toList();
  }

  static String _durationLabel(int? months) =>
      months == null ? 'Plan' : '$months month${months == 1 ? '' : 's'}';

  /// `1000` -> `₹ 1k`, matching Figma's "Save ₹ 1k" pill.
  static String _compact(int amount) =>
      amount >= 1000 ? '₹ ${(amount / 1000).round()}k' : '₹ $amount';

  factory CommunityPlanModel.fromJson(Map<String, dynamic> json) =>
      CommunityPlanModel(
        id: json['id'] as String,
        label: json['label'] as String,
        price: json['price'] as int,
        months: json['months'] as int?,
        saveLabel: json['saveLabel'] as String?,
        perMonthLabel: json['perMonthLabel'] as String?,
        featured: json['featured'] as bool? ?? false,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'label': label,
    'price': price,
    'months': months,
    'saveLabel': saveLabel,
    'perMonthLabel': perMonthLabel,
    'featured': featured,
  };
}
