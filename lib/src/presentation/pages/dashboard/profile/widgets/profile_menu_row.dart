import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// One row shape, reused for every Profile menu item — Figma (`893:16138`)
/// draws every row identically: an 18×18 bordered icon box, title/subtitle
/// stacked, then a trailing slot at the far edge. The slot differs per row
/// (a chevron, a `Switch`, a Renew pill, a count badge), so [trailing] is a
/// plain `Widget?` rather than three separate row variants.
class ProfileMenuRow extends StatelessWidget {
  const ProfileMenuRow({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.subtitleColor,
    this.trailing,
    this.onTap,
  });

  final Widget icon;
  final String title;
  final String? subtitle;

  /// Overrides the subtitle's color — used by an expiring subscription's
  /// "Expires in N days" (red), which needs to stand out from the plain
  /// grey every other row's subtitle uses.
  final Color? subtitleColor;

  /// Defaults to a chevron when null and [onTap] is set — most rows just
  /// navigate. Pass an explicit widget (a `Switch`, a "Renew" pill, a count
  /// badge) to override it, or `const SizedBox.shrink()` for none at all.
  final Widget? trailing;
  final VoidCallback? onTap;

  static const double _iconBox = 32;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final type = context.profileType;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 10),
        child: Row(
          children: [
            Container(
              height: _iconBox,
              width: _iconBox,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppPalette.secondary,
                shape: BoxShape.circle,
              ),
              child: IconTheme(
                data: IconThemeData(size: 16, color: cs.onPrimary),
                child: icon,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title, style: type.rowTitle),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(subtitle!,
                        style: subtitleColor == null
                            ? type.rowSubtitle
                            : type.rowSubtitle.copyWith(color: subtitleColor)),
                  ],
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            trailing ??
                (onTap == null
                    ? const SizedBox.shrink()
                    : Icon(Icons.chevron_right_rounded,
                        size: 18, color: cs.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }
}
