import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// A single bottom-nav tab: icon + label; [selected] shows the icon on a
/// filled teal circular badge plus a small underline indicator.
class NavBarItem extends StatelessWidget {
  const NavBarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
    this.badgeCount,
  });

  final IconData icon;
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
                    color: selected ? cs.primary : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(icon,
                      color: selected ? cs.onPrimary : color, size: 22),
                ),
                if (badgeCount != null && badgeCount! > 0)
                  Positioned(
                    top: -2,
                    right: -6,
                    child: Container(
                      height: 15,
                      constraints: const BoxConstraints(minWidth: 19),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: cs.error,
                        borderRadius: BorderRadius.circular(AppRadii.pill),
                        border: Border.all(color: cs.surface, width: 1.5),
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
