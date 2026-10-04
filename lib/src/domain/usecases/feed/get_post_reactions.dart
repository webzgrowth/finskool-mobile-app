import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/post_reactions_page_model.dart';
import 'package:finskool/src/domain/repository/posts_repository.dart';

/// Who reacted to one post. `GET /mobile/posts` carries no reaction data, so
/// this is also how the card's badge stack gets its counts.
@lazySingleton
class GetPostReactions {
  GetPostReactions(this._repository);

  final PostsRepository _repository;

  Future<Either<Failure, PostReactionsPageModel>> execute(
    String postId, {
    int page = 1,
    int pageSize = 50,
  }) =>
      _repository.getPostReactions(postId, page: page, pageSize: pageSize);
}
