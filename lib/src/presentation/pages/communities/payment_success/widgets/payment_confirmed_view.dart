import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/comman/ist_time.dart';
import 'package:finskool/src/comman/routes.dart';
import 'package:finskool/src/comman/widgets/success_animation.dart';
import 'package:finskool/src/presentation/bloc/communities/list/communities_bloc.dart';
import 'package:finskool/src/presentation/bloc/communities/purchase/community_purchase_bloc.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// The Figma success: price, the line under it, when, and Continue. The
/// transaction id and method the mock used to show are gone — the API doesn't
/// return them — and "active until" is the server's own date.
class PaymentConfirmedView extends StatelessWidget {
  const PaymentConfirmedView({super.key, required this.state});

  final CommunityPurchaseState state;

  @override
  Widget build(BuildContext context) {
    final type = context.communityType;
    final needsCompliance = context
        .read<CommunityPurchaseBloc>()
        .needsCompliance;
    final until = state.expiresAt;
    return Column(
      children: [
        const Spacer(flex: 2),
        const SuccessAnimation(size: 160),
        const SizedBox(height: AppSpacing.xl),
        Text(state.plan!.priceLabel, style: type.price.copyWith(fontSize: 28)),
        const SizedBox(height: AppSpacing.md),
        Text(
          'Your payment has been successfully processed. '
          '${needsCompliance ? 'Complete the required details to finish setting up your access.' : 'Your community access is now unlocked.'}',
          textAlign: TextAlign.center,
          style: type.description,
        ),
        const Spacer(),
        if (until != null)
          Text(
            "You're active until ${formatIst(until, 'd MMMM yyyy')}",
            style: type.pricePeriod,
          ),
        const SizedBox(height: AppSpacing.lg),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => _continue(context, needsCompliance),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(needsCompliance ? 'Continue to Compliance' : 'Continue'),
                const SizedBox(width: AppSpacing.xs),
                const Icon(Icons.arrow_forward, size: 16),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
      ],
    );
  }

  void _continue(BuildContext context, bool needsCompliance) {
    if (needsCompliance) {
      context.push(AppRoutes.COMMUNITY_COMPLIANCE_ROUTE_PATH);
      return;
    }
    // Access is already real; re-read the catalog so the card flips.
    context.read<CommunitiesBloc>().add(const CommunitiesEvent.refresh());
    context.read<CommunityPurchaseBloc>().add(
      const CommunityPurchaseEvent.cleared(),
    );
    context.go(AppRoutes.DASHBOARD_ROUTE_PATH);
  }
}
