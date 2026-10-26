enum TradeSide { buy, sell }

/// One closed trade in a community's performance report.
class PerformanceTrade {
  const PerformanceTrade({
    required this.number,
    required this.stock,
    required this.date,
    required this.side,
    required this.entry,
    required this.exit,
    required this.perShare,
    required this.grossPnl,
    required this.charges,
    required this.netPnl,
    required this.returnPct,
  });

  /// 1-based position in the report ("#01").
  final int number;
  final String stock;
  final DateTime date;
  final TradeSide side;
  final double entry;
  final double exit;

  /// P/L per share (Figma's "P/L" cell), as against [grossPnl] ("P&L").
  final double perShare;
  final double grossPnl;
  final double charges;
  final double netPnl;
  final double returnPct;

  bool get isProfit => netPnl > 0;

  /// "MF" for Muthoot Finance — the first letter of the first two words, or
  /// the first two letters of a single word.
  String get initials {
    final words = stock.trim().split(RegExp(r'\s+'));
    final raw = words.length > 1
        ? '${words[0][0]}${words[1][0]}'
        : stock.substring(0, stock.length < 2 ? stock.length : 2);
    return raw.toUpperCase();
  }
}
