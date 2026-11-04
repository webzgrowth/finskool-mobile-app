import 'package:flutter/widgets.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/domain/model/reaction_type.dart';

/// The exact reaction art exported from Figma.
///
/// Figma draws the long-press picker's six reactions as plain **emoji text**
/// — the frame is literally named "Picker" (`605:17127`) and each child is a
/// text node holding an emoji character. Emoji are therefore the design
/// here, not a stand-in for missing art.
///
/// Real art exists for like, love and haha only; **insightful (Figma's bulb
/// disc) and celebrate (its clap disc) have no export yet and render as emoji**
/// — swap them in via [svgBadge] once exported. It is different in kind:
/// * [likeButton] is a monochrome UI glyph (one path, `#7D7D91`) — the Like
///   control, and the only asset that can be tinted.
/// * the badge art below is full-colour illustration (gradients, skin tone)
///   used in the post card's reaction stack at ~12px.
class ReactionIcons {
  ReactionIcons._();

  /// `thumbs-up-fill_svgrepo.com` — 16x16 inside Figma's 24x24 Like control.
  static const String likeButton = 'assets/icons/reaction_like_fill.svg';

  static const String _likeBadge = 'assets/icons/reaction_like.svg';
  static const String _hahaBadge = 'assets/icons/reaction_haha.svg';
  static const String _loveBadge = 'assets/icons/reaction_heart.png';

  /// Vector badge art, or null when the reaction only exists as an emoji.
  static String? svgBadge(ReactionType reaction) => switch (reaction) {
    ReactionType.like => _likeBadge,
    ReactionType.haha => _hahaBadge,
    _ => null,
  };

  /// The picker's order: the API's `sortOrder` — 👍 ❤️ 💡 😂 👏. Only types the
  /// server actually returns are shown (see [available]).
  static const List<ReactionType> pickerOrder = [
    ReactionType.like,
    ReactionType.love,
    ReactionType.insightful,
    ReactionType.haha,
    ReactionType.celebrate,
  ];

  /// [pickerOrder] limited to [offered] (the names `GET /mobile/reaction-types`
  /// returned). With nothing known yet — the first tap before the catalog has
  /// answered — the whole default list is offered.
  static List<ReactionType> available(Set<ReactionType>? offered) =>
      offered == null || offered.isEmpty
      ? pickerOrder
      : pickerOrder.where(offered.contains).toList();

  /// The Reactions sheet's tab order — the same as the picker's: blue, red,
  /// yellow, teal, green.
  static const List<ReactionType> sheetOrder = pickerOrder;

  /// Raster badge art (the heart was uploaded as an image, not a vector).
  static String? pngBadge(ReactionType reaction) =>
      reaction == ReactionType.love ? _loveBadge : null;

  /// The coloured disc behind a reaction in the post card's badge stack.
  ///
  /// Figma's colourful feed variant (`605:15302`) draws blue thumbs-up
  /// (`#388FE7`), red heart (`#F15759`), amber bulb (`#FFDA56`), teal laughing
  /// face (`#108B8B`) and green clap (`#6DAE53`) — exactly the backend's five,
  /// so every disc is Figma's own.
  static Color badgeColor(BuildContext context, ReactionType reaction) {
    final g = context.gradients;
    return switch (reaction) {
      ReactionType.like => g.badgeLike,
      ReactionType.love => g.badgeLove,
      ReactionType.insightful => g.badgeInsightful,
      ReactionType.haha => g.badgeHaha,
      ReactionType.celebrate => g.badgeCelebrate,
    };
  }
}
