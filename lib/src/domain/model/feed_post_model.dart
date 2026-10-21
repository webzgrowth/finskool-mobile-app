import 'package:finskool/src/comman/html_spans.dart';

import 'post_media_model.dart';
import 'reaction_type.dart';
import 'reactor_model.dart';

/// One post in the feed — an item of `GET /mobile/posts`.
///
/// [reactionCounts] and [currentUserReaction] come straight off this
/// response — the backend added `reactionCounts`/`myReaction` to the post
/// list, so they are exact and need no second call. [reactors] (*who*
/// reacted, for the Reactions sheet) is the only thing still fetched
/// separately; see `FeedBloc._hydrateOne`.
class FeedPostModel {
  const FeedPostModel({
    required this.id,
    required this.communityId,
    required this.communityName,
    required this.authorName,
    required this.postedAt,
    required this.title,
    required this.body,
    required this.media,
    required this.hashtags,
    this.communityBadgeUrl,
    this.authorAvatarUrl,
    this.pinOrder,
    this.commentCount = 0,
    this.reactionCounts = const {},
    this.reactors = const [],
    this.currentUserReaction,
  });

  final String id;
  final String communityId;
  final String communityName;
  final String? communityBadgeUrl;
  final String authorName;

  /// Nullable in the API, and deliberately not defaulted to `''` — it feeds a
  /// network image, so an empty string would fire a failing request per card.
  final String? authorAvatarUrl;
  final DateTime postedAt;
  final String title;

  /// HTML from the admin's rich-text composer, rendered through `bodySpans`.
  /// The API documents this as Markdown; it isn't, so `bodySpans` sniffs.
  final String body;
  final List<PostMediaModel> media;
  final List<String> hashtags;

  /// 1-3 when pinned. The API already sorts pinned posts first, so this is
  /// only here for a future "Pinned" ribbon.
  final int? pinOrder;

  /// No comments endpoint exists yet — carried so the card can grow a
  /// comment affordance later without a model change.
  final int commentCount;
  final Map<ReactionType, int> reactionCounts;
  final List<ReactorModel> reactors;

  final ReactionType? currentUserReaction;

  bool get isPinned => pinOrder != null;

  /// Distinct reaction types on this post, most-used first — what the
  /// card's badge stack renders. Ties keep [ReactionType] declaration order
  /// so the stack doesn't reshuffle between rebuilds.
  List<ReactionType> get rankedReactions {
    final present = reactionCounts.entries.where((e) => e.value > 0).toList()
      ..sort((a, b) {
        final byCount = b.value.compareTo(a.value);
        return byCount != 0 ? byCount : a.key.index.compareTo(b.key.index);
      });
    return present.map((e) => e.key).toList();
  }

  /// Exact. Both sources of [reactionCounts] — the post list and a write's
  /// response — carry every type with a non-zero count, so the fold is the
  /// true total. It used to need a separate `reactionTotal`, back when counts
  /// were folded out of one page of reactors and undercounted past 50.
  int get totalReactions =>
      reactionCounts.values.fold(0, (sum, count) => sum + count);

  /// Narrow on purpose: only reaction state is ever patched locally, so the
  /// content fields are carried over unconditionally.
  FeedPostModel copyWith({
    Map<ReactionType, int>? reactionCounts,
    List<ReactorModel>? reactors,
    ReactionType? currentUserReaction,
    bool clearCurrentUserReaction = false,
  }) {
    return FeedPostModel(
      id: id,
      communityId: communityId,
      communityName: communityName,
      communityBadgeUrl: communityBadgeUrl,
      authorName: authorName,
      authorAvatarUrl: authorAvatarUrl,
      postedAt: postedAt,
      title: title,
      body: body,
      media: media,
      hashtags: hashtags,
      pinOrder: pinOrder,
      commentCount: commentCount,
      reactionCounts: reactionCounts ?? this.reactionCounts,
      reactors: reactors ?? this.reactors,
      currentUserReaction: clearCurrentUserReaction
          ? null
          : (currentUserReaction ?? this.currentUserReaction),
    );
  }

  factory FeedPostModel.fromJson(Map<String, dynamic> json) => FeedPostModel(
    id: json['id'] as String,
    communityId: json['communityId'] as String? ?? '',
    communityName: json['communityName'] as String? ?? '',
    communityBadgeUrl: json['communityBadgeUrl'] as String?,
    authorName: json['authorName'] as String? ?? '',
    authorAvatarUrl: json['authorAvatarUrl'] as String?,
    // A draft can have no publishedAt; the feed only serves published
    // posts, but fall back rather than throw.
    postedAt: DateTime.parse(
      (json['publishedAt'] ?? json['createdAt']) as String,
    ),
    title: json['title'] as String? ?? '',
    body: json['content'] as String? ?? '',
    media: _media(json),
    hashtags: List<String>.from((json['tags'] as List?) ?? const []),
    pinOrder: json['pinOrder'] as int?,
    commentCount: json['commentCount'] as int? ?? 0,
    reactionCounts: _reactionCounts(json),
    currentUserReaction: ReactionTypeX.fromName(json['myReaction'] as String?),
  );

  /// Media from all three places the backend puts it:
  ///
  /// * `imageUrls` — a flat list of strings, type sniffed from the host;
  /// * pictures the admin composer embedded **inline in the HTML** `content`,
  ///   which is where they land instead of `imageUrls`;
  /// * `videos` — a typed array (`kind`/`embedUrl`/`thumbnailUrl`) that the
  ///   OpenAPI spec doesn't document but the API does send, and which is the
  ///   only one of the three carrying a real poster frame.
  ///
  /// Images come first, then videos, matching the payload's own order. The
  /// two string sources are deduped against each other — a picture listed in
  /// both `imageUrls` and the body must not render twice.
  static List<PostMediaModel> _media(Map<String, dynamic> json) {
    final pictures = <String>{
      ...((json['imageUrls'] as List?) ?? const []).cast<String>(),
      ...htmlImageUrls(json['content'] as String? ?? ''),
    }.map(PostMediaModel.fromUrl);

    final videos = ((json['videos'] as List?) ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(PostMediaModel.fromVideoJson)
        .whereType<PostMediaModel>();

    return [...pictures, ...videos];
  }

  /// The post list now carries complete per-type counts, so these are exact
  /// — unlike the fold over a page of reactors that used to stand in for
  /// them. Zero-count types are omitted, and an unknown name is dropped
  /// rather than being fatal.
  static Map<ReactionType, int> _reactionCounts(Map<String, dynamic> json) {
    final raw = json['reactionCounts'] as Map<String, dynamic>? ?? const {};
    final counts = <ReactionType, int>{};
    for (final entry in raw.entries) {
      final type = ReactionTypeX.fromName(entry.key);
      if (type != null) counts[type] = (entry.value as num).toInt();
    }
    return counts;
  }
}
