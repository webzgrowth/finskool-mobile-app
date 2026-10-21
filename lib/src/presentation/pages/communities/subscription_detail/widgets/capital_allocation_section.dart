import 'package:flutter/material.dart';
import 'package:finskool/src/comman/rich_text_spans.dart';
import 'package:finskool/src/comman/widgets/teal_section_card.dart';
import 'package:finskool/src/domain/model/community/welcome_kit.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'strategy_stat_grid.dart';

/// The figure on its mint plate, then the at-a-glance tiles. Both headings
/// come from the data: a trading community says "Capital Allocation" /
/// "Strategy at a glance", a course says something else entirely.
class CapitalAllocationSection extends StatelessWidget {
  const CapitalAllocationSection({super.key, required this.capital});

  final CapitalAllocation capital;

  @override
  Widget build(BuildContext context) {
    final type = context.subscriptionType;
    return TealSectionCard(
      title: capital.title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppPalette.capitalHighlight,
              borderRadius: BorderRadius.circular(AppRadii.md),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(capital.amount, style: type.capitalAmount),
                const SizedBox(height: 2),
                Text(capital.caption, style: type.capitalCaption),
                const SizedBox(height: AppSpacing.xs),
                Text.rich(
                  TextSpan(
                    children: bodySpans(
                      capital.description,
                      type.kitBody,
                      type.kitBodyBold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(capital.statsHeading, style: type.kitBodyBold),
          const SizedBox(height: AppSpacing.sm),
          StrategyStatGrid(stats: capital.stats),
        ],
      ),
    );
  }
}
