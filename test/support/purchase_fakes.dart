import 'package:dartz/dartz.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/community/checkout_session.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';
import 'package:finskool/src/domain/model/community/compliance_details_model.dart';
import 'package:finskool/src/domain/model/community/welcome_kit.dart';
import 'package:finskool/src/domain/repository/communities_repository.dart';

/// Scripted repository: only the two calls a purchase makes do anything.
class FakeCommunitiesRepository implements CommunitiesRepository {
  Either<Failure, CheckoutSession> checkout = const Right(
    CheckoutSession(
      checkoutUrl: 'https://pay.example/checkout#t=secret',
      expiresInSeconds: 120,
    ),
  );

  /// One result per `/me` call, in order; the last repeats.
  List<Either<Failure, DateTime?>> expiries = [const Right(null)];
  int expiryCalls = 0;
  int checkoutCalls = 0;

  @override
  Future<Either<Failure, CheckoutSession>> startCheckout(
    String c,
    String p,
  ) async {
    checkoutCalls++;
    return checkout;
  }

  @override
  Future<Either<Failure, DateTime?>> subscriptionExpiry(String id) async {
    final i = expiryCalls < expiries.length ? expiryCalls : expiries.length - 1;
    expiryCalls++;
    return expiries[i];
  }

  @override
  bool get isComplianceCompleted => false;

  @override
  Future<Either<Failure, List<CommunityModel>>> getCommunities() =>
      throw UnimplementedError();
  @override
  Future<Either<Failure, Unit>> requestPricing(String id) =>
      throw UnimplementedError();
  @override
  Future<Either<Failure, Unit>> submitCompliance(ComplianceDetailsModel d) =>
      throw UnimplementedError();
  @override
  Future<Either<Failure, WelcomeKit?>> getWelcomeKit(String id) =>
      throw UnimplementedError();
}
