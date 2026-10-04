import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/reaction_summary_model.dart';
import 'package:finskool/src/domain/repository/posts_repository.dart';

/// Clears the caller's reaction. A no-op server-side when there isn't one.
@lazySingleton
class RemoveReaction {
  RemoveReaction(this._repository);

  final PostsRepository _repository;

  Future<Either<Failure, ReactionSummaryModel>> execute(String postId) =>
      _repository.removeReaction(postId);
}
