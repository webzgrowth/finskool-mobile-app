import 'package:flutter/material.dart';
import 'package:finskool/src/domain/model/performance/performance_report.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import '../performance_format.dart';
import 'perf_card.dart';

/// Figma `Summary / Overall P/L` (`1554:6533`): the headline figure, the
/// gross-versus-charges bars and the capital line.
class OverallPlCard extends StatelessWidget {
  const OverallPlCard({super.key, required this.report});

  final PerformanceReport report;

  @override
  Widget build(BuildContext context) {
    final type = context.performanceType;
    final overall = report.overallPnl;
    return PerfCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text('Overall P/L', style: type.cardLabel)),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: const BoxDecoration(
                  color: AppPalette.perfChip,
                  borderRadius: BorderRadius.all(Radius.circular(999)),
                ),
                child: Text(report.marginLabel, style: type.chip),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                formatAmount(overall),
                style: type.bigValue.copyWith(color: pnlColor(overall)),
              ),
              const SizedBox(width: 6),
              Text('INR', style: type.unit),
            ],
          ),
          const SizedBox(height: 18),
          _Bar(
            label: 'Gross P/L',
            value: report.grossPnl,
            fraction: report.grossFraction,
          ),
          const SizedBox(height: 14),
          _Bar(
            label: 'Total Charges',
            value: report.totalCharges,
            fraction: report.chargesFraction,
          ),
          const SizedBox(height: 18),
          const Divider(height: 1, thickness: 1, color: AppPalette.perfTrack),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(child: Text('Capital Deployed', style: type.barLabel)),
              Text(
                formatAmount(report.capitalDeployed),
                style: type.capitalValue,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar({
    required this.label,
    required this.value,
    required this.fraction,
  });

  final String label;
  final double value;
  final double fraction;

  @override
  Widget build(BuildContext context) {
    final type = context.performanceType;
    final color = pnlColor(value);
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Text(label, style: type.barLabel)),
            Text(
              formatAmount(value),
              style: type.barValue.copyWith(color: color),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: Stack(
            children: [
              const SizedBox(
                height: 6,
                width: double.infinity,
                child: ColoredBox(color: AppPalette.perfTrack),
              ),
              FractionallySizedBox(
                widthFactor: fraction.clamp(0.0, 1.0),
                child: SizedBox(height: 6, child: ColoredBox(color: color)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
