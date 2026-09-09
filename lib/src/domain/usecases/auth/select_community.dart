import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/repository/auth_repository.dart';

/// Scopes feed and recommendation calls to one community.
@lazySingleton
class SelectCommunity {
  SelectCommunity(this._repository);

  final AuthRepository _repository;

  Future<Either<Failure, Unit>> execute(String communityId) =>
      _repository.selectCommunity(communityId);
}
