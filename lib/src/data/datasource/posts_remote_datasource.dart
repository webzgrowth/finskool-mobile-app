import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/exception.dart';
import 'package:finskool/src/comman/html_spans.dart';
import 'package:finskool/src/data/api/api.dart';
import 'package:finskool/src/data/api/api_client.dart';
import 'package:finskool/src/data/datasource/reaction_type_catalog.dart';
import 'package:finskool/src/domain/model/post_page_model.dart';
import 'package:finskool/src/domain/model/post_reactions_page_model.dart';
import 'package:finskool/src/domain/model/reaction_summary_model.dart';
import 'package:finskool/src/domain/model/reaction_type.dart';

/// The feed and its reactions. Like the other datasources these *throw*;
/// catching happens once, in the repository, via `handleErrors`.
@lazySingleton
class PostsRemoteDatasource {
  PostsRemoteDatasource(this._client, this._reactionTypes);

  final ApiClient _client;
  final ReactionTypeCatalog _reactionTypes;

  /// The feed is always scoped to exactly one community. Omitting
  /// [communityId] asks for the one free community, which every account is
  /// subscribed to at registration — so it always answers.
  Future<PostPageModel> getPosts({
    int page = 1,
    int pageSize = 20,
    String? communityId,
    String? date,
    String order = 'desc',
  }) async {
    final data = await _client.get(Api.posts, query: {
      'page': page,
      'pageSize': pageSize,
      'order': order,
      // Omitted entirely rather than sent as null/'' — an empty communityId
      // is a 422, not "the free community".
      'communityId': ?communityId,
      'date': ?date,
    });
    final payload = _require(data, Api.posts);
    _logPosts(payload);
    return PostPageModel.fromJson(payload);
  }

  /// Dumps the raw feed payload, one block per post, before anything is
  /// parsed — [PostPageModel] can only show you fields this build already
  /// knows about, so a picture (or anything else) arriving under an
  /// unexpected key would be invisible by then. Hence the full JSON **and**
  /// an explicit `keys` line.
  ///
  /// `debugPrint` rather than [logger]: it prints whatever the app's log
  /// level happens to be, and it throttles instead of truncating. `kDebugMode`
  /// keeps all of it out of release builds.
  void _logPosts(Map<String, dynamic> payload) {
    if (!kDebugMode) return;
    final posts = (payload['posts'] as List?) ?? const [];
    _dump('═══ feed: ${posts.length} post(s) on page ${payload['page']}'
        '/${payload['totalPages']}, ${payload['total']} total ═══');

    var index = 0;
    for (final row in posts.whereType<Map<String, dynamic>>()) {
      index++;
      final content = row['content'] as String? ?? '';
      _dump('─── post $index/${posts.length} ───\n'
          'keys       : ${row.keys.toList()}\n'
          'imageUrls  : ${row['imageUrls']}\n'
          'inline img : ${htmlImageUrls(content)}\n'
          '${_pretty(row)}');
    }
  }

  /// One `debugPrint` per line. Handed a whole block it would wrap at its own
  /// width and make the JSON unreadable.
  void _dump(String text) {
    for (final line in text.split('\n')) {
      debugPrint(line);
    }
  }

  String _pretty(Object? value) {
    try {
      return const JsonEncoder.withIndent('  ').convert(value);
    } on JsonUnsupportedObjectError {
      // Never let a diagnostic take the feed down.
      return value.toString();
    }
  }

  Future<PostReactionsPageModel> getPostReactions(
    String postId, {
    int page = 1,
    int pageSize = 50,
  }) async {
    final path = Api.postReactions(postId);
    final data = await _client.get(path, query: {
      'page': page,
      'pageSize': pageSize,
    });
    return PostReactionsPageModel.fromJson(_require(data, path));
  }

  /// An upsert — a caller has at most one reaction per post, so re-reacting
  /// with a different type replaces it rather than adding a second.
  Future<ReactionSummaryModel> react({
    required String postId,
    required ReactionType reaction,
  }) async {
    final id = await _reactionTypes.idFor(reaction);
    final path = Api.postReactions(postId);
    final data = await _client.put(path, body: {'reactionTypeId': id});
    return ReactionSummaryModel.fromJson(_require(data, path));
  }

  /// Safe to call when the caller has no reaction on this post — the API
  /// treats that as a no-op rather than a 404.
  Future<ReactionSummaryModel> removeReaction(String postId) async {
    final path = Api.postReactions(postId);
    final data = await _client.delete(path);
    return ReactionSummaryModel.fromJson(_require(data, path));
  }

  Map<String, dynamic> _require(Map<String, dynamic>? data, String path) {
    if (data == null) {
      throw ApiException('The server returned no data for $path.');
    }
    return data;
  }
}
