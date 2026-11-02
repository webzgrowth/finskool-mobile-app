import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finskool/src/presentation/bloc/communities/purchase/community_purchase_bloc.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'widgets/payment_confirmed_view.dart';
import 'widgets/payment_message_view.dart';
import 'widgets/payment_pending_view.dart';

/// What comes after the checkout page — Figma `893:16761` for the happy path.
///
/// **Payment happens on the web checkout, not here.** This screen only shows
/// the *server's* answer: confirming (polling `/auth/mobile/me`), confirmed
/// (the Figma success), or pending (still not visible — money may have been
/// taken, so it says so and never invites a second payment).
class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.screen,
          child: BlocBuilder<CommunityPurchaseBloc, CommunityPurchaseState>(
            builder: (context, state) {
              // Opened cold (deep link, hot restart) with nothing bought.
              if (!state.hasPurchase) {
                return const PaymentMessageView(
                  message: 'No payment in progress.',
                );
              }
              return switch (state.status) {
                PurchaseStatus.confirmed => PaymentConfirmedView(state: state),
                PurchaseStatus.pending => const PaymentPendingView(),
                _ => const PaymentMessageView(
                  message: 'Confirming your payment…',
                  busy: true,
                ),
              };
            },
          ),
        ),
      ),
    );
  }
}
