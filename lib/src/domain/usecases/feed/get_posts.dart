import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/post_page_model.dart';
import 'package:finskool/src/domain/repository/posts_repository.dart';

/// One page of the feed. [communityId] omitted means the free community.
///
/// `date` and `order` are plumbed because the endpoint takes them, but no UI
/// drives either yet — the feed's filter chips are still client-side.
@lazySingleton
class GetPosts {
  GetPosts(this._repository);

  final PostsRepository _repository;

  Future<Either<Failure, PostPageModel>> execute({
    int page = 1,
    int pageSize = 20,
    String? communityId,
    String? date,
    String order = 'desc',
  }) =>
      _repository.getPosts(
        page: page,
        pageSize: pageSize,
        communityId: communityId,
        date: date,
        order: order,
      );
}
