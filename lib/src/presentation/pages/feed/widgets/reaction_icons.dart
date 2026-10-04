import 'package:flutter/widgets.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/domain/model/reaction_type.dart';

/// The exact reaction art exported from Figma.
///
/// Figma draws the long-press picker's six reactions as plain **emoji text**
/// — the frame is literally named "Picker" (`605:17127`) and each child is a
/// text node holding an emoji character. Emoji are therefore the design
/// here, not a stand-in for missing art. (Figma drew a different six —
/// 👍❤️🔥👏✅😮 — but the backend's seeded set is authoritative.)
///
/// Two things do have real art, and they are different in kind:
/// * [likeButton] is a monochrome UI glyph (one path, `#7D7D91`) — the Like
///   control, and the only asset that can be tinted.
/// * the badge art below is full-colour illustration (gradients, skin tone)
///   used in the post card's reaction stack at ~12px.
class ReactionIcons {
  ReactionIcons._();

  /// `thumbs-up-fill_svgrepo.com` — 16x16 inside Figma's 24x24 Like control.
  static const String likeButton = 'assets/icons/reaction_like_fill.svg';

  static const String _likeBadge = 'assets/icons/reaction_like.svg';
  static const String _loveBadge = 'assets/icons/reaction_heart.png';

  /// Vector badge art, or null when the reaction only exists as an emoji.
  static String? svgBadge(ReactionType reaction) =>
      reaction == ReactionType.like ? _likeBadge : null;

  /// Raster badge art (the heart was uploaded as an image, not a vector).
  static String? pngBadge(ReactionType reaction) =>
      reaction == ReactionType.love ? _loveBadge : null;

  /// The coloured disc behind a reaction in the post card's badge stack.
  ///
  /// Figma's colourful feed variant (`605:15302`) specifies discs for
  /// thumbs-up (blue `#388FE7`), heart (red `#F15759`), clap (green
  /// `#6DAE53`), bulb (amber) and laughing (teal) — a set that only partly
  /// overlaps the reactions this app offers. So: like and love
  /// are Figma's own, `haha` takes the teal Figma gave its laughing emoji,
  /// and `wow` and `angry` reuse the remaining palette tokens rather
  /// than inventing new ones. Figma never designed those two —
  /// **confirm with the designer** before treating them as final.
  static Color badgeColor(BuildContext context, ReactionType reaction) {
    final g = context.gradients;
    return switch (reaction) {
      ReactionType.like => g.badgeLike,
      ReactionType.love => g.badgeLove,
      ReactionType.haha => g.badgeHaha,
      ReactionType.wow => g.badgeWow,
      ReactionType.angry => g.badgeAngry,
    };
  }
}
