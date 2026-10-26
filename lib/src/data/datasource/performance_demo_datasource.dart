import 'package:finskool/src/domain/model/performance/performance_report.dart';
import 'package:finskool/src/domain/model/performance/performance_trade.dart';

/// **Placeholder data** for the Performance screen — the backend has no
/// performance endpoint yet. Stock names, dates, sides, net P&L and return %
/// are transcribed from Figma (`1554:6103`); only trade #1's entry/exit is
/// drawn there. Every other trade's entry price is invented and its
/// exit/per-share figures derived from it (5X margin on ₹50,000 buys
/// `250000 / entry` shares), so the expanded rows read plausibly. Charges are
/// Figma's ₹140 per trade. Delete this when a real source lands.
class PerformanceDemoDatasource {
  PerformanceDemoDatasource._();

  static const double _capital = 50000;
  static const double _charges = -140;

  /// name, date (month-day), side, net P&L, return %.
  static const _rows = <(String, int, int, TradeSide, int, double)>[
    ('Muthoot Finance', 8, 24, TradeSide.buy, 1231, 2.74),
    ('Paradeep Phosphate', 8, 25, TradeSide.sell, 1916, 4.11),
    ('Hindustan Zinc', 8, 26, TradeSide.buy, 513, 1.31),
    ('Adani Port', 9, 1, TradeSide.buy, -1782, -3.28),
    ('Netweb Tech', 9, 2, TradeSide.sell, -336, -0.39),
    ('HBL Engine', 9, 4, TradeSide.buy, -2071, -3.86),
    ('Lodha Developers', 9, 11, TradeSide.buy, -1405, -2.53),
    ('LTM', 9, 15, TradeSide.sell, 2019, 4.32),
    ('Waaree Energies', 9, 16, TradeSide.buy, 1054, 2.39),
    ('Bank of Maharastra', 9, 17, TradeSide.sell, 1753, 3.79),
    ('SONACOM', 9, 18, TradeSide.sell, -1704, -3.13),
    ('GODFREYPHILLIP', 9, 18, TradeSide.sell, -1146, -2.01),
    ('Sun Pharmaceutical', 9, 21, TradeSide.sell, -1246, -2.21),
    ('MCX', 9, 24, TradeSide.sell, 1639, 3.56),
    ('Hitachi Energy', 9, 25, TradeSide.sell, -1019, -1.76),
    ('Blue Star', 9, 28, TradeSide.sell, 1667, 3.61),
    ('Asian Paints', 9, 29, TradeSide.buy, 1214, 2.71),
    ('Coforge', 9, 30, TradeSide.sell, 1306, 2.89),
    ('Ambuja Cement', 10, 1, TradeSide.buy, -1837, -3.39),
    ('CAMS', 10, 5, TradeSide.sell, 1842, 3.96),
    ('Radico Khaitan', 10, 6, TradeSide.sell, -1665, -3.05),
    ('IEX', 10, 7, TradeSide.sell, 562, 1.40),
    ('Bank of Baroda', 10, 8, TradeSide.sell, 1856, 3.99),
    ('LIC Housing Finance', 10, 9, TradeSide.sell, -1914, -3.55),
    ('Astral', 10, 12, TradeSide.sell, 1117, 2.51),
    ('LTM', 10, 13, TradeSide.sell, -1839, -3.40),
    ('Yes Bank', 10, 14, TradeSide.sell, -1909, -3.54),
  ];

  static PerformanceTrade _trade(int index) {
    final (name, month, day, side, net, pct) = _rows[index];
    final gross = net - _charges;
    var entry = index == 0 ? 3158.68 : 150 + ((index * 977) % 2850) + 0.35;
    var perShare = index == 0 ? 17.32 : gross / (250000 / entry).floor();
    perShare = double.parse(perShare.toStringAsFixed(2));
    final exit = index == 0
        ? 3176.00
        : (side == TradeSide.buy ? entry + perShare : entry - perShare);
    return PerformanceTrade(
      number: index + 1,
      stock: name,
      date: DateTime(2026, month, day),
      side: side,
      entry: entry,
      exit: exit,
      perShare: perShare,
      grossPnl: gross.toDouble(),
      charges: _charges,
      netPnl: net.toDouble(),
      returnPct: pct,
    );
  }

  static PerformanceReport report(String communityName) {
    final trades = [for (var i = 0; i < _rows.length; i++) _trade(i)];
    return PerformanceReport(
      communityName: communityName,
      // Figma's headline figures. Its own rows sum to -184, not -186 — the
      // design rounds per row — so the totals are stated, not summed.
      grossPnl: 3594,
      totalCharges: -3780,
      capitalDeployed: _capital,
      marginLabel: '5X margin',
      trades: trades,
    );
  }
}
