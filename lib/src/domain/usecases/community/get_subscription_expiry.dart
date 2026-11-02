import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/repository/communities_repository.dart';

/// Confirms a purchase: when does the member's access to a community end,
/// according to the server?
@lazySingleton
class GetSubscriptionExpiry {
  GetSubscriptionExpiry(this._repository);

  final CommunitiesRepository _repository;

  Future<Either<Failure, DateTime?>> execute(String communityId) =>
      _repository.subscriptionExpiry(communityId);
}
