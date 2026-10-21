import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/exception.dart';
import 'package:finskool/src/data/api/api.dart';
import 'package:finskool/src/data/api/api_client.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';

/// The Communities tab's two halves.
///
/// It takes two endpoints because neither answers the whole question:
/// `GET /mobile/communities` lists what is **purchasable** and says nothing
/// about membership, while `GET /auth/mobile/me` lists what the user is
/// **in** (with an `expiresAt`) and nothing about price. The catalog also
/// excludes the one free community outright, so a user's free membership
/// only ever appears through `/me`.
///
/// Both endpoints are read-only and ordered server-side (the catalog is
/// alphabetical). Like every datasource these *throw*; catching happens once
/// in the repository, via `handleErrors`.
@lazySingleton
class CommunitiesRemoteDatasource {
  CommunitiesRemoteDatasource(this._client);

  final ApiClient _client;

  /// Every purchasable community, with its plans and "What You Get" list
  /// inlined. Everything comes back `locked` (or `pricingOnRequest` when it
  /// has no plans) — [getMyCommunities] is what promotes the user's own.
  ///
  /// `data` here is a **top-level array**, so this needs `getList`; `get`
  /// would quietly map it to null and lose the whole response.
  Future<List<CommunityModel>> getCatalog() async {
    final rows = await _client.getList(Api.communities);
    if (rows == null) {
      throw ApiException('The server returned no communities.');
    }
    _log('catalog', Api.communities, rows);
    return rows
        .whereType<Map<String, dynamic>>()
        .map(CommunityModel.fromCatalogJson)
        .toList();
  }

  /// The communities the user is actually subscribed to, each carrying the
  /// `expiresAt` that drives "Active till…" / "Expires in N days".
  ///
  /// Returns empty rather than throwing when the payload has no
  /// `communities` key: an account in nothing but the free community is
  /// ordinary, not an error.
  Future<List<CommunityModel>> getMyCommunities() async {
    final data = await _client.get(Api.me);
    final rows = (data?['communities'] as List?) ?? const [];
    _log('membership', Api.me, rows);
    return rows
        .whereType<Map<String, dynamic>>()
        .map(CommunityModel.fromMembershipJson)
        .toList();
  }
}

/// Dumps a community payload as it arrives, one block per row, before
/// anything is parsed — the models only surface fields this build knows
/// about, so an image (or a plan) under an unexpected key would be invisible
/// afterwards. Hence the full JSON and an explicit `keys` line.
///
/// `debugPrint` rather than `logger`, and guarded by `kDebugMode`: same
/// reasoning as `PostsRemoteDatasource._logPosts`.
void _log(String label, String path, List<dynamic> rows) {
  if (!kDebugMode) return;
  _dump(
    '═══ $label ($path): ${rows.length} communit'
    '${rows.length == 1 ? 'y' : 'ies'} ═══',
  );

  var index = 0;
  for (final row in rows.whereType<Map<String, dynamic>>()) {
    index++;
    _dump(
      '─── $label $index/${rows.length} ───\n'
      'keys          : ${row.keys.toList()}\n'
      'coverImageUrl : ${row['coverImageUrl']}\n'
      'badgeUrl      : ${row['badgeUrl']}\n'
      'plans         : ${(row['plans'] as List?)?.length ?? 0}\n'
      '${_pretty(row)}',
    );
  }
}

/// One `debugPrint` per line — handed a whole block it wraps at its own
/// width and the JSON becomes unreadable.
void _dump(String text) {
  for (final line in text.split('\n')) {
    debugPrint(line);
  }
}

String _pretty(Object? value) {
  try {
    return const JsonEncoder.withIndent('  ').convert(value);
  } on JsonUnsupportedObjectError {
    return value.toString();
  }
}
