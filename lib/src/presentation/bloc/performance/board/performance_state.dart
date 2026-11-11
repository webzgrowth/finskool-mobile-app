part of 'performance_bloc.dart';

@freezed
sealed class PerformanceState with _$PerformanceState {
  const factory PerformanceState({
    @Default(RequestState.empty) RequestState state,

    /// A snackbar's worth: a failed month change or "load more". Reset to ''
    /// at the start of each action so the same text can be raised twice.
    @Default('') String message,

    /// The server's code for a failed first load — `PERFORMANCE_BOARD_NOT_FOUND`
    /// means "nothing to show", not "try again".
    String? errorCode,
    @Default('') String communityId,

    /// The **first page of the current query** (segment + filter): where the
    /// summary, banner, hidden count, access flag and the month list come from.
    /// Replaced by every filter change, so the cards always match the list.
    PerformanceBoard? board,
    @Default(<PerformanceTrade>[]) List<PerformanceTrade> items,
    String? nextCursor,
    PerformanceSegment? segment,

    /// The months asked for, or null for every month.
    PerformanceMonthFilter? filter,

    /// A filter change is reloading the screen. The old cards stay (dimmed)
    /// until the answer replaces them.
    @Default(false) bool isListLoading,
    @Default(false) bool isLoadingMore,

    /// A tab was tapped and its board is on the way. The tab row stays (the
    /// selected tab already moved) and only what is **below** it is a
    /// skeleton — the whole screen is not rebuilt.
    @Default(false) bool isSegmentLoading,
  }) = _PerformanceState;

  factory PerformanceState.initial() => const PerformanceState();

  const PerformanceState._();

  bool get hasMore => nextCursor != null;
  bool get notFound => errorCode == 'PERFORMANCE_BOARD_NOT_FOUND';
}
