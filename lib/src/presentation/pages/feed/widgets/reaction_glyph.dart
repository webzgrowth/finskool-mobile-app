import 'package:flutter/material.dart';
import 'package:finskool/src/domain/model/reaction_type.dart';

import 'reaction_icons.dart';

/// Renders one reaction at [size] — always as its **emoji**, the same glyph the
/// picker offers, so choosing a reaction and seeing it on the Like control, in
/// the badge stack, in the Reactions sheet and beside a reactor's name all show
/// the identical picture.
///
/// It used to prefer Figma's illustrated art (a vector 👍, a raster ❤️, a vector
/// 😂) and fall back to emoji for the rest. That meant the picker (emoji text,
/// as Figma draws it) and everywhere else (illustrations) disagreed, and
/// insightful / celebrate, which have no art, were the only ones that matched.
class ReactionGlyph extends StatelessWidget {
  const ReactionGlyph({super.key, required this.reaction, required this.size});

  final ReactionType reaction;
  final double size;

  /// Emoji ink sits high inside its line box, so a glyph centred by layout
  /// still looks lifted inside a round badge.
  ///
  /// Measured, not guessed — but against an *earlier* reaction set: all six
  /// badges rendered at a 60pt disc, each glyph's ink centroid compared to the
  /// disc centre; the two symmetric glyphs (✅ and 😮) both landed 3.58pt high,
  /// i.e. 9.94% of the 36pt art box. The set is now 🔥 and 🚀 as emoji, so
  /// **re-measure** against those — and on Android (Noto Color Emoji), since
  /// this figure came from Apple Color Emoji.
  static const double _emojiInkRise = 0.0994;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: Transform.translate(
        offset: Offset(0, size * _emojiInkRise),
        child: FittedBox(
          fit: BoxFit.contain,
          // See ReactionPickerRow: `inherit: false` keeps the theme's custom
          // font family from turning ❤ monochrome.
          child: Text(
            reaction.emoji,
            style: const TextStyle(inherit: false, fontSize: 24, height: 1.0),
          ),
        ),
      ),
    );
  }
}

/// A [ReactionGlyph] on the coloured disc Figma puts it on — used in the
/// post card's badge stack and the Reactions sheet's filter row.
///
/// Each reaction gets its own colour (blue like, red love, green rocket, …)
/// per Figma's colourful feed variant; see [ReactionIcons.badgeColor].
class ReactionBadge extends StatelessWidget {
  const ReactionBadge({
    super.key,
    required this.reaction,
    required this.diameter,
    required this.art,
  });

  final ReactionType reaction;
  final double diameter;
  final double art;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: diameter,
      width: diameter,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: ReactionIcons.badgeColor(context, reaction),
        shape: BoxShape.circle,
      ),
      child: ReactionGlyph(reaction: reaction, size: art),
    );
  }
}
