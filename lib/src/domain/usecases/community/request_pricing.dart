import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/repository/communities_repository.dart';

/// Asks an admin to quote a community whose price isn't public.
@lazySingleton
class RequestPricing {
  RequestPricing(this._repository);

  final CommunitiesRepository _repository;

  Future<Either<Failure, Unit>> execute(String communityId) =>
      _repository.requestPricing(communityId);
}
