import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// A [AppPalette.primary] header bar over a near-white body, used by the
/// Subscription Detail and Edit Profile screens.
///
/// The body is [AppPalette.subscriptionBody] — a shade off the white sheet
/// it sits on — with a hairline border; those two together separate the
/// card from the page rather than a shadow.
///
/// [trailing] puts an action in the header bar (Edit Profile's pencil).
/// Distinct from `ProfileSectionCard`, which is the Profile tab's plain
/// title-over-grey-card treatment.
class TealSectionCard extends StatelessWidget {
  const TealSectionCard({
    super.key,
    required this.title,
    required this.child,
    this.trailing,
  });

  final String title;
  final Widget child;
  final Widget? trailing;

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
            child: Row(
              children: [
                Expanded(child: Text(title, style: type.sectionTitle)),
                ?trailing,
              ],
            ),
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
