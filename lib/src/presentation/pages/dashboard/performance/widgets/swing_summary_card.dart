import 'package:flutter/material.dart';
import 'package:finskool/src/domain/model/performance/performance_summary.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'perf_card.dart';

/// The swing / investor summary: average holding time and trade count, then the
/// hit-rate cards (Trades Given, Trades Met, Met %) — **one per `periods` entry,
/// or the single `range` card while a month filter is on** (the admin's period
/// cards don't change with the filter; the range card is the picked months). Not in Figma —
/// built from the intraday cards' own tokens; flag it for the designer.
class SwingSummaryCard extends StatelessWidget {
  const SwingSummaryCard({super.key, required this.summary});

  final SwingSummary summary;

  @override
  Widget build(BuildContext context) {
    final type = context.performanceType;
    final days = summary.averageHoldingDays;
    return Column(
      children: [
        PerfCard(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                child: _Stat(
                  label: 'Average Holding Days',
                  // Null until a trade has closed.
                  value: days == null ? '—' : days.toStringAsFixed(1),
                ),
              ),
              Container(width: 1, height: 44, color: AppPalette.perfTrack),
              const SizedBox(width: 20),
              Expanded(
                child: _Stat(
                  label: 'Total Trades',
                  value: '${summary.totalTrades}',
                ),
              ),
            ],
          ),
        ),
        for (final period
            in summary.range != null ? [summary.range!] : summary.periods) ...[
          const SizedBox(height: 14),
          PerfCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(period.label, style: type.cardLabel),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: _Stat(
                        label: 'Trades Given',
                        value: '${period.given}',
                      ),
                    ),
                    Expanded(
                      child: _Stat(label: 'Trades Met', value: '${period.met}'),
                    ),
                    Expanded(
                      child: _Stat(
                        label: 'Met %',
                        value: '${period.metPct.toStringAsFixed(2)}%',
                        color: AppPalette.perfProfit,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value, this.color});

  final String label;
  final String value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final type = context.performanceType;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: type.barLabel),
        const SizedBox(height: 6),
        Text(value, style: type.capitalValue.copyWith(color: color)),
      ],
    );
  }
}
