import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/comman/routes.dart';
import 'package:finskool/src/comman/widgets/teal_sheet_scaffold.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'widgets/subscription_benefits_section.dart';
import 'widgets/subscription_community_card.dart';
import 'widgets/subscription_plan_section.dart';
import 'widgets/subscription_transaction_section.dart';

/// Figma `Frame 2121453551` — plan info, transaction receipt, benefits and
/// a help link. Reached from the Profile tab's "My Subscription" rows.
class SubscriptionDetailScreen extends StatelessWidget {
  const SubscriptionDetailScreen({super.key, required this.community});

  final CommunityModel community;

  @override
  Widget build(BuildContext context) {
    final info = community.subscriptionInfo;

    return TealSheetScaffold(
      children: [
        SheetBackArrow(onTap: () => context.pop()),
        const SizedBox(height: AppSpacing.md),
        SubscriptionCommunityCard(community: community),
        const SizedBox(height: AppSpacing.lg),
        if (info != null) ...[
          SubscriptionPlanSection(community: community, info: info),
          const SizedBox(height: AppSpacing.lg),
          SubscriptionTransactionSection(info: info),
          const SizedBox(height: AppSpacing.lg),
        ],
        if (community.benefits.isNotEmpty) ...[
          SubscriptionBenefitsSection(benefits: community.benefits),
          const SizedBox(height: AppSpacing.lg),
        ],
        _NeedHelpButton(
          onTap: () => context.push(AppRoutes.HELP_SUPPORT_ROUTE_PATH),
        ),
      ],
    );
  }
}

class _NeedHelpButton extends StatelessWidget {
  const _NeedHelpButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final type = context.subscriptionType;
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppPalette.subscriptionBorder),
          backgroundColor: cs.surface,
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        child: Text('Need help with this plan?', style: type.helpButton),
      ),
    );
  }
}
