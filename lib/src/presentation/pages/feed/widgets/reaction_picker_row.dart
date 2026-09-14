import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/domain/model/reaction_type.dart';
import 'reaction_picker_overlay.dart';

/// The 6-emoji row itself — entrance scale/fade-in, and each glyph scales
/// up while the finger is dragged over it (Facebook/LinkedIn-style).
///
/// Sizes come from Figma's `Picker` frame; see [ReactionPickerOverlay] for
/// the measurements. The emoji are the design, not placeholder art — Figma
/// uses text nodes holding the same six characters.
class ReactionPickerRow extends StatelessWidget {
  const ReactionPickerRow({
    super.key,
    required this.reactions,
    required this.hoveredIndex,
  });

  final List<ReactionType> reactions;
  final ValueNotifier<int?> hoveredIndex;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOutBack,
      builder: (context, t, child) => Opacity(
        opacity: t.clamp(0, 1),
        child: Transform.scale(scale: t, child: child),
      ),
      child: Container(
        height: ReactionPickerOverlay.pillHeight,
        width: ReactionPickerOverlay.pillWidth,
        padding: const EdgeInsets.symmetric(
          horizontal: ReactionPickerOverlay.padH,
        ),
        // Figma: #F2F2F2 plate, 0.38px #D7D7D7 hairline, fully rounded,
        // drop shadow 12.56 blur at (0, 3.77) in #1A1A1A @ 10%.
        decoration: BoxDecoration(
          color: context.gradients.pickerSurface,
          borderRadius: BorderRadius.circular(AppRadii.pill),
          border: Border.all(
            color: context.gradients.pickerBorder,
            width: ReactionPickerOverlay.borderWidth,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow
                  .withValues(alpha: 0.10),
              blurRadius: 12.56,
              offset: const Offset(0, 3.77),
            ),
          ],
        ),
        child: ValueListenableBuilder<int?>(
          valueListenable: hoveredIndex,
          builder: (context, hovered, _) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(reactions.length, (i) {
                return SizedBox(
                  // Each slot owns a full pitch so the hit-test maths in
                  // `updateHover` and the layout can't drift apart; the last
                  // one is only as wide as the item itself.
                  width: i == reactions.length - 1
                      ? ReactionPickerOverlay.itemExtent
                      : ReactionPickerOverlay.pitch,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AnimatedScale(
                      scale: hovered == i ? 1.6 : 1.0,
                      duration: const Duration(milliseconds: 120),
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: ReactionPickerOverlay.itemExtent,
                        child: Center(
                          // `inherit: false` matters: the app theme sets a
                          // custom fontFamily (Inter/Manrope), and U+2764
                          // (❤) defaults to *text* presentation, so it
                          // resolves to a monochrome glyph in that family
                          // instead of falling through to colour emoji.
                          // Dropping the inherited family fixes the heart
                          // without affecting the others.
                          child: Text(
                            reactions[i].emoji,
                            style: const TextStyle(
                              inherit: false,
                              fontSize: ReactionPickerOverlay.glyphSize,
                              height: 1.0,
                            ),
                          ),
                        ),
                      ),
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
