import 'package:flutter/material.dart';
import 'package:finskool/src/domain/model/performance/performance_summary.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'perf_card.dart';
import 'trade_donut.dart';

/// Figma `Summary / Trades` (`1554:6562`): the donut beside the profit and
/// loss shares.
class TradesSummaryCard extends StatelessWidget {
  const TradesSummaryCard({super.key, required this.summary});

  final IntradaySummary summary;

  @override
  Widget build(BuildContext context) {
    return PerfCard(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Row(
        children: [
          TradeDonut(
            total: summary.totalTrades,
            profitShare: summary.profitMakingPct / 100,
            lossShare: summary.lossMakingPct / 100,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              children: [
                _Share(
                  label: 'Profit Making Trades',
                  count: summary.profitMakingTrades,
                  share: summary.profitMakingPct / 100,
                  color: AppPalette.perfProfit,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Divider(
                    height: 1,
                    thickness: 1,
                    color: AppPalette.perfTrack,
                  ),
                ),
                _Share(
                  label: 'Loss Making Trades',
                  count: summary.lossMakingTrades,
                  share: summary.lossMakingPct / 100,
                  color: AppPalette.ticketRed,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Share extends StatelessWidget {
  const _Share({
    required this.label,
    required this.count,
    required this.share,
    required this.color,
  });

  final String label;
  final int count;
  final double share;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final type = context.performanceType;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 8,
              width: 8,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 6),
            Flexible(child: Text(label, style: type.legendLabel)),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          '${(share * 100).toStringAsFixed(2)}%',
          style: type.legendValue.copyWith(color: color),
        ),
        Text(count == 1 ? '1 trade' : '$count trades', style: type.meta),
      ],
    );
  }
}
