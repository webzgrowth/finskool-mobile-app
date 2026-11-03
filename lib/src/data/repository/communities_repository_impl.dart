import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/error_handler.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/data/datasource/communities_remote_datasource.dart';
import 'package:finskool/src/data/datasource/demo_subscription_datasource.dart';
import 'package:finskool/src/domain/model/community/community_access.dart';
import 'package:finskool/src/domain/model/community/checkout_session.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';
import 'package:finskool/src/domain/model/community/welcome_kit.dart';
import 'package:finskool/src/domain/repository/communities_repository.dart';
import 'package:finskool/src/utilities/logger.dart';

/// Real-API backed. Everything below this still *throws* and everything
/// above still gets an `Either` (CLAUDE.md's layer rule); `handleErrors`
/// is the single seam.
///
/// `requestPricing` stays local — there is no pricing-enquiry endpoint wired. Purchases are real: payment happens
/// on the web checkout and the backend reports it through `/auth/mobile/me`.
@LazySingleton(as: CommunitiesRepository)
class CommunitiesRepositoryImpl implements CommunitiesRepository {
  CommunitiesRepositoryImpl(this._remote);

  final CommunitiesRemoteDatasource _remote;

  /// The catalog and the user's memberships, merged.
  ///
  /// The two endpoints overlap but neither is complete: the catalog has
  /// plans, benefits, category and member count but no membership; `/me` has
  /// membership and `expiresAt` but none of the rest. So a community in both
  /// keeps its catalog detail and *gains* subscribed access plus its expiry,
  /// and a community only in `/me` — the free one, which the catalog
  /// excludes by design — is appended as-is so the user still sees what
  /// they're in.
  ///
  /// The two calls go out together: they're independent, and serialising
  /// them would double the tab's time to first paint.
  @override
  Future<Either<Failure, List<CommunityModel>>> getCommunities() =>
      handleErrors(() async {
        final results = await Future.wait([
          _remote.getCatalog(),
          _remote.getMyCommunities(),
        ]);
        final catalog = results[0];
        final mine = {for (final c in results[1]) c.id: c};

        final merged = catalog.map((community) {
          final subscription = mine[community.id];
          if (subscription != null) {
            return _withDemoReceipt(
              community.copyWith(
                access: CommunityAccess.subscribed,
                subscribedUntil: subscription.subscribedUntil,
              ),
            );
          }
          return community;
        }).toList();

        final seen = catalog.map((c) => c.id).toSet();
        return [...merged, ...mine.values.where((c) => !seen.contains(c.id))];
      });

  @override
  Future<Either<Failure, WelcomeKit?>> getWelcomeKit(String communityId) =>
      handleErrors(() => _remote.getWelcomeKit(communityId));

  @override
  Future<Either<Failure, CheckoutSession>> startCheckout(
    String communityId,
    String planId,
  ) => handleErrors(() => _remote.createCheckoutSession(communityId, planId));

  @override
  Future<Either<Failure, DateTime?>> subscriptionExpiry(String communityId) =>
      handleErrors(() async {
        final mine = await _remote.getMyCommunities();
        for (final c in mine) {
          if (c.id == communityId) return c.subscribedUntil;
        }
        return null;
      });

  @override
  Future<Either<Failure, Unit>> requestPricing(String communityId) =>
      handleErrors(() async {
        // No endpoint yet — the real call will notify an admin.
        logger.info('Pricing requested for $communityId');
        return unit;
      });

  /// Attaches a stand-in purchase receipt so Subscription Detail renders its
  /// Plan and Transaction cards. No endpoint describes a past purchase, so
  /// without this those two sections are simply absent — see
  /// [DemoSubscriptionDatasource], which is temporary.
  CommunityModel _withDemoReceipt(CommunityModel community) {
    final info =
        community.subscriptionInfo ??
        DemoSubscriptionDatasource.forCommunity(community);
    if (info == null) return community;
    return community.copyWith(subscriptionInfo: info);
  }
}
