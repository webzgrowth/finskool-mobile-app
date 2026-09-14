/// The 6 reaction types a feed post can receive.
///
/// These emoji are the design, **not** a placeholder. Figma's long-press
/// picker (the frame is literally named "Picker", `605:17127`) holds six
/// text nodes containing exactly 👍❤️🔥👏✅😮 — the designer used emoji
/// characters too, so there is no custom picker art to export.
///
/// Two reactions additionally have illustrated badge art for the post
/// card's reaction stack; see `pages/feed/widgets/reaction_icons.dart`.
enum ReactionType { like, love, fire, clap, verified, wow }

extension ReactionTypeX on ReactionType {
  String get emoji => switch (this) {
        ReactionType.like => '👍',
        ReactionType.love => '❤️',
        ReactionType.fire => '🔥',
        ReactionType.clap => '👏',
        ReactionType.verified => '✅',
        ReactionType.wow => '😮',
      };

  String get label => switch (this) {
        ReactionType.like => 'Like',
        ReactionType.love => 'Love',
        ReactionType.fire => 'Fire',
        ReactionType.clap => 'Clap',
        ReactionType.verified => 'Verified',
        ReactionType.wow => 'Wow',
      };

  static ReactionType fromName(String name) =>
      ReactionType.values.firstWhere((r) => r.name == name);
}
