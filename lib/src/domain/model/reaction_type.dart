/// The reaction types this app offers: like, love, haha, wow, angry.
///
/// The backend seeds a sixth, `sad` — it is deliberately **not** listed here.
/// The product call is that a sad face doesn't belong on this feed, and since
/// [fromName] is nullable, a `sad` row arriving from the API drops out of the
/// counts and the reactor list on its own rather than throwing.
///
/// Declaration order follows the API's `sortOrder`, because it drives both
/// the long-press picker's row order and the badge stack's tie-break in
/// `FeedPostModel.rankedReactions`.
///
/// These emoji are the design, **not** a placeholder. Figma's picker frame
/// (`605:17127`) holds text nodes of emoji characters, so the designer used
/// emoji too and there is no picker art to export. Note Figma designed a
/// different set (👍❤️🔥👏✅😮); the backend's is authoritative, so fire,
/// clap and verified are gone.
///
/// Two reactions additionally have illustrated badge art for the post card's
/// reaction stack; see `pages/feed/widgets/reaction_icons.dart`.
enum ReactionType { like, love, haha, wow, angry }

extension ReactionTypeX on ReactionType {
  String get emoji => switch (this) {
        ReactionType.like => '👍',
        ReactionType.love => '❤️',
        ReactionType.haha => '😂',
        ReactionType.wow => '😮',
        ReactionType.angry => '😡',
      };

  String get label => switch (this) {
        ReactionType.like => 'Like',
        ReactionType.love => 'Love',
        ReactionType.haha => 'Haha',
        ReactionType.wow => 'Wow',
        ReactionType.angry => 'Angry',
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
