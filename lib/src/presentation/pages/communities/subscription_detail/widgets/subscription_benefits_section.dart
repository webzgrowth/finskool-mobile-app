import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/comman/rich_text_spans.dart';
import 'package:finskool/src/comman/widgets/teal_section_card.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// "What You get" — a teal check disc (11.8px, Figma's feather check) beside
/// each line, 17.5px text with `**bold**` runs, always expanded.
class SubscriptionBenefitsSection extends StatelessWidget {
  const SubscriptionBenefitsSection({super.key, required this.benefits});

  final List<String> benefits;

  @override
  Widget build(BuildContext context) {
    if (benefits.isEmpty) return const SizedBox.shrink();
    final type = context.subscriptionType;
    return TealSectionCard(
      title: 'What You get',
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 17),
      child: Column(
        children: [
          for (var i = 0; i < benefits.length; i++) ...[
            if (i > 0) const SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 3.2),
                  child: Container(
                    height: 11.8,
                    width: 11.8,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppPalette.badgeTeal,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset('assets/icons/sub_check.svg'),
                  ),
                ),
                const SizedBox(width: 4.2),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: boldSpans(
                        benefits[i],
                        type.benefit,
                        type.benefitBold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
