import 'post_media_model.dart';
import 'reaction_type.dart';
import 'reactor_model.dart';

class FeedPostModel {
  const FeedPostModel({
    required this.id,
    required this.authorName,
    required this.authorAvatarUrl,
    required this.postedAt,
    required this.title,
    required this.body,
    required this.media,
    required this.hashtags,
    required this.reactionCounts,
    required this.reactors,
    this.currentUserReaction,
  });

  final String id;
  final String authorName;
  final String authorAvatarUrl;
  final DateTime postedAt;
  final String title;
  final String body;
  final List<PostMediaModel> media;
  final List<String> hashtags;
  final Map<ReactionType, int> reactionCounts;
  final List<ReactorModel> reactors;
  final ReactionType? currentUserReaction;

  int get totalReactions =>
      reactionCounts.values.fold(0, (sum, count) => sum + count);

  FeedPostModel copyWith({
    Map<ReactionType, int>? reactionCounts,
    List<ReactorModel>? reactors,
    ReactionType? currentUserReaction,
    bool clearCurrentUserReaction = false,
  }) {
    return FeedPostModel(
      id: id,
      authorName: authorName,
      authorAvatarUrl: authorAvatarUrl,
      postedAt: postedAt,
      title: title,
      body: body,
      media: media,
      hashtags: hashtags,
      reactionCounts: reactionCounts ?? this.reactionCounts,
      reactors: reactors ?? this.reactors,
      currentUserReaction: clearCurrentUserReaction
          ? null
          : (currentUserReaction ?? this.currentUserReaction),
    );
  }

  factory FeedPostModel.fromJson(Map<String, dynamic> json) => FeedPostModel(
        id: json['id'] as String,
        authorName: json['authorName'] as String,
        authorAvatarUrl: json['authorAvatarUrl'] as String,
        postedAt: DateTime.parse(json['postedAt'] as String),
        title: json['title'] as String,
        body: json['body'] as String,
        media: (json['media'] as List)
            .map((m) => PostMediaModel.fromJson(m as Map<String, dynamic>))
            .toList(),
        hashtags: List<String>.from(json['hashtags'] as List),
        reactionCounts: (json['reactionCounts'] as Map<String, dynamic>).map(
          (key, value) =>
              MapEntry(ReactionTypeX.fromName(key), value as int),
        ),
        reactors: (json['reactors'] as List)
            .map((r) => ReactorModel.fromJson(r as Map<String, dynamic>))
            .toList(),
        currentUserReaction: json['currentUserReaction'] == null
            ? null
            : ReactionTypeX.fromName(json['currentUserReaction'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'authorName': authorName,
        'authorAvatarUrl': authorAvatarUrl,
        'postedAt': postedAt.toIso8601String(),
        'title': title,
        'body': body,
        'media': media.map((m) => m.toJson()).toList(),
        'hashtags': hashtags,
        'reactionCounts':
            reactionCounts.map((key, value) => MapEntry(key.name, value)),
        'reactors': reactors.map((r) => r.toJson()).toList(),
        'currentUserReaction': currentUserReaction?.name,
      };
}
