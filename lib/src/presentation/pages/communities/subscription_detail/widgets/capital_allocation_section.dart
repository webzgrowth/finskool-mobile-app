import 'package:flutter/material.dart';
import 'package:finskool/src/comman/markdown_text.dart';
import 'package:finskool/src/comman/widgets/teal_section_card.dart';
import 'package:finskool/src/domain/model/community/welcome_kit.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'strategy_stat_grid.dart';

/// The figure on a white plate (r10), then the strategy heading and its tiles.
/// The strategy heading (`strategyTitle`) and every figure come from the admin;
/// "Capital Allocation" is the fixed section name.
class CapitalAllocationSection extends StatelessWidget {
  const CapitalAllocationSection({super.key, required this.capital});

  final CapitalAllocation capital;

  @override
  Widget build(BuildContext context) {
    final type = context.subscriptionType;
    return TealSectionCard(
      title: 'Capital Allocation',
      padding: const EdgeInsets.fromLTRB(14, 13, 14, 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(13, 6, 15, 11),
            decoration: BoxDecoration(
              color: AppPalette.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(capital.amount, style: type.capitalAmount),
                if (capital.caption != null)
                  Text(capital.caption!, style: type.capitalCaption),
                if (capital.description.isNotEmpty) ...[
                  const SizedBox(height: 3),
                  Text.rich(
                    TextSpan(
                      children: markdownSpans(
                        capital.description,
                        type.capitalNote,
                        type.capitalNoteBold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (capital.stats.isNotEmpty) ...[
            const SizedBox(height: 11),
            Text(capital.statsHeading, style: type.statsHeading),
            const SizedBox(height: 6),
            StrategyStatGrid(stats: capital.stats),
          ],
        ],
      ),
    );
  }
}
