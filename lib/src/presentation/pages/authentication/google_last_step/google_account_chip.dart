import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// The selected-Google-account row shown at the top of the "One last step"
/// screen: avatar with the Google "G" mark, name/email, and a verified
/// checkmark badge — not a tappable list item, just a confirmation.
class GoogleAccountChip extends StatelessWidget {
  const GoogleAccountChip({super.key, required this.name, required this.email});

  final String name;
  final String email;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        border: Border.all(color: cs.outlineVariant),
        borderRadius: AppRadii.medium,
      ),
      child: Row(
        children: [
          Container(
            height: 34,
            width: 34,
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset('assets/icons/google.svg', height: 18, width: 18),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: tt.titleMedium),
                Text(email, style: tt.bodySmall),
              ],
            ),
          ),
          // PLACEHOLDER: Figma's exact "verify" badge SVG (node 619:6095)
          // couldn't be pulled — the MCP server's monthly quota was
          // exhausted. Swap this Icon for that asset once quota resets.
          Container(
            height: 29,
            width: 29,
            decoration: BoxDecoration(color: cs.primary, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Icon(Icons.check, size: 16, color: cs.onPrimary),
          ),
        ],
      ),
    );
  }
}
