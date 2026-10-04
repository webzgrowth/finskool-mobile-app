import 'package:dartz/dartz.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/post_page_model.dart';
import 'package:finskool/src/domain/model/post_reactions_page_model.dart';
import 'package:finskool/src/domain/model/reaction_summary_model.dart';
import 'package:finskool/src/domain/model/reaction_type.dart';

/// The feed and its reactions. The layer boundary: everything below this
/// throws, everything above gets an `Either`.
abstract class PostsRepository {
  /// Omit [communityId] for the free community's feed.
  Future<Either<Failure, PostPageModel>> getPosts({
    int page,
    int pageSize,
    String? communityId,
    String? date,
    String order,
  });

  /// Who reacted to a post. Also the only read that carries reaction counts
  /// at all — `getPosts` returns none.
  Future<Either<Failure, PostReactionsPageModel>> getPostReactions(
    String postId, {
    int page,
    int pageSize,
  });

  Future<Either<Failure, ReactionSummaryModel>> react({
    required String postId,
    required ReactionType reaction,
  });

  Future<Either<Failure, ReactionSummaryModel>> removeReaction(String postId);
}
