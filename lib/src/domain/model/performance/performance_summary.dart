import 'package:finskool/src/comman/exception.dart';

import 'performance_json.dart';

/// The stat cards. Covers **every** trade on the board and is the same for a
/// free and a paid member — only the trade list differs. Check the subtype.
sealed class PerformanceSummary {
  const PerformanceSummary({required this.totalTrades});

  final int totalTrades;

  factory PerformanceSummary.fromJson(Map<String, dynamic> json) =>
      switch (json['kind']) {
        'intraday' => IntradaySummary.fromJson(json),
        'swing' || 'investor' => SwingSummary.fromJson(json),
        _ => throw ApiException(
          'The server sent a performance board this version cannot show.',
        ),
      };
}

/// Rupees after charges. The server computes all of it; the app only draws.
class IntradaySummary extends PerformanceSummary {
  const IntradaySummary({
    required this.capitalDeployed,
    required this.grossPnl,
    required this.totalCharges,
    required this.overallPnl,
    required super.totalTrades,
    required this.profitMakingTrades,
    required this.lossMakingTrades,
    required this.profitMakingPct,
    required this.lossMakingPct,
  });

  final double capitalDeployed;
  final double grossPnl;

  /// A **positive** amount — shown as a cost (`-3,920`).
  final double totalCharges;
  final double overallPnl;
  final int profitMakingTrades;
  final int lossMakingTrades;

  /// Percent. A flat trade counts as neither, so the two can sum to under 100.
  final double profitMakingPct;
  final double lossMakingPct;

  /// Both bars are drawn against the larger magnitude so it fills its track.
  /// Layout only — the figures themselves are the server's.
  double get _barScale {
    final big = grossPnl.abs() > totalCharges.abs()
        ? grossPnl.abs()
        : totalCharges.abs();
    return big == 0 ? 1 : big;
  }

  double get grossFraction => grossPnl.abs() / _barScale;
  double get chargesFraction => totalCharges.abs() / _barScale;

  factory IntradaySummary.fromJson(Map<String, dynamic> json) =>
      IntradaySummary(
        capitalDeployed: asDouble(json['capitalDeployed']) ?? 0,
        grossPnl: asDouble(json['grossPnl']) ?? 0,
        totalCharges: asDouble(json['totalCharges']) ?? 0,
        overallPnl: asDouble(json['overallPnl']) ?? 0,
        totalTrades: asInt(json['totalTrades']),
        profitMakingTrades: asInt(json['profitMakingTrades']),
        lossMakingTrades: asInt(json['lossMakingTrades']),
        profitMakingPct: asDouble(json['profitMakingPct']) ?? 0,
        lossMakingPct: asDouble(json['lossMakingPct']) ?? 0,
      );
}

/// `swing` and `investor` (per segment): holding time and hit-rate cards.
class SwingSummary extends PerformanceSummary {
  const SwingSummary({
    required this.averageHoldingDays,
    required super.totalTrades,
    required this.periods,
    this.range,
  });

  /// Null until a trade has closed. With a month filter, over those months.
  final double? averageHoldingDays;

  /// The admin's own cards. **They never change with the month filter** — each
  /// always covers its own months. Zero, one or many; draw one per entry.
  final List<HitRatePeriod> periods;

  /// The same card worked out for the months the member picked; null when no
  /// filter is on. Drawn **instead of** [periods] while a filter is on.
  final HitRatePeriod? range;

  factory SwingSummary.fromJson(Map<String, dynamic> json) => SwingSummary(
    averageHoldingDays: asDouble(json['averageHoldingDays']),
    totalTrades: asInt(json['totalTrades']),
    periods: [
      for (final p in (json['periods'] as List?) ?? const [])
        if (p is Map<String, dynamic>) HitRatePeriod.fromJson(p),
    ],
    range: json['range'] is Map<String, dynamic>
        ? HitRatePeriod.fromJson(json['range'] as Map<String, dynamic>)
        : null,
  );
}

/// One hit-rate card: Trades Given, Trades Met and Met %. Also the shape of
/// `range` (which has no id).
class HitRatePeriod {
  const HitRatePeriod({
    required this.id,
    required this.label,
    required this.given,
    required this.met,
    required this.metPct,
  });

  final String id;

  /// Ready to display ("Oct25 to Aug26").
  final String label;
  final int given;
  final int met;
  final double metPct;

  factory HitRatePeriod.fromJson(Map<String, dynamic> json) => HitRatePeriod(
    id: json['id'] as String? ?? '',
    label: json['label'] as String? ?? '',
    given: asInt(json['given']),
    met: asInt(json['met']),
    metPct: asDouble(json['metPct']) ?? 0,
  );
}
