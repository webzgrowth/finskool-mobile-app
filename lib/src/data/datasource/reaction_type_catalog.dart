import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/exception.dart';
import 'package:finskool/src/data/api/api.dart';
import 'package:finskool/src/data/api/api_client.dart';
import 'package:finskool/src/domain/model/reaction_type.dart';
import 'package:finskool/src/domain/model/reaction_type_model.dart';

/// Resolves a [ReactionType] to the integer `reactionTypeId` that
/// `PUT /mobile/posts/{postId}/reactions` wants.
///
/// The ids are never hardcoded: nothing in the contract pins a name to a
/// particular integer, so they come from `GET /mobile/reaction-types`. That
/// set is fixed and seeded, so it is fetched once and kept.
///
/// The **in-flight future** is memoised, not just its result — a long-press
/// that fires several reacts, or two cards reacted at once, must not each
/// start their own request.
@lazySingleton
class ReactionTypeCatalog {
  ReactionTypeCatalog(this._client);

  final ApiClient _client;
  Future<List<ReactionTypeModel>>? _pending;

  Future<List<ReactionTypeModel>> all() => _pending ??= _fetch();

  Future<int> idFor(ReactionType reaction) async {
    final types = await all();
    for (final type in types) {
      if (type.type == reaction) return type.id;
    }
    throw ApiException("That reaction isn't available.");
  }

  Future<List<ReactionTypeModel>> _fetch() async {
    try {
      // This endpoint's `data` is a top-level array, not an object.
      final rows = await _client.getList(Api.reactionTypes);
      if (rows == null) {
        throw ApiException('The server returned no reaction types.');
      }
      return rows
          .map((r) => ReactionTypeModel.fromJson(r as Map<String, dynamic>))
          .toList()
        ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    } catch (_) {
      // Don't cache a failure — the next react should retry rather than be
      // permanently broken by one flaky call.
      _pending = null;
      rethrow;
    }
  }
}
