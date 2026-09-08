import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/domain/model/reaction_type.dart';

/// The 6-emoji row itself — entrance scale/fade-in, and each icon scales
/// up while the finger is dragged over it (Facebook/LinkedIn-style).
class ReactionPickerRow extends StatelessWidget {
  const ReactionPickerRow({
    super.key,
    required this.reactions,
    required this.hoveredIndex,
    required this.itemSize,
  });

  final List<ReactionType> reactions;
  final ValueNotifier<int?> hoveredIndex;
  final double itemSize;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOutBack,
      builder: (context, t, child) =>
          Opacity(opacity: t.clamp(0, 1), child: Transform.scale(scale: t, child: child)),
      child: Container(
        height: itemSize,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(AppRadii.pill),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ValueListenableBuilder<int?>(
          valueListenable: hoveredIndex,
          builder: (context, hovered, _) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(reactions.length, (i) {
                final isHovered = hovered == i;
                return AnimatedScale(
                  scale: isHovered ? 1.5 : 1.0,
                  duration: const Duration(milliseconds: 120),
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: itemSize - 8,
                    child: Center(
                      child: Text(reactions[i].emoji,
                          style: const TextStyle(fontSize: 24)),
                    ),
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
