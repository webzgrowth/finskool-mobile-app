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
