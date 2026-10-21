import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/error_handler.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/comman/storage_keys.dart';
import 'package:finskool/src/data/datasource/communities_remote_datasource.dart';
import 'package:finskool/src/data/datasource/demo_subscription_datasource.dart';
import 'package:finskool/src/data/datasource/welcome_kit_demo_datasource.dart';
import 'package:finskool/src/domain/model/community/community_access.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';
import 'package:finskool/src/domain/model/community/compliance_details_model.dart';
import 'package:finskool/src/domain/repository/communities_repository.dart';
import 'package:finskool/src/utilities/logger.dart';
import 'package:finskool/src/utilities/shared_pref_helper.dart';

/// Real-API backed. Everything below this still *throws* and everything
/// above still gets an `Either` (CLAUDE.md's layer rule); `handleErrors`
/// is the single seam.
///
/// `unlockCommunity`, `requestPricing` and the compliance flag stay local —
/// there is still no payment or pricing-enquiry endpoint wired, so a
/// purchase made in-app is replayed over the catalog until the backend
/// reports it through `/auth/mobile/me`.
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
        final unlocked = _unlockedIds();

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
          // A purchase made in-app, before any payment endpoint exists.
          return unlocked.contains(community.id)
              ? _withDemoReceipt(
                  community.copyWith(access: CommunityAccess.subscribed),
                )
              : community;
        }).toList();

        final seen = catalog.map((c) => c.id).toSet();
        return [...merged, ...mine.values.where((c) => !seen.contains(c.id))];
      });

  @override
  Future<Either<Failure, Unit>> unlockCommunity(String communityId) =>
      handleErrors(() async {
        final ids = _unlockedIds()..add(communityId);
        await SharedPreferenceHelper().storedata(
          StorageKeys.unlockedCommunityIds,
          jsonEncode(ids.toList()),
        );
        return unit;
      });

  @override
  Future<Either<Failure, Unit>> requestPricing(String communityId) =>
      handleErrors(() async {
        // No endpoint yet — the real call will notify an admin.
        logger.info('Pricing requested for $communityId');
        return unit;
      });

  @override
  Future<Either<Failure, Unit>> submitCompliance(
    ComplianceDetailsModel details,
  ) => handleErrors(() async {
    // Deliberately storing only the flag, never the PAN.
    await SharedPreferenceHelper().storeBool(
      StorageKeys.complianceCompleted,
      true,
    );
    return unit;
  });

  @override
  bool get isComplianceCompleted =>
      SharedPreferenceHelper().getBool(StorageKeys.complianceCompleted) ??
      false;

  /// Attaches a stand-in purchase receipt so Subscription Detail renders its
  /// Plan and Transaction cards. No endpoint describes a past purchase, so
  /// without this those two sections are simply absent — see
  /// [DemoSubscriptionDatasource], which is temporary.
  CommunityModel _withDemoReceipt(CommunityModel community) {
    final info =
        community.subscriptionInfo ??
        DemoSubscriptionDatasource.forCommunity(community);
    // The Welcome Kit has no endpoint either — see
    // `WelcomeKitDemoDatasource`, which returns null for a community the
    // design doesn't cover rather than showing another one's figures.
    final kit =
        community.welcomeKit ??
        WelcomeKitDemoDatasource.forSlug(community.slug);
    if (info == null && kit == null) return community;
    return community.copyWith(subscriptionInfo: info, welcomeKit: kit);
  }

  Set<String> _unlockedIds() {
    final raw = SharedPreferenceHelper().getdata(
      StorageKeys.unlockedCommunityIds,
    );
    if (raw == null || raw.isEmpty) return <String>{};
    try {
      return (jsonDecode(raw) as List).map((e) => e.toString()).toSet();
    } catch (e) {
      logger.warning('Discarding unreadable unlocked-community list: $e');
      return <String>{};
    }
  }
}
