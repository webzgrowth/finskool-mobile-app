part of 'performance_bloc.dart';

@freezed
class PerformanceEvent with _$PerformanceEvent {
  /// First load of a board, or a retry. [segment] null = the board's default.
  const factory PerformanceEvent.load({
    required String communityId,
    PerformanceSegment? segment,
  }) = _Load;

  /// Investor tabs. Replaces everything on screen — summary, trades and the
  /// hidden count are all per segment — and clears the month.
  const factory PerformanceEvent.segmentChanged(PerformanceSegment segment) =
      _SegmentChanged;

  /// The months to narrow to (a single month is `from == to`), or null for
  /// every month. A new request that replaces the whole screen — the summary,
  /// the trades and the hidden count all follow the filter.
  const factory PerformanceEvent.filterChanged(PerformanceMonthFilter? filter) =
      _FilterChanged;

  const factory PerformanceEvent.loadMore() = _LoadMore;
}
