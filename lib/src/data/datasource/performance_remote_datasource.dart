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
    return PerformanceBoard.fromJson(data);
  }
}
