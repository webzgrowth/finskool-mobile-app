import 'reaction_type.dart';
import 'reactor_model.dart';

/// One page of `GET /mobile/posts/{postId}/reactions` — who reacted, and
/// with what, newest first.
class PostReactionsPageModel {
  const PostReactionsPageModel({
    required this.reactors,
    required this.total,
    required this.page,
    required this.pageSize,
    required this.totalPages,
  });

  final List<ReactorModel> reactors;

  /// Every reaction on the post, not just this page's rows. The only exact
  /// total available on a read.
  final int total;
  final int page;
  final int pageSize;
  final int totalPages;

  /// Per-type counts folded out of the rows.
  ///
  /// The API has no per-type aggregate, so for a post with more reactors than
  /// one page holds these counts cover only the rows fetched — [total] stays
  /// exact. The fix is a `reactionCounts` field on the endpoint, not more
  /// client-side paging.
  Map<ReactionType, int> get counts {
    final counts = <ReactionType, int>{};
    for (final reactor in reactors) {
      counts[reactor.reaction] = (counts[reactor.reaction] ?? 0) + 1;
    }
    return counts;
  }

  factory PostReactionsPageModel.fromJson(Map<String, dynamic> json) {
    final rows = json['reactions'] as List? ?? const [];
    return PostReactionsPageModel(
      reactors: rows
          .map((r) => ReactorModel.fromJson(r as Map<String, dynamic>))
          .whereType<ReactorModel>()
          .toList(),
      total: json['total'] as int? ?? rows.length,
      page: json['page'] as int? ?? 1,
      pageSize: json['pageSize'] as int? ?? rows.length,
      totalPages: json['totalPages'] as int? ?? 1,
    );
  }
}
