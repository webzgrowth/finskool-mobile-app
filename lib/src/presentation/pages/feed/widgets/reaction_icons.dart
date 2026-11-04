import 'package:flutter/widgets.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/domain/model/reaction_type.dart';

/// Reaction constants shared by the picker, the Like control, the badge stack
/// and the Reactions sheet.
///
/// Every reaction is drawn as its **emoji** everywhere — Figma's long-press
/// picker is a frame of emoji text nodes (`605:17127`), so emoji are the design
/// — which keeps the picker, the Like control, the badges and the sheet showing
/// the same picture (see [ReactionGlyph]). The one piece of art is
/// [likeButton]: the grey outlined thumbs-up Figma draws on the Like control
/// before the member has reacted.
class ReactionIcons {
  ReactionIcons._();

  /// `thumbs-up-fill_svgrepo.com` — 16x16 inside Figma's 24x24 Like control.
  static const String likeButton = 'assets/icons/reaction_like_fill.svg';

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
