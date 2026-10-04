import 'reaction_type.dart';

/// The `data` both `PUT` and `DELETE /mobile/posts/{postId}/reactions`
/// answer with: the post's complete reaction counts plus the caller's own
/// reaction. Authoritative — a write's response replaces the local counts
/// wholesale rather than being merged into them.
///
/// Note the API **omits zero-count types**, which is exactly why it replaces
/// rather than merges: a type missing from [counts] has genuinely gone to
/// zero.
class ReactionSummaryModel {
  const ReactionSummaryModel({required this.counts, this.myReaction});

  final Map<ReactionType, int> counts;
  final ReactionType? myReaction;

  factory ReactionSummaryModel.fromJson(Map<String, dynamic> json) {
    final raw = json['reactionCounts'] as Map<String, dynamic>? ?? const {};
    final counts = <ReactionType, int>{};
    for (final entry in raw.entries) {
      final type = ReactionTypeX.fromName(entry.key);
      // A reaction name this build doesn't know about is dropped, not fatal.
      if (type != null) counts[type] = (entry.value as num).toInt();
    }
    return ReactionSummaryModel(
      counts: counts,
      myReaction: ReactionTypeX.fromName(json['myReaction'] as String?),
    );
  }
}
