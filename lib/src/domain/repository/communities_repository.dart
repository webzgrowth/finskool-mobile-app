import 'package:dartz/dartz.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/community/checkout_session.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';
import 'package:finskool/src/domain/model/community/compliance_details_model.dart';
import 'package:finskool/src/domain/model/community/welcome_kit.dart';

/// The contract the presentation layer depends on. Implemented by
/// `data/repository/communities_repository_impl.dart`.
abstract class CommunitiesRepository {
  /// The full catalog: subscribed and buyable communities alike.
  Future<Either<Failure, List<CommunityModel>>> getCommunities();

  /// Starts a Razorpay checkout for [planId]; the member pays on the web page
  /// in [CheckoutSession.checkoutUrl], not in the app.
  Future<Either<Failure, CheckoutSession>> startCheckout(
    String communityId,
    String planId,
  );

  /// The last day of the member's access to [communityId] per
  /// `GET /auth/mobile/me`, or `Right(null)` if they hold no row for it. How a
  /// purchase is confirmed: the page's `paid` message is only a hint.
  Future<Either<Failure, DateTime?>> subscriptionExpiry(String communityId);

  /// Sends a pricing enquiry to the admin for a `pricingOnRequest`
  /// community. No endpoint yet — succeeds locally.
  Future<Either<Failure, Unit>> requestPricing(String communityId);

  /// Stores the one-time SEBI details. Only the completion flag is kept;
  /// the PAN itself is never persisted.
  Future<Either<Failure, Unit>> submitCompliance(
    ComplianceDetailsModel details,
  );

  /// The community's welcome kit. `Right(null)` means there is nothing to
  /// show (none published, or not entitled) — distinct from a `Left`, which
  /// is a real failure worth a retry.
  Future<Either<Failure, WelcomeKit?>> getWelcomeKit(String communityId);

  /// Whether compliance has already been completed, so the purchase flow
  /// can skip straight past it.
  bool get isComplianceCompleted;
}
