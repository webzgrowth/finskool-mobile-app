import 'package:flutter/material.dart';
import 'package:finskool/src/comman/rich_text_spans.dart';
import 'package:finskool/src/presentation/pages/communities/widgets/benefit_check.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'subscription_section.dart';

/// "What You get" section on the Subscription Detail screen.
/// Reuses the existing [BenefitCheck] and [boldSpans] from the
/// community card, but always expanded (no collapsible panel).
class SubscriptionBenefitsSection extends StatelessWidget {
  const SubscriptionBenefitsSection({
    super.key,
    required this.benefits,
  });

  final List<String> benefits;

  @override
  Widget build(BuildContext context) {
    if (benefits.isEmpty) return const SizedBox.shrink();

    final type = context.communityType;
    return SubscriptionSection(
      title: 'What You get',
      child: Column(
        children: [
          for (int i = 0; i < benefits.length; i++) ...[
            if (i > 0) const SizedBox(height: 7),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 1),
                  child: BenefitCheck(size: 15),
                ),
                const SizedBox(width: AppSpacing.sm),
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
