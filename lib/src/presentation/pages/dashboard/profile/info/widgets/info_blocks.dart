import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// "ABOUT US", "CONTACT & OFFICE" — the small upper-case label above a plate.
class InfoSectionLabel extends StatelessWidget {
  const InfoSectionLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(0, 22, 0, 8),
    child: Text(
      text.toUpperCase(),
      style: context.infoType.sectionLabel.copyWith(letterSpacing: 0.88),
    ),
  );
}

/// The `#F6F6F6` rounded plate every block sits on.
class InfoPlate extends StatelessWidget {
  const InfoPlate({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.color = AppPalette.ticketCard,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: padding,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(16),
    ),
    child: child,
  );
}

class InfoHairline extends StatelessWidget {
  const InfoHairline({super.key});

  @override
  Widget build(BuildContext context) =>
      const Divider(height: 1, thickness: 1, color: AppPalette.infoHairline);
}

/// A 36px white tile holding an 18px glyph — the icon on every info row.
class InfoIconTile extends StatelessWidget {
  const InfoIconTile({super.key, required this.asset, this.tint});

  final String asset;

  /// For a white-on-teal profile glyph reused on this white tile; the `info_*`
  /// exports are already teal and need none.
  final Color? tint;

  @override
  Widget build(BuildContext context) => Container(
    height: 36,
    width: 36,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: AppPalette.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: SvgPicture.asset(
      asset,
      height: 18,
      width: 18,
      colorFilter: tint == null
          ? null
          : ColorFilter.mode(tint!, BlendMode.srcIn),
    ),
  );
}

/// Icon tile · title (+ optional subtitle / extra) · chevron. 64 tall when it
/// carries a subtitle, the single-line document rows included.
class InfoRow extends StatelessWidget {
  const InfoRow({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.extra,
    this.onTap,
    this.iconTint,
  });

  final String icon;
  final Color? iconTint;
  final String title;
  final String? subtitle;

  /// Under the subtitle — the "Get directions →" link.
  final Widget? extra;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final type = context.infoType;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoIconTile(asset: icon, tint: iconTint),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: subtitle == null ? 10 : 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: type.rowTitle),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(subtitle!, style: type.rowSub),
                    ],
                    ?extra,
                  ],
                ),
              ),
            ),
            if (onTap != null)
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 11),
                child: SvgPicture.asset(
                  'assets/icons/info_chevron.svg',
                  height: 14,
                  width: 14,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
