import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/domain/model/community/community_plan_model.dart';

/// The headline price above the plan buttons — "₹7,000 / 6 months" with
/// "≈ ₹1,333/month" beneath it when the plan carries one.
class PriceBlock extends StatelessWidget {
  const PriceBlock({super.key, required this.plan});

  final CommunityPlanModel plan;

  @override
  Widget build(BuildContext context) {
    final type = context.communityType;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(plan.priceLabel, style: type.price),
            if (plan.periodLabel != null) ...[
              const SizedBox(width: AppSpacing.xs),
              Text(plan.periodLabel!, style: type.pricePeriod),
            ],
          ],
        ),
        if (plan.perMonthLabel != null) ...[
          const SizedBox(height: 2),
          Text(plan.perMonthLabel!, style: type.pricePeriod),
        ],
      ],
    );
  }
}
