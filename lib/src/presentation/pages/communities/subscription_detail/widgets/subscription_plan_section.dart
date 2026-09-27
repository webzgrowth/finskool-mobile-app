import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';
import 'package:finskool/src/domain/model/community/subscription_info.dart';

import 'auto_renew_toggle.dart';
import 'subscription_detail_item.dart';
import 'subscription_grid_rules.dart';
import 'subscription_section.dart';

/// Plan Details — plan, amount, start date over a rule, then validity and
/// the auto-renew toggle. Auto-renew takes a double-width cell (Figma has
/// no third item on that row and no rule to its right).
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
    return SubscriptionSection(
      title: 'Plan Details',
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SubscriptionDetailItem(
                    icon: Icons.description_outlined,
                    label: 'Plan',
                    value: info.plan.label,
                  ),
                ),
                const GridVRule(),
                Expanded(
                  child: SubscriptionDetailItem(
                    icon: Icons.attach_money,
                    label: 'Amount Paid',
                    value: info.plan.priceLabel,
                  ),
                ),
                const GridVRule(),
                Expanded(
                  child: SubscriptionDetailItem(
                    icon: Icons.calendar_today_outlined,
                    label: 'Started on',
                    value: DateFormat('d MMM yyyy').format(info.startedOn),
                  ),
                ),
              ],
            ),
          ),
          const GridHRule(),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: validTill == null
                      ? const SizedBox.shrink()
                      : SubscriptionDetailItem(
                          icon: Icons.verified_outlined,
                          label: 'Valid till',
                          value: DateFormat('d MMM yyyy').format(validTill),
                        ),
                ),
                const GridVRule(),
                Expanded(
                  flex: 2,
                  child: SubscriptionDetailItem(
                    icon: Icons.autorenew,
                    label: 'Auto-renew',
                    trailing: AutoRenewToggle(initial: info.autoRenew),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
