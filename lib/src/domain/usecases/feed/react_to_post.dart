import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/reaction_summary_model.dart';
import 'package:finskool/src/domain/model/reaction_type.dart';
import 'package:finskool/src/domain/repository/posts_repository.dart';

/// Sets — or changes — the caller's reaction. An upsert: there is at most one
/// reaction per person per post.
@lazySingleton
class ReactToPost {
  ReactToPost(this._repository);

  final PostsRepository _repository;

  Future<Either<Failure, ReactionSummaryModel>> execute({
    required String postId,
    required ReactionType reaction,
  }) => _repository.react(postId: postId, reaction: reaction);
}
