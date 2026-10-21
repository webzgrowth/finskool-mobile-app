import 'package:flutter/material.dart';
import 'package:finskool/src/comman/rich_text_spans.dart';
import 'package:finskool/src/comman/widgets/teal_section_card.dart';
import 'package:finskool/src/domain/model/community/welcome_kit.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'strategy_stat_grid.dart';

/// The figure on a white plate (r10), then "Strategy at a glance" and its
/// tiles. Both headings come from the data: a trading community says "Capital
/// Allocation" / "Strategy at a glance", a course says something else.
class CapitalAllocationSection extends StatelessWidget {
  const CapitalAllocationSection({super.key, required this.capital});

  final CapitalAllocation capital;

  @override
  Widget build(BuildContext context) {
    final type = context.subscriptionType;
    return TealSectionCard(
      title: capital.title,
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
                Text(capital.caption, style: type.capitalCaption),
                const SizedBox(height: 3),
                Text.rich(
                  TextSpan(
                    children: bodySpans(
                      capital.description,
                      type.capitalNote,
                      type.capitalNoteBold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 11),
          Text(capital.statsHeading, style: type.statsHeading),
          const SizedBox(height: 6),
          StrategyStatGrid(stats: capital.stats),
        ],
      ),
    );
  }
}
