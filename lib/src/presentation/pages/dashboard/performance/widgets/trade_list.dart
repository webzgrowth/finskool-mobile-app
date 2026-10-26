import 'package:flutter/material.dart';
import 'package:finskool/src/domain/model/performance/performance_report.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'perf_card.dart';
import 'trade_tile.dart';

/// Figma `List header` + `Trades` (`1554:6585` / `1554:6589`): the dashboard
/// title with a lime count pill, then every trade in one card split by
/// hairlines. The first trade opens by default, as Figma draws it.
class TradeList extends StatelessWidget {
  const TradeList({super.key, required this.report});

  final PerformanceReport report;

  @override
  Widget build(BuildContext context) {
    final type = context.performanceType;
    final trades = report.trades;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 10, 4, 0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '${report.communityName} Dashboard',
                  style: type.listTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                decoration: BoxDecoration(
                  color: AppPalette.perfCountPill,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text('${trades.length} trades', style: type.count),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        PerfCard(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
          child: Column(
            children: [
              for (var i = 0; i < trades.length; i++) ...[
                if (i > 0)
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: AppPalette.perfRowRule,
                  ),
                TradeTile(trade: trades[i], initiallyOpen: i == 0),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
