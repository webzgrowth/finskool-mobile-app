import 'performance_trade.dart';

/// A community's trading performance: the headline P/L, the win/loss split
/// and the trade list. All derived figures are computed from the numbers the
/// source supplies, so a real endpoint only has to provide those.
class PerformanceReport {
  const PerformanceReport({
    required this.communityName,
    required this.grossPnl,
    required this.totalCharges,
    required this.capitalDeployed,
    required this.marginLabel,
    required this.trades,
  });

  final String communityName;
  final double grossPnl;

  /// Negative — what the trades cost in brokerage and taxes.
  final double totalCharges;
  final double capitalDeployed;

  /// "5X margin".
  final String marginLabel;
  final List<PerformanceTrade> trades;

  double get overallPnl => grossPnl + totalCharges;

  int get profitCount => trades.where((t) => t.isProfit).length;
  int get lossCount => trades.length - profitCount;

  double get profitShare => trades.isEmpty ? 0 : profitCount / trades.length;
  double get lossShare => trades.isEmpty ? 0 : 1 - profitShare;

  /// Both bars are drawn against the larger of the two magnitudes, so the
  /// bigger one fills its track.
  double get _barScale {
    final big = grossPnl.abs() > totalCharges.abs()
        ? grossPnl.abs()
        : totalCharges.abs();
    return big == 0 ? 1 : big;
  }

  double get grossFraction => grossPnl.abs() / _barScale;
  double get chargesFraction => totalCharges.abs() / _barScale;
}
