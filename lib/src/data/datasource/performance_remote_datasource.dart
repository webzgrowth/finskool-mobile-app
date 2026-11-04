import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/exception.dart';
import 'package:finskool/src/data/api/api.dart';
import 'package:finskool/src/data/api/api_client.dart';
import 'package:finskool/src/domain/model/performance/performance_board.dart';
import 'package:finskool/src/domain/model/performance/performance_board_entry.dart';
import 'package:finskool/src/domain/model/performance/performance_filter.dart';
import 'package:finskool/src/domain/model/performance/performance_kind.dart';

/// `/mobile/performance/*`. Throws; the repository catches.
@lazySingleton
class PerformanceRemoteDatasource {
  PerformanceRemoteDatasource(this._client);

  final ApiClient _client;

  Future<List<PerformanceBoardEntry>> getBoards() async {
    final data = await _client.get(Api.performanceBoards);
    if (data == null) throw ApiException('The server returned no boards.');
    return [
      for (final row in (data['boards'] as List?) ?? const [])
        if (row is Map<String, dynamic>) ?PerformanceBoardEntry.fromJson(row),
    ];
  }

  /// [segment] is left out for `intraday` and `swing` (it is `main`); leaving
  /// it out on an `investor` board gives `investor`.
  ///
  /// [filter] narrows the summary, the trades and `hiddenCount` together. A
  /// single month is sent as `month=` and a run as `fromMonth` + `toMonth` (the
  /// two forms are interchangeable; never send both, which is a 422). Keep the
  /// same segment and filter on every page of a list.
  Future<PerformanceBoard> getBoard({
    required String communityId,
    PerformanceSegment? segment,
    PerformanceMonthFilter? filter,
    String? cursor,
    int limit = 20,
  }) async {
    final path = Api.performanceBoard(communityId);
    final data = await _client.get(
      path,
      query: {
        if (segment != null && segment != PerformanceSegment.main)
          'segment': segment.wire,
        if (filter != null && filter.isSingleMonth) 'month': filter.from,
        if (filter != null && !filter.isSingleMonth) ...{
          'fromMonth': filter.from,
          'toMonth': filter.to,
        },
        'cursor': ?cursor,
        'limit': limit,
      },
    );
    if (data == null) throw ApiException('The server returned no data.');
    _logLogos(data);
    return PerformanceBoard.fromJson(data);
  }
}

/// Debug only: what the server actually sent for each trade's stock logo, read
/// from the raw JSON before anything is parsed. A row showing initials is
/// either `null` here (the server has no logo for that stock), or a URL that
/// failed to load — this line tells the two apart.
///
/// `debugPrint` guarded by `kDebugMode`, one line per row, like
/// `CommunitiesRemoteDatasource._log`.
void _logLogos(Map<String, dynamic> data) {
  if (!kDebugMode) return;
  final rows = ((data['items'] as List?) ?? const [])
      .whereType<Map<String, dynamic>>()
      .toList();
  final withLogo = rows.where((r) {
    final url = r['logoUrl'];
    return url is String && url.isNotEmpty;
  }).length;
  debugPrint(
    '═══ performance logos (${data['kind']}): '
    '$withLogo of ${rows.length} rows have a logoUrl ═══',
  );
  if (rows.isNotEmpty) {
    debugPrint('row keys: ${rows.first.keys.toList()}');
  }
  for (final r in rows) {
    debugPrint(
      '  ${'${r['name']}'.padRight(28)} '
      'symbol=${r['symbol']}  logoUrl=${r['logoUrl']}',
    );
  }
}
