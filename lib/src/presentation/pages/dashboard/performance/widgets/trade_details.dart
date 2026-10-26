import 'package:flutter/material.dart';
import 'package:finskool/src/domain/model/performance/performance_trade.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import '../performance_format.dart';

/// The expanded panel under a trade (Figma `Details`, `1554:6605`): six
/// cells in two rows of three, split by a hairline, on a `#F6F8F7` r14 plate.
class TradeDetails extends StatelessWidget {
  const TradeDetails({super.key, required this.trade});

  final PerformanceTrade trade;

  @override
  Widget build(BuildContext context) {
    final t = trade;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppPalette.perfDetail,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          _Row([
            _Cell('Entry', t.entry.toStringAsFixed(2), AppPalette.cardTitle),
            _Cell('Exit', t.exit.toStringAsFixed(2), AppPalette.cardTitle),
            _Cell('P/L', t.perShare.toStringAsFixed(2), pnlColor(t.perShare)),
          ]),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(
              height: 1,
              thickness: 1,
              color: AppPalette.perfDetailRule,
            ),
          ),
          _Row([
            _Cell('P&L', formatAmount(t.grossPnl), pnlColor(t.grossPnl)),
            // Charges are a cost, not a result — Figma greys them.
            _Cell('Charges', formatAmount(t.charges), AppPalette.perfMuted),
            _Cell('Net P&L', formatAmount(t.netPnl), pnlColor(t.netPnl)),
          ]),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row(this.cells);

  final List<_Cell> cells;

  @override
  Widget build(BuildContext context) =>
      Row(children: [for (final c in cells) Expanded(child: c)]);
}

class _Cell extends StatelessWidget {
  const _Cell(this.label, this.value, this.color);

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final type = context.performanceType;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: type.detailLabel),
        const SizedBox(height: 3),
        Text(value, style: type.detailValue.copyWith(color: color)),
      ],
    );
  }
}
