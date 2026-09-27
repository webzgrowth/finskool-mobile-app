import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/comman/routes.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'widgets/subscription_benefits_section.dart';
import 'widgets/subscription_community_card.dart';
import 'widgets/subscription_plan_section.dart';
import 'widgets/subscription_transaction_section.dart';

/// Figma `Frame 2121453551` — plan info, transaction receipt, benefits and
/// a help link. Reached from the Profile tab's "My Subscription" rows.
///
/// Chrome matches the auth screens rather than a Material `AppBar`: the
/// teal grid bleeds behind the status bar and a white sheet with rounded
/// top corners carries the content, with the back arrow inside the sheet.
class SubscriptionDetailScreen extends StatelessWidget {
  const SubscriptionDetailScreen({super.key, required this.community});

  final CommunityModel community;

  static const double _sheetTop = 40;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final info = community.subscriptionInfo;
    final topInset = MediaQuery.paddingOf(context).top;
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppPalette.secondary,
        body: Stack(
          children: [
            SizedBox(
              height: topInset + 160,
              width: double.infinity,
              child: Image.asset(
                'assets/images/auth_header_bg.png',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: topInset + _sheetTop),
              child: Container(
                decoration: BoxDecoration(
                  color: cs.surface,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppRadii.lg),
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 480),
                    child: ListView(
                      padding: EdgeInsets.fromLTRB(
                        AppSpacing.lg,
                        AppSpacing.md,
                        AppSpacing.lg,
                        AppSpacing.xl + bottomInset,
                      ),
                      children: [
                        _BackArrow(onTap: () => context.pop()),
                        const SizedBox(height: AppSpacing.md),
                        SubscriptionCommunityCard(community: community),
                        const SizedBox(height: AppSpacing.lg),
                        if (info != null) ...[
                          SubscriptionPlanSection(
                              community: community, info: info),
                          const SizedBox(height: AppSpacing.lg),
                          SubscriptionTransactionSection(info: info),
                          const SizedBox(height: AppSpacing.lg),
                        ],
                        if (community.benefits.isNotEmpty) ...[
                          SubscriptionBenefitsSection(
                              benefits: community.benefits),
                          const SizedBox(height: AppSpacing.lg),
                        ],
                        _NeedHelpButton(
                          onTap: () =>
                              context.push(AppRoutes.HELP_SUPPORT_ROUTE_PATH),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackArrow extends StatelessWidget {
  const _BackArrow({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: AppSpacing.xs),
          child: Icon(Icons.arrow_back,
              size: 20, color: AppPalette.cardTitle),
        ),
      ),
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
