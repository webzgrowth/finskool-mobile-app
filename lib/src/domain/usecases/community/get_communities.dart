import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';
import 'package:finskool/src/domain/repository/communities_repository.dart';

/// The browsable catalog — subscribed and buyable communities alike.
@lazySingleton
class GetCommunities {
  GetCommunities(this._repository);

  final CommunitiesRepository _repository;

  Future<Either<Failure, List<CommunityModel>>> execute() =>
      _repository.getCommunities();
}
