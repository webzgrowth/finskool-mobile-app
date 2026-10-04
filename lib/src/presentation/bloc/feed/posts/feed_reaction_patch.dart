import 'package:finskool/src/domain/model/feed_post_model.dart';
import 'package:finskool/src/domain/model/reaction_summary_model.dart';
import 'package:finskool/src/domain/model/reaction_type.dart';
import 'package:finskool/src/domain/model/reactor_model.dart';

/// The pure list transforms behind `FeedBloc`'s reaction handling, kept out
/// of the bloc so that file stays readable — the same move
/// `sign_up_form_validation.dart` makes for multi-field validation.
extension FeedReactionPatch on List<FeedPostModel> {
  FeedPostModel? byId(String postId) {
    for (final post in this) {
      if (post.id == postId) return post;
    }
    return null;
  }

  /// Puts [post] back in place of whatever currently holds its id — the
  /// rollback path after a failed write.
  List<FeedPostModel> replacing(FeedPostModel? post) {
    if (post == null) return this;
    return map((p) => p.id == post.id ? post : p).toList();
  }

  /// Instant local feedback, before the server has confirmed anything:
  /// decrement whatever the user had, increment what they just picked.
  List<FeedPostModel> applyOptimistic(String postId, ReactionType reaction) {
    return map((post) {
      if (post.id != postId) return post;
      final counts = _decremented(post);
      counts[reaction] = (counts[reaction] ?? 0) + 1;
      return post.copyWith(
        reactionCounts: counts,
        currentUserReaction: reaction,
      );
    }).toList();
  }

  List<FeedPostModel> applyOptimisticRemoval(String postId) {
    return map((post) {
      if (post.id != postId || post.currentUserReaction == null) return post;
      return post.copyWith(
        reactionCounts: _decremented(post),
        clearCurrentUserReaction: true,
      );
    }).toList();
  }

  /// Reconciles against a write's response. Counts are replaced wholesale,
  /// not merged — the API omits zero-count types, so a type missing from the
  /// summary has genuinely gone to zero.
  List<FeedPostModel> applySummary(String postId, ReactionSummaryModel s) {
    return map((post) {
      if (post.id != postId) return post;
      return post.copyWith(
        reactionCounts: s.counts,
        currentUserReaction: s.myReaction,
        clearCurrentUserReaction: s.myReaction == null,
      );
    }).toList();
  }

  /// Lands one post's lazily-fetched reactor list.
  ///
  /// Reactors only. Counts and `myReaction` arrive complete on the post list
  /// itself (and on every write's response), so this no longer touches them —
  /// folding them back out of one page of rows would *undo* exact figures and
  /// undercount any post past 50 reactors.
  List<FeedPostModel> applyReactors(
    String postId,
    List<ReactorModel> reactors,
  ) {
    return map((post) {
      if (post.id != postId) return post;
      return post.copyWith(reactors: reactors);
    }).toList();
  }

  Map<ReactionType, int> _decremented(FeedPostModel post) {
    final counts = Map<ReactionType, int>.from(post.reactionCounts);
    final previous = post.currentUserReaction;
    if (previous != null) {
      counts[previous] = (counts[previous] ?? 1) - 1;
      if (counts[previous]! <= 0) counts.remove(previous);
    }
    return counts;
  }
}

extension ReactorLookup on List<ReactorModel> {
  /// The caller's own row, used to recover `myReaction` on a read — the API
  /// only returns it from a write.
  ReactorModel? byUser(String userId) {
    for (final reactor in this) {
      if (reactor.id == userId) return reactor;
    }
    return null;
  }
}
