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
import 'widgets/welcome_kit_section.dart';

/// Figma `Frame 2121453551` / `Frame 2121453573` — plan info, transaction
/// receipt, the Welcome Kit, benefits and a help link. Reached from the
/// Profile tab's "My Subscription" rows.
class SubscriptionDetailScreen extends StatelessWidget {
  const SubscriptionDetailScreen({super.key, required this.community});

  final CommunityModel community;

  @override
  Widget build(BuildContext context) {
    final info = community.subscriptionInfo;
    final kit = community.welcomeKit;

    return TealSheetScaffold(
      // Figma draws this sheet 56 below the status bar (Edit Profile's is 61).
      sheetOffset: 56,
      children: [
        SheetBackArrow(onTap: () => context.pop(), filled: true),
        const SizedBox(height: 7),
        SubscriptionCommunityCard(community: community),
        const SizedBox(height: 14),
        if (info != null) ...[
          SubscriptionPlanSection(community: community, info: info),
          const SizedBox(height: 16),
          SubscriptionTransactionSection(info: info),
          const SizedBox(height: 20),
        ],
        // The kit brackets "What You get": its cards and risk notices come
        // before, its acknowledgment and sign-off after. That interleaving is
        // why the screen orders these rather than one Welcome Kit widget.
        if (kit != null) ...[
          WelcomeKitSection(kit: kit),
          const SizedBox(height: 16),
        ],
        if (community.benefits.isNotEmpty) ...[
          SubscriptionBenefitsSection(benefits: community.benefits),
          const SizedBox(height: 13),
        ],
        if (kit != null) ...[
          WelcomeKitFooter(kit: kit),
          const SizedBox(height: 18),
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
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 42,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppPalette.ticketHint),
        ),
        child: Text(
          'Need help with this plan?',
          style: context.subscriptionType.helpButton,
        ),
      ),
    );
  }
}
