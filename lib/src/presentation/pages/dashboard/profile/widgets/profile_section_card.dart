import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// A titled section on the Profile screen — "My Subscription", "Account",
/// "Support", "Finskool21", "Settings" — each a heading over a white rounded
/// card holding its [ProfileMenuRow] children, with a hairline divider
/// between rows (not after the last, matching the Reactions sheet's
/// divider convention already used elsewhere in this app).
class ProfileSectionCard extends StatelessWidget {
  const ProfileSectionCard({
    super.key,
    required this.title,
    required this.rows,
  });

  final String title;
  final List<Widget> rows;

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) return const SizedBox.shrink();
    final type = context.profileType;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: type.sectionTitle),
          const SizedBox(height: AppSpacing.sm),
          Container(
            decoration: BoxDecoration(
              // Flat grey, not the white-with-shadow card the rest of the
              // app uses — matched against the user's reference screenshot
              // rather than the Communities card convention.
              color: AppPalette.profileCardFill,
              borderRadius: AppRadii.large,
            ),
            child: Column(
              children: [
                for (var i = 0; i < rows.length; i++) ...[
                  rows[i],
                  if (i != rows.length - 1)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md),
                      child: Divider(
                          height: 1, color: AppPalette.rowDivider),
                    ),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}
