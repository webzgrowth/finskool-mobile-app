import 'package:flutter/material.dart';
import 'package:finskool/src/domain/model/community/welcome_kit.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// "Strategy at a glance" — the tiles under the capital figure.
///
/// A `Wrap` of half-width tiles rather than a `GridView`: the lists are
/// short and already inside a scrolling sheet, and an **odd** count must
/// leave the last tile at half width (Investor's fifth tile does exactly
/// that in the design) rather than stretching it across the row.
class StrategyStatGrid extends StatelessWidget {
  const StrategyStatGrid({super.key, required this.stats});

  final List<WelcomeKitStat> stats;

  static const double _gap = AppSpacing.sm;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final tileWidth = (constraints.maxWidth - _gap) / 2;
        return Wrap(
          spacing: _gap,
          runSpacing: _gap,
          children: [
            for (final stat in stats)
              SizedBox(width: tileWidth, child: _StatTile(stat: stat)),
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
    final cs = Theme.of(context).colorScheme;
    final type = context.subscriptionType;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(AppRadii.md),
        border: Border.all(color: AppPalette.statTileBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(stat.value, style: type.statValue),
          const SizedBox(height: 2),
          Text(stat.label, style: type.statLabel),
        ],
      ),
    );
  }
}
