import 'reaction_type.dart';

/// One person who reacted to a post — shown in the Reactions bottom sheet.
class ReactorModel {
  const ReactorModel({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.reaction,
  });

  final String id;
  final String name;
  final String avatarUrl;
  final ReactionType reaction;

  factory ReactorModel.fromJson(Map<String, dynamic> json) => ReactorModel(
        id: json['id'] as String,
        name: json['name'] as String,
        avatarUrl: json['avatarUrl'] as String,
        reaction: ReactionTypeX.fromName(json['reaction'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'avatarUrl': avatarUrl,
        'reaction': reaction.name,
      };
}
