/// The 6 reaction types a feed post can receive.
///
/// Rendered as native emoji glyphs rather than custom icon art — Figma
/// access is unavailable, so this is a stand-in; swap for real assets in
/// [ReactionTypeX.emoji] if exported icons become available later.
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
