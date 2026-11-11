/// Which layout a community's board uses (`mobile-performance-integration.md`).
/// A community has at most one.
enum PerformanceKind { intraday, swing, investor }

extension PerformanceKindX on PerformanceKind {
  /// Nullable on purpose, like `ReactionTypeX.fromName`: a kind this build
  /// doesn't know drops that one board instead of failing the whole list.
  static PerformanceKind? fromName(String? name) {
    for (final kind in PerformanceKind.values) {
      if (kind.name == name) return kind;
    }
    return null;
  }
}

/// A board's tab. Only `investor` boards have more than the one `main`.
enum PerformanceSegment { main, investor, longTerm, usInvestment }

extension PerformanceSegmentX on PerformanceSegment {
  /// The value the API sends and takes (`long_term`, not `longTerm`).
  String get wire => switch (this) {
    PerformanceSegment.main => 'main',
    PerformanceSegment.investor => 'investor',
    PerformanceSegment.longTerm => 'long_term',
    PerformanceSegment.usInvestment => 'us_investment',
  };

  String get label => switch (this) {
    PerformanceSegment.main => 'Performance',
    PerformanceSegment.investor => 'Investor',
    PerformanceSegment.longTerm => 'Long Term',
    PerformanceSegment.usInvestment => 'US Investment',
  };

  /// Tabs whose client sheet is a plain list (no target, exit date, holding
  /// days or period summary): Long Term and US Investment.
  bool get isSheetOnly =>
      this == PerformanceSegment.longTerm ||
      this == PerformanceSegment.usInvestment;

  /// What the sheet calls the classification column on this tab.
  String get classificationLabel => this == PerformanceSegment.usInvestment
      ? 'Theme'
      : 'Theme / Sector / Type';

  static PerformanceSegment? fromWire(String? wire) {
    for (final segment in PerformanceSegment.values) {
      if (segment.wire == wire) return segment;
    }
    return null;
  }
}
