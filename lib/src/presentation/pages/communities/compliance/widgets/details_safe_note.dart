import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/presentation/pages/authentication/widgets/auth_field_icons.dart';

/// The reassurance panel under the compliance fields (Figma `893:16754`).
class DetailsSafeNote extends StatelessWidget {
  const DetailsSafeNote({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final type = context.communityType;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppPalette.communityChipTint.withValues(alpha: 0.06),
        borderRadius: AppRadii.small,
        border: Border.all(color: AppPalette.communityChipBorder, width: 0.862),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: SvgPicture.asset(
              AuthFieldIcons.shieldUser,
              height: 15,
              width: 15,
              colorFilter: ColorFilter.mode(cs.primary, BlendMode.srcIn),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Your details are safe',
                    style: type.planLabel.copyWith(color: cs.secondary)),
                const SizedBox(height: 2),
                Text(
                  'Stored securely and used only to meet SEBI requirements. '
                  'Never shared with other members.',
                  style: type.pricePeriod,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
