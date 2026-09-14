import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// The concentric-ring success mark on the payment screen.
///
/// Figma draws two ellipses (300 and 190) behind an illustration and marks
/// the area "Subtle animation" (`911:20528`) — this scales the rings in on
/// entry to honour that note without inventing a bespoke illustration.
class SuccessBadge extends StatelessWidget {
  const SuccessBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOutBack,
      builder: (context, t, child) =>
          Transform.scale(scale: t.clamp(0, 1), child: child),
      child: Container(
        height: 160,
        width: 160,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppPalette.badgeTeal.withValues(alpha: 0.06),
          shape: BoxShape.circle,
        ),
        child: Container(
          height: 104,
          width: 104,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppPalette.badgeTeal.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.check_rounded, size: 52, color: cs.primary),
        ),
      ),
    );
  }
}
