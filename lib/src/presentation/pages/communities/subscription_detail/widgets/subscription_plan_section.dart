import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:finskool/src/comman/widgets/detail_cell.dart';
import 'package:finskool/src/comman/widgets/teal_section_card.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';
import 'package:finskool/src/domain/model/community/subscription_info.dart';

/// Plan Details — plan, amount, start date over a rule, then validity and the
/// auto-renew toggle. Column widths follow Figma's own (94 / 111 / 100): its
/// rules aren't on thirds.
class SubscriptionPlanSection extends StatelessWidget {
  const SubscriptionPlanSection({
    super.key,
    required this.community,
    required this.info,
  });

  final CommunityModel community;
  final SubscriptionInfo info;

  @override
  Widget build(BuildContext context) {
    final validTill = community.subscribedUntil;
    final fmt = DateFormat('d MMM yyyy');
    return TealSectionCard(
      title: 'Plan Details',
      padding: const EdgeInsets.fromLTRB(10, 14, 10, 13),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 94,
                  child: DetailCell(
                    glyph: 'assets/icons/sub_plan.svg',
                    label: 'Plan',
                    value: info.plan.label,
                  ),
                ),
                const GridVRule(),
                Expanded(
                  flex: 105,
                  child: DetailCell(
                    glyph: 'assets/icons/sub_dollar.svg',
                    label: 'Amount Paid',
                    value: info.plan.priceLabel,
                  ),
                ),
                const GridVRule(),
                Expanded(
                  flex: 94,
                  child: DetailCell(
                    glyph: 'assets/icons/sub_calendar_check.svg',
                    label: 'Started on',
                    value: fmt.format(info.startedOn),
                  ),
                ),
              ],
            ),
          ),
          // Auto-renew is not offered — a plan is renewed by buying again — so
          // this row is just "Valid till", across the full width.
          if (validTill != null) ...[
            const GridHRule(),
            DetailCell(
              glyph: 'assets/icons/sub_verify.svg',
              label: 'Valid till',
              value: fmt.format(validTill),
            ),
          ],
        ],
      ),
    );
  }
}
