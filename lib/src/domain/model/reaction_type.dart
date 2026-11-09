/// The reaction types the backend offers (`mobile-post-reactions.md`):
/// like, love, insightful, haha, celebrate — in that order.
///
/// Declaration order is the API's `sortOrder`, because it drives both the
/// long-press picker's row order and the badge stack's tie-break in
/// `FeedPostModel.rankedReactions`. The set is the backend's, which replaced
/// wow / sad / angry with insightful (id 7) and celebrate (id 8).
///
/// **The app draws them as 🔥 and 🚀**, not the 💡 and 👏 the backend's names
/// suggest: the design asked for fire and rocket and the backend has no such
/// types yet, so `insightful` is shown as 🔥 and `celebrate` as 🚀. Only
/// [ReactionTypeX.emoji] and [ReactionTypeX.label] change; the wire names stay,
/// so reacting, counts and the reactor list are unaffected. When the backend
/// adds real `fire` / `rocket` types, rename the enum values and drop this
/// note. The integer `reactionTypeId` is never
/// hardcoded — `ReactionTypeCatalog` resolves it from
/// `GET /mobile/reaction-types`.
///
/// [fromName] is nullable, so a name this build doesn't know (a type added
/// later, or an old `wow` still in a cache) drops that one datum from the
/// counts and the reactor list instead of throwing. The API also sends an
/// `emoji` for every type, which could draw an unknown one — not done: the
/// enum is closed.
///
/// These emoji are the design, **not** a placeholder: Figma's picker frame
/// (`605:17127`) holds text nodes of emoji characters. Illustrated art exists
/// only for the badge stack, and only for some types — see
/// `pages/feed/widgets/reaction_icons.dart`.
enum ReactionType { like, love, insightful, haha, celebrate }

extension ReactionTypeX on ReactionType {
  String get emoji => switch (this) {
    ReactionType.like => '👍',
    ReactionType.love => '❤️',
    ReactionType.insightful => '🔥',
    ReactionType.haha => '😂',
    ReactionType.celebrate => '🚀',
  };

  String get label => switch (this) {
    ReactionType.like => 'Like',
    ReactionType.love => 'Love',
    ReactionType.insightful => 'Fire',
    ReactionType.haha => 'Haha',
    ReactionType.celebrate => 'Rocket',
  };

  /// Nullable on purpose. Every reaction name in the app now arrives from the
  /// API, so a name this build doesn't know about must leave that one datum
  /// out — not throw and take the whole feed down with it. Callers skip the
  /// row or the count key.
  static ReactionType? fromName(String? name) {
    for (final reaction in ReactionType.values) {
      if (reaction.name == name) return reaction;
    }
    return null;
  }
}
