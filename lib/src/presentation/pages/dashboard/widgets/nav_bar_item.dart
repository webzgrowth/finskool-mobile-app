import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// A single bottom-nav tab: icon + label; [selected] shows the icon on a
/// filled teal circular badge plus a small underline indicator.
class NavBarItem extends StatelessWidget {
  const NavBarItem({
    super.key,
    this.icon,
    this.customIcon,
    required this.label,
    required this.selected,
    required this.onTap,
    this.badgeCount,
  }) : assert(icon != null || customIcon != null,
            'NavBarItem needs either icon or customIcon');

  /// Falls back to this when [customIcon] is absent.
  final IconData? icon;

  /// Overrides [icon] entirely — the Profile tab's real avatar photo isn't
  /// a glyph at all (Figma's nav bar has no icon for it, just a filled
  /// circle), so it needs to render a `UserAvatar` instead of an `Icon`.
  final Widget? customIcon;

  final String label;
  final bool selected;
  final VoidCallback onTap;

  /// Unread count bubble on the icon — the Figma nav shows "100" on Feed
  /// and "50" on Communities (`750:1638`, `750:1654`). Null or 0 hides it.
  final int? badgeCount;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final color = selected ? cs.primary : cs.onSurfaceVariant;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    // A photo avatar (Profile) gets a selected *ring*
                    // instead of a filled disc — a solid teal circle
                    // behind a photo would hide most of it. Icon tabs
                    // keep the existing filled-disc treatment.
                    color: customIcon == null && selected
                        ? cs.primary
                        : Colors.transparent,
                    shape: BoxShape.circle,
                    border: customIcon != null && selected
                        ? Border.all(color: cs.primary, width: 2)
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: customIcon ??
                      Icon(icon,
                          color: selected ? cs.onPrimary : color, size: 22),
                ),
                if (badgeCount != null && badgeCount! > 0)
                  Positioned(
                    top: -4,
                    right: -10,
                    child: Container(
                      height: 16,
                      constraints: const BoxConstraints(minWidth: 22),
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        // Not `error` red: Figma's nav badges are neutral —
                        // slate on an unselected tab, near-black on the
                        // selected one. (Read from the design screenshot;
                        // re-measure the exact hexes when Figma is
                        // reachable again.)
                        color: selected
                            ? AppPalette.reactionRing
                            : AppPalette.postMeta,
                        borderRadius: BorderRadius.circular(AppRadii.xs),
                      ),
                      child: Text(
                        badgeCount! > 99 ? '99+' : '$badgeCount',
                        style: tt.labelSmall?.copyWith(
                          color: cs.onError,
                          fontSize: 9,
                          height: 1.0,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 2),
            Text(label, style: tt.labelSmall?.copyWith(color: color)),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 3,
              width: selected ? 16 : 0,
              decoration: BoxDecoration(
                color: cs.primary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
