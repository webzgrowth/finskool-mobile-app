part of 'performance_boards_bloc.dart';

@freezed
sealed class PerformanceBoardsState with _$PerformanceBoardsState {
  const factory PerformanceBoardsState({
    @Default(RequestState.empty) RequestState state,
    @Default(<PerformanceBoardEntry>[]) List<PerformanceBoardEntry> boards,
    @Default('') String message,
  }) = _PerformanceBoardsState;

  factory PerformanceBoardsState.initial() => const PerformanceBoardsState();

  const PerformanceBoardsState._();

  PerformanceBoardEntry? boardFor(String communityId) {
    for (final board in boards) {
      if (board.communityId == communityId) return board;
    }
    return null;
  }

  /// Whether a community gets a Performance button. Subscribed or not: a free
  /// member opens the preview.
  bool hasBoard(String communityId) => boardFor(communityId) != null;
}
