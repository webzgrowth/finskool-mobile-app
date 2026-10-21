import 'package:flutter/material.dart';
import 'package:finskool/src/domain/model/community/welcome_kit.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// "Strategy at a glance" — white tiles, two per row, 11 apart across and 7
/// down (Figma: 147x77 tiles).
///
/// A `Wrap` of half-width tiles rather than a `GridView`: the lists are short
/// and already inside a scrolling sheet, and an **odd** count must leave the
/// last tile at half width (Investor's fifth does exactly that in the design)
/// rather than stretching it across the row.
class StrategyStatGrid extends StatelessWidget {
  const StrategyStatGrid({super.key, required this.stats});

  final List<WelcomeKitStat> stats;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final tileWidth = (constraints.maxWidth - 11) / 2;
        return Wrap(
          spacing: 11,
          runSpacing: 7,
          children: [
            for (final stat in stats)
              SizedBox(
                width: tileWidth,
                child: _StatTile(stat: stat),
              ),
          ],
        );
      },
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.stat});

  final WelcomeKitStat stat;

  @override
  Widget build(BuildContext context) {
    final type = context.subscriptionType;
    return Container(
      constraints: const BoxConstraints(minHeight: 77),
      padding: const EdgeInsets.fromLTRB(13, 8, 11, 10),
      decoration: BoxDecoration(
        color: AppPalette.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(stat.value, style: type.statValue),
          const SizedBox(height: 6),
          Text(stat.label, style: type.statLabel),
        ],
      ),
    );
  }
}
