import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// A bordered row showing a value collected on a previous screen (e.g. the
/// phone number entered during signup) with a trailing edit action — the
/// "Verify your number" card's confirmation field.
class ReadonlyValueField extends StatelessWidget {
  const ReadonlyValueField({
    super.key,
    required this.iconAsset,
    required this.value,
    required this.actionLabel,
    required this.onTap,
  });

  final String iconAsset;
  final String value;
  final String actionLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      decoration: BoxDecoration(
        border: Border.all(color: cs.outlineVariant),
        borderRadius: AppRadii.medium,
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            iconAsset,
            height: 15,
            width: 15,
            colorFilter: ColorFilter.mode(cs.onSurface, BlendMode.srcIn),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(child: Text(value, style: tt.bodyLarge)),
          GestureDetector(
            onTap: onTap,
            child: Text(
              actionLabel,
              style: inter(size: 12, weight: 700, height: 1.4, color: cs.primary),
            ),
          ),
        ],
      ),
    );
  }
}
