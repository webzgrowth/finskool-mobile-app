import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/injections/injection.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/comman/routes.dart';
import 'package:finskool/src/comman/widgets/teal_sheet_scaffold.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';
import 'package:finskool/src/presentation/bloc/communities/welcome_kit/welcome_kit_bloc.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'widgets/subscription_benefits_section.dart';
import 'widgets/subscription_community_card.dart';
import 'widgets/subscription_plan_section.dart';
import 'widgets/subscription_transaction_section.dart';
import 'widgets/welcome_kit_section.dart';
import 'widgets/welcome_kit_skeleton.dart';

/// Figma `Frame 2121453551` / `Frame 2121453573` — plan info, transaction
/// receipt, the Welcome Kit, benefits and a help link. Reached from the
/// Profile tab's "My Subscription" rows.
///
/// The Welcome Kit is **fetched** (`GET /mobile/communities/{id}/welcome-kit`)
/// by a [WelcomeKitBloc] scoped to this screen, so each subscription shows its
/// own admin-published kit — not a design sample keyed by community name.
class SubscriptionDetailScreen extends StatelessWidget {
  const SubscriptionDetailScreen({super.key, required this.community});

  final CommunityModel community;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          locator<WelcomeKitBloc>()..add(WelcomeKitEvent.load(community.id)),
      child: SubscriptionDetailView(community: community),
    );
  }
}

/// The screen minus its bloc: it reads a [WelcomeKitBloc] from context, so a
/// test (or a golden) can supply a ready one instead of going through DI.
class SubscriptionDetailView extends StatelessWidget {
  const SubscriptionDetailView({super.key, required this.community});

  final CommunityModel community;

  @override
  Widget build(BuildContext context) {
    final info = community.subscriptionInfo;
    final kitState = context.watch<WelcomeKitBloc>().state;
    final kit = kitState.kit;
    // The kit's own "What You get" wins; the catalog's benefits are the
    // fallback for a community whose kit has none (or has no kit at all).
    final benefits = (kit != null && kit.whatYouGet.isNotEmpty)
        ? kit.whatYouGet
        : community.benefits;

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
        // The kit brackets "What You get": its cards and notices come before,
        // its acknowledgment and sign-off after. That interleaving is why the
        // screen orders these rather than one Welcome Kit widget.
        if (kitState.state.isLoading || kitState.state.isEmpty) ...[
          const WelcomeKitSkeleton(),
          const SizedBox(height: 16),
        ] else if (kitState.state.isError) ...[
          _KitRetry(
            onRetry: () => context.read<WelcomeKitBloc>().add(
              const WelcomeKitEvent.retried(),
            ),
          ),
          const SizedBox(height: 16),
        ] else if (kit != null) ...[
          WelcomeKitSection(kit: kit),
          const SizedBox(height: 16),
        ],
        if (benefits.isNotEmpty) ...[
          SubscriptionBenefitsSection(benefits: benefits),
          const SizedBox(height: 13),
        ],
        if (kit != null) ...[
          const WelcomeKitFooter(),
          const SizedBox(height: 18),
        ],
        _NeedHelpButton(
          onTap: () => context.push(AppRoutes.HELP_SUPPORT_ROUTE_PATH),
        ),
      ],
    );
  }
}

/// Shown only when the kit request *failed* (not when there simply isn't one).
class _KitRetry extends StatelessWidget {
  const _KitRetry({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final type = context.subscriptionType;
    return Row(
      children: [
        Expanded(
          child: Text("Couldn't load your Welcome Kit.", style: type.kitBody),
        ),
        TextButton(onPressed: onRetry, child: const Text('Retry')),
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
