import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'profile_glyphs.dart';

/// Every row on the Profile screen: a 36px teal tile holding Figma's white
/// glyph, a title (+ optional subtitle) and a trailing slot.
///
/// Measured from the Final page: 10px above and below the 36px tile (56 in
/// all), 12 between the tile and the text, title Inter 600 13/18, subtitle
/// Inter 400 11/15 with 2 between. A row with no subtitle centres its title
/// on the tile; a wrapped title grows the row and keeps the tile centred.
class ProfileMenuRow extends StatelessWidget {
  const ProfileMenuRow({
    super.key,
    required this.glyph,
    required this.title,
    this.subtitle,
    this.subtitleStyle,
    this.trailing,
    this.onTap,
    this.showChevron = true,
  });

  /// An asset path from [ProfileGlyphs].
  final String glyph;
  final String title;
  final String? subtitle;
  final TextStyle? subtitleStyle;

  /// Replaces the chevron (a toggle, a Renew pill).
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    final type = context.profileType;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              height: 36,
              width: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppPalette.badgeTeal,
                borderRadius: BorderRadius.circular(11),
              ),
              child: SvgPicture.asset(glyph),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title, style: type.rowTitle),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(subtitle!, style: subtitleStyle ?? type.rowSubtitle),
                  ],
                ],
              ),
            ),
            if (trailing != null) ...[const SizedBox(width: 8), trailing!],
            if (showChevron && onTap != null) ...[
              const SizedBox(width: 10),
              SvgPicture.asset(ProfileGlyphs.chevron),
            ],
          ],
        ),
      ),
    );
  }
}
