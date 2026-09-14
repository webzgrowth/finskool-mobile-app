import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/error_handler.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/comman/storage_keys.dart';
import 'package:finskool/src/data/datasource/communities_mock_datasource.dart';
import 'package:finskool/src/domain/model/community/community_access.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';
import 'package:finskool/src/domain/model/community/compliance_details_model.dart';
import 'package:finskool/src/domain/repository/communities_repository.dart';
import 'package:finskool/src/utilities/logger.dart';
import 'package:finskool/src/utilities/shared_pref_helper.dart';

/// Mock-backed for now. Everything below the repository still *throws* and
/// everything above still gets an `Either` (CLAUDE.md's layer rule), so
/// swapping `CommunitiesMockDatasource` for a real remote datasource is a
/// one-line change here.
@LazySingleton(as: CommunitiesRepository)
class CommunitiesRepositoryImpl implements CommunitiesRepository {
  @override
  Future<Either<Failure, List<CommunityModel>>> getCommunities() =>
      handleErrors(() async {
        final unlocked = _unlockedIds();
        // Purchases made in-app are local-only until a backend exists, so
        // replay them over the catalog on every load.
        return CommunitiesMockDatasource.getCommunities()
            .map((c) => unlocked.contains(c.id)
                ? c.copyWith(access: CommunityAccess.subscribed)
                : c)
            .toList();
      });

  @override
  Future<Either<Failure, Unit>> unlockCommunity(String communityId) =>
      handleErrors(() async {
        final ids = _unlockedIds()..add(communityId);
        await SharedPreferenceHelper()
            .storedata(StorageKeys.unlockedCommunityIds, jsonEncode(ids.toList()));
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
          ComplianceDetailsModel details) =>
      handleErrors(() async {
        // Deliberately storing only the flag, never the PAN.
        await SharedPreferenceHelper()
            .storeBool(StorageKeys.complianceCompleted, true);
        return unit;
      });

  @override
  bool get isComplianceCompleted =>
      SharedPreferenceHelper().getBool(StorageKeys.complianceCompleted) ?? false;

  Set<String> _unlockedIds() {
    final raw =
        SharedPreferenceHelper().getdata(StorageKeys.unlockedCommunityIds);
    if (raw == null || raw.isEmpty) return <String>{};
    try {
      return (jsonDecode(raw) as List).map((e) => e.toString()).toSet();
    } catch (e) {
      logger.warning('Discarding unreadable unlocked-community list: $e');
      return <String>{};
    }
  }
}
