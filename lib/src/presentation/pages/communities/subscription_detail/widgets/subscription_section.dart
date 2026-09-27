import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// A teal-header + tinted-body card, used for Plan Details, Transaction
/// Details and What You get — Figma `Frame 2121453551`.
///
/// The body is [AppPalette.subscriptionBody], a shade off the white sheet
/// it sits on, with a hairline border; the two together are what separate
/// the card from the page rather than a shadow.
class SubscriptionSection extends StatelessWidget {
  const SubscriptionSection({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final type = context.subscriptionType;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadii.md),
        border: Border.all(color: AppPalette.subscriptionBorder),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: 10,
            ),
            color: AppPalette.primary,
            child: Text(title, style: type.sectionTitle),
          ),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            color: AppPalette.subscriptionBody,
            child: child,
          ),
        ],
      ),
    );
  }
}
