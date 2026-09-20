import 'package:dartz/dartz.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';
import 'package:finskool/src/domain/model/community/compliance_details_model.dart';

/// The contract the presentation layer depends on. Implemented by
/// `data/repository/communities_repository_impl.dart`, which is currently
/// backed by a mock datasource — there is no community API yet.
abstract class CommunitiesRepository {
  /// The full catalog: subscribed and buyable communities alike.
  Future<Either<Failure, List<CommunityModel>>> getCommunities();

  /// Marks a community as subscribed after a (mocked) purchase.
  Future<Either<Failure, Unit>> unlockCommunity(String communityId);

  /// Sends a pricing enquiry to the admin for a `pricingOnRequest`
  /// community. No endpoint yet — succeeds locally.
  Future<Either<Failure, Unit>> requestPricing(String communityId);

  /// Stores the one-time SEBI details. Only the completion flag is kept;
  /// the PAN itself is never persisted.
  Future<Either<Failure, Unit>> submitCompliance(
      ComplianceDetailsModel details);

  /// Whether compliance has already been completed, so the purchase flow
  /// can skip straight past it.
  bool get isComplianceCompleted;
}
