import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/comman/routes.dart';
import 'package:finskool/src/presentation/bloc/communities/list/communities_bloc.dart';
import 'package:finskool/src/presentation/bloc/communities/purchase/community_purchase_bloc.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// The payment isn't visible on the server yet. That is **not** a failure —
/// the Razorpay webhook can land after the page did — so the copy says money
/// may have moved and access will arrive, and offers no way to pay again.
class PaymentPendingView extends StatelessWidget {
  const PaymentPendingView({super.key});

  @override
  Widget build(BuildContext context) {
    final type = context.communityType;
    return Column(
      children: [
        const Spacer(flex: 2),
        Text(
          "We're confirming your payment",
          textAlign: TextAlign.center,
          style: type.price.copyWith(fontSize: 22),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          "If money was deducted, your access will be added shortly. "
          'You do not need to pay again.',
          textAlign: TextAlign.center,
          style: type.description,
        ),
        const Spacer(flex: 2),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => context.read<CommunityPurchaseBloc>().add(
              const CommunityPurchaseEvent.recheck(),
            ),
            child: const Text('Check again'),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        TextButton(
          onPressed: () {
            context.read<CommunitiesBloc>().add(
              const CommunitiesEvent.refresh(),
            );
            context.read<CommunityPurchaseBloc>().add(
              const CommunityPurchaseEvent.cleared(),
            );
            context.go(AppRoutes.DASHBOARD_ROUTE_PATH);
          },
          child: const Text('Back to communities'),
        ),
        const SizedBox(height: AppSpacing.xl),
      ],
    );
  }
}
