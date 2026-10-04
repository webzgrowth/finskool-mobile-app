import 'reaction_type.dart';

/// One row of `GET /mobile/reaction-types` — the fixed, seeded set.
///
/// [id] is what `PUT /mobile/posts/{postId}/reactions` wants as its
/// `reactionTypeId`. It is resolved at runtime rather than hardcoded, since
/// nothing in the contract pins a name to a particular integer.
class ReactionTypeModel {
  const ReactionTypeModel({
    required this.id,
    required this.name,
    required this.emoji,
    required this.sortOrder,
  });

  final int id;
  final String name;
  final String emoji;
  final int sortOrder;

  /// Null when the backend seeds a reaction this build doesn't know about.
  /// The catalog filters those out rather than failing the whole fetch.
  ReactionType? get type => ReactionTypeX.fromName(name);

  factory ReactionTypeModel.fromJson(Map<String, dynamic> json) =>
      ReactionTypeModel(
        id: json['id'] as int,
        name: json['name'] as String,
        emoji: json['emoji'] as String? ?? '',
        sortOrder: json['sortOrder'] as int? ?? 0,
      );
}
