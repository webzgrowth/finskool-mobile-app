import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/domain/model/reaction_type.dart';
import 'reaction_icons.dart';

/// Renders one reaction at [size], preferring the illustrated art exported
/// from Figma and falling back to the emoji glyph.
///
/// Only 👍 (vector) and ❤️ (raster) have art; the rest render as emoji text,
/// which is what Figma does too, so the fallback is the design rather than a
/// compromise.
class ReactionGlyph extends StatelessWidget {
  const ReactionGlyph({super.key, required this.reaction, required this.size});

  final ReactionType reaction;
  final double size;

  /// Emoji ink sits high inside its line box, so a glyph centred by layout
  /// still looks lifted inside a round badge.
  ///
  /// Measured, not guessed — but measured against the *previous* reaction
  /// set: rendered all six badges at a 60pt disc and compared each glyph's
  /// ink centroid to the disc centre. The two symmetric glyphs of that set,
  /// ✅ and 😮 (whose centroid must equal their optical centre), both landed
  /// 3.58pt high, i.e. 9.94% of the 36pt art box.
  ///
  /// ✅ and 👏 have since been replaced by 😢 and 😡 to match the backend's
  /// seeded reaction types, so **re-measure** against 😂 😢 😡 — and on
  /// Android (Noto Color Emoji), since this figure came from Apple Color
  /// Emoji.
  static const double _emojiInkRise = 0.0994;

  @override
  Widget build(BuildContext context) {
    final svg = ReactionIcons.svgBadge(reaction);
    final png = ReactionIcons.pngBadge(reaction);
    return SizedBox(
      height: size,
      width: size,
      child: switch ((svg, png)) {
        (final String s, _) => SvgPicture.asset(s, fit: BoxFit.contain),
        (_, final String p) => Image.asset(p, fit: BoxFit.contain),
        _ => Transform.translate(
            offset: Offset(0, size * _emojiInkRise),
            child: FittedBox(
              fit: BoxFit.contain,
              // See ReactionPickerRow: `inherit: false` keeps the theme's
              // custom font family from turning ❤ monochrome.
              child: Text(
                reaction.emoji,
                style:
                    const TextStyle(inherit: false, fontSize: 24, height: 1.0),
              ),
            ),
          ),
      },
    );
  }
}

/// A [ReactionGlyph] on the coloured disc Figma puts it on — used in the
/// post card's badge stack and the Reactions sheet's filter row.
///
/// Each reaction gets its own colour (blue like, red love, green clap, …)
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
