import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// Icon + text label placed above a field, matching the auth screens where
/// the icon sits beside the label rather than inside the input box.
///
/// [iconAsset] is one of [AuthFieldIcons] — the exact SVG exported from
/// Figma — not a Material [IconData], so the glyph matches the design.
class FieldLabel extends StatelessWidget {
  const FieldLabel({super.key, required this.iconAsset, required this.label});

  final String iconAsset;
  final String label;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          iconAsset,
          height: 14,
          width: 14,
          colorFilter: ColorFilter.mode(cs.onSurface, BlendMode.srcIn),
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(label, style: tt.titleSmall),
      ],
    );
  }
}
