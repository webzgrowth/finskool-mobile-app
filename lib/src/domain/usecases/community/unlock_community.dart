import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/repository/communities_repository.dart';

/// Grants access after a (currently mocked) successful purchase.
@lazySingleton
class UnlockCommunity {
  UnlockCommunity(this._repository);

  final CommunitiesRepository _repository;

  Future<Either<Failure, Unit>> execute(String communityId) =>
      _repository.unlockCommunity(communityId);
}
