import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/community/welcome_kit.dart';
import 'package:finskool/src/domain/repository/communities_repository.dart';

/// A community's welcome kit. `Right(null)` is "nothing to show", not an error.
@lazySingleton
class GetWelcomeKit {
  GetWelcomeKit(this._repository);

  final CommunitiesRepository _repository;

  Future<Either<Failure, WelcomeKit?>> execute(String communityId) =>
      _repository.getWelcomeKit(communityId);
}
