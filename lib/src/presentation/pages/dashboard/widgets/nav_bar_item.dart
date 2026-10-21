import 'package:flutter/material.dart';
import 'package:finskool/src/comman/design_metrics.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// A single bottom-nav tab. It hugs its label (`max(disc, label) + 19px`), as
/// in Figma, where the tabs are different widths.
///
/// Figma: a 31.8px icon disc (`#108B8B` and a white glyph when selected,
/// bare when not), the label 2px below it, and a 23x2 teal underline under the
/// selected label. Everything that changes on select — disc fill, glyph
/// colour, label colour, underline — animates together over 240ms, and the
/// disc gives a small spring on the way in, so a tab switch feels like one
/// movement rather than four.
///
/// The Profile tab shows the real avatar ([customIcon]) with a selected ring
/// instead of a filled disc: a solid teal disc would hide the photo.
class NavBarItem extends StatelessWidget {
  const NavBarItem({
    super.key,
    this.glyph,
    this.customIcon,
    required this.label,
    required this.selected,
    required this.onTap,
    this.badgeCount,
  }) : assert(
         glyph != null || customIcon != null,
         'NavBarItem needs either glyph or customIcon',
       );

  /// An SVG asset path; tinted white when selected.
  final String? glyph;
  final Widget? customIcon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  /// Unread bubble on the icon. Null or 0 hides it.
  final int? badgeCount;

  static const _duration = Duration(milliseconds: 240);

  @override
  Widget build(BuildContext context) {
    final type = context.navType;
    return InkResponse(
      onTap: onTap,
      containedInkWell: true,
      highlightShape: BoxShape.rectangle,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(9.54, 6.2, 9.54, 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween(end: selected ? 1 : 0),
                  duration: _duration,
                  curve: Curves.easeOutBack,
                  builder: (context, t, _) => Transform.scale(
                    scale: 1 + 0.06 * t.clamp(0, 1.2),
                    child: AnimatedContainer(
                      duration: _duration,
                      curve: Curves.easeOutCubic,
                      height: 31.8,
                      width: 31.8,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: customIcon == null && selected
                            ? AppPalette.badgeTeal
                            : Colors.transparent,
                        shape: BoxShape.circle,
                        border: customIcon != null
                            ? Border.all(
                                color: selected
                                    ? AppPalette.badgeTeal
                                    : Colors.transparent,
                                width: 2,
                              )
                            : null,
                      ),
                      child: customIcon ?? _Glyph(glyph!, selected),
                    ),
                  ),
                ),
                if (badgeCount != null && badgeCount! > 0)
                  Positioned(
                    top: -4,
                    right: -10,
                    child: _Badge(count: badgeCount!, selected: selected),
                  ),
              ],
            ),
            const SizedBox(height: 2),
            AnimatedDefaultTextStyle(
              duration: _duration,
              style: selected ? type.active : type.inactive,
              child: Text(label),
            ),
            const SizedBox(height: 3),
            AnimatedContainer(
              duration: _duration,
              curve: Curves.easeOutCubic,
              height: 2,
              width: selected ? 23 : 0,
              decoration: BoxDecoration(
                color: AppPalette.badgeTeal,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Glyph extends StatelessWidget {
  const _Glyph(this.asset, this.selected);

  final String asset;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Color?>(
      tween: ColorTween(
        end: selected ? AppPalette.white : AppPalette.navInactive,
      ),
      duration: NavBarItem._duration,
      // At the export's own size — Figma centres each glyph, 13.5 to 15.9px,
      // in the disc; forcing one size would scale the smaller ones up.
      builder: (context, color, _) => Transform.scale(
        // Figma's 13–16px glyphs read small on Android; see `iconScaleOf`.
        scale: iconScaleOf(context),
        child: SvgPicture.asset(
          asset,
          colorFilter: ColorFilter.mode(color!, BlendMode.srcIn),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.count, required this.selected});

  final int count;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Container(
      height: 16,
      constraints: const BoxConstraints(minWidth: 22),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        // Figma's nav badges are neutral: slate unselected, near-black on the
        // selected tab.
        color: selected ? AppPalette.reactionRing : AppPalette.postMeta,
        borderRadius: BorderRadius.circular(AppRadii.xs),
      ),
      child: Text(
        count > 99 ? '99+' : '$count',
        style: tt.labelSmall?.copyWith(
          color: AppPalette.white,
          fontSize: 9,
          height: 1.0,
        ),
      ),
    );
  }
}
