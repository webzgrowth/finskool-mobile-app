import 'reaction_type.dart';

/// One person who reacted to a post — a row of
/// `GET /mobile/posts/{postId}/reactions`, shown in the Reactions sheet.
class ReactorModel {
  const ReactorModel({
    required this.id,
    required this.name,
    required this.reaction,
    this.avatarUrl,
  });

  final String id;
  final String name;
  final ReactionType reaction;

  /// Nullable in the API. Deliberately not defaulted to `''` — the avatar
  /// goes straight to a network image, so an empty string would fire a
  /// failing request per row instead of showing initials.
  final String? avatarUrl;

  /// Returns null when the row's `reactionType` is a name this build doesn't
  /// know about — [PostReactionsPageModel] drops those rows rather than
  /// letting one unknown reaction fail the whole fetch.
  static ReactorModel? fromJson(Map<String, dynamic> json) {
    final reaction = ReactionTypeX.fromName(json['reactionType'] as String?);
    if (reaction == null) return null;
    return ReactorModel(
      id: json['userId'] as String,
      name: json['userName'] as String? ?? '',
      avatarUrl: json['userAvatarUrl'] as String?,
      reaction: reaction,
    );
  }
}
