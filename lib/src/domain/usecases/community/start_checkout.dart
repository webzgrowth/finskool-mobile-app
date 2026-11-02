import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/community/checkout_session.dart';
import 'package:finskool/src/domain/repository/communities_repository.dart';

/// Begins buying a plan: asks the backend for a checkout page to open.
@lazySingleton
class StartCheckout {
  StartCheckout(this._repository);

  final CommunitiesRepository _repository;

  Future<Either<Failure, CheckoutSession>> execute(
    String communityId,
    String planId,
  ) => _repository.startCheckout(communityId, planId);
}
