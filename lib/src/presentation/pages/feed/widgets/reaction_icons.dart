import 'package:flutter/widgets.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/domain/model/reaction_type.dart';

/// The exact reaction art exported from Figma.
///
/// Figma draws the long-press picker's six reactions as plain **emoji text**
/// — the frame is literally named "Picker" (`605:17127`) and each child is a
/// text node holding 👍❤️🔥👏✅😮. Emoji are therefore the design here, not a
/// stand-in for missing art.
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
  /// Figma's colourful feed variant (`605:15302`) specifies only three of
  /// our six: thumbs-up on blue `#388FE7`, heart on red `#F15759`, clap on
  /// green `#6DAE53`. Its remaining two discs belong to reactions we don't
  /// have (bulb on amber, laughing on teal), so those colours are
  /// **reassigned** to `wow` and `verified`, and `fire` takes the orange
  /// from Figma's own laughing-emoji artwork. Worth confirming with the
  /// designer if exact parity matters.
  static Color badgeColor(BuildContext context, ReactionType reaction) {
    final g = context.gradients;
    return switch (reaction) {
      ReactionType.like => g.badgeLike,
      ReactionType.love => g.badgeLove,
      ReactionType.fire => g.badgeFire,
      ReactionType.clap => g.badgeClap,
      ReactionType.verified => g.badgeVerified,
      ReactionType.wow => g.badgeWow,
    };
  }
}
