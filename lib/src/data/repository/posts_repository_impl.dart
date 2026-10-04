import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/error_handler.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/data/datasource/posts_remote_datasource.dart';
import 'package:finskool/src/domain/model/post_page_model.dart';
import 'package:finskool/src/domain/model/post_reactions_page_model.dart';
import 'package:finskool/src/domain/model/reaction_summary_model.dart';
import 'package:finskool/src/domain/model/reaction_type.dart';
import 'package:finskool/src/domain/repository/posts_repository.dart';

@LazySingleton(as: PostsRepository)
class PostsRepositoryImpl implements PostsRepository {
  PostsRepositoryImpl(this._remote);

  final PostsRemoteDatasource _remote;

  @override
  Future<Either<Failure, PostPageModel>> getPosts({
    int page = 1,
    int pageSize = 20,
    String? communityId,
    String? date,
    String order = 'desc',
  }) =>
      handleErrors(() => _remote.getPosts(
            page: page,
            pageSize: pageSize,
            communityId: communityId,
            date: date,
            order: order,
          ));

  @override
  Future<Either<Failure, PostReactionsPageModel>> getPostReactions(
    String postId, {
    int page = 1,
    int pageSize = 50,
  }) =>
      handleErrors(
          () => _remote.getPostReactions(postId, page: page, pageSize: pageSize));

  @override
  Future<Either<Failure, ReactionSummaryModel>> react({
    required String postId,
    required ReactionType reaction,
  }) =>
      handleErrors(() => _remote.react(postId: postId, reaction: reaction));

  @override
  Future<Either<Failure, ReactionSummaryModel>> removeReaction(String postId) =>
      handleErrors(() => _remote.removeReaction(postId));
}
