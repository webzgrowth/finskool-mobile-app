import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:finskool/src/comman/routes.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/presentation/bloc/communities/list/communities_bloc.dart';
import 'package:finskool/src/presentation/bloc/communities/purchase/community_purchase_bloc.dart';
import 'widgets/success_badge.dart';

/// Shown straight after a (currently mocked) payment — Figma `893:16761`.
///
/// **There is no payment gateway yet.** `CommunityPurchaseBloc` fabricates
/// the transaction so this screen and the compliance step can be built and
/// tested end to end; wire a real gateway in ahead of this screen when one
/// is chosen.
///
/// The CTA goes to compliance only when the user hasn't done it before —
/// it's a one-time SEBI step, so a second purchase unlocks immediately.
class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final type = context.communityType;
    final purchase = context.watch<CommunityPurchaseBloc>();
    final state = purchase.state;

    // Opened cold (deep link, hot restart) with nothing bought.
    if (!state.hasPurchase) {
      return Scaffold(
        backgroundColor: cs.surface,
        body: Center(
          child: Padding(
            padding: AppSpacing.screen,
            child: Text('No payment in progress.',
                textAlign: TextAlign.center, style: type.description),
          ),
        ),
      );
    }

    final needsCompliance = purchase.needsCompliance;
    final paidAt = state.paidAt ?? DateTime.now();

    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.screen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              const SuccessBadge(),
              const SizedBox(height: AppSpacing.xl),
              Text(state.plan!.priceLabel,
                  style: type.price.copyWith(fontSize: 28)),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Your payment has been successfully processed. '
                '${needsCompliance ? 'Complete the required details to unlock your community access.' : 'Your community access is now unlocked.'}',
                textAlign: TextAlign.center,
                style: type.description,
              ),
              const Spacer(),
              Text(DateFormat('d MMMM yyyy h:mm a').format(paidAt),
                  style: type.pricePeriod),
              const SizedBox(height: 2),
              Text(
                '${state.paymentMethod} transaction ID: ${state.transactionId}',
                style: type.pricePeriod,
              ),
              const SizedBox(height: AppSpacing.lg),
              _ContinueButton(needsCompliance: needsCompliance),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContinueButton extends StatelessWidget {
  const _ContinueButton({required this.needsCompliance});

  final bool needsCompliance;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (needsCompliance) {
            context.push(AppRoutes.COMMUNITY_COMPLIANCE_ROUTE_PATH);
            return;
          }
          // Compliance already done — unlock now and go back to the list.
          final community =
              context.read<CommunityPurchaseBloc>().state.community!;
          context
              .read<CommunitiesBloc>()
              .add(CommunitiesEvent.unlockCommunity(community.id));
          context.go(AppRoutes.DASHBOARD_ROUTE_PATH);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(needsCompliance ? 'Continue to Compliance' : 'Continue'),
            const SizedBox(width: AppSpacing.xs),
            const Icon(Icons.arrow_forward, size: 16),
          ],
        ),
      ),
    );
  }
}
