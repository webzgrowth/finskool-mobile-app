part of 'performance_bloc.dart';

/// The server says this cursor isn't one it gave out; start the list over.
const _invalidCursor = 'INVALID_CURSOR';

extension _PerformanceActions on PerformanceBloc {
  Future<void> _load(
    String communityId,
    PerformanceSegment? segment,
    Emitter<PerformanceState> emit,
  ) async {
    final generation = ++_generation;
    emit(
      PerformanceState(
        state: RequestState.loading,
        communityId: communityId,
        segment: segment,
      ),
    );
    final result = await holdSkeletonOnFailure(
      () => _getBoard.execute(communityId: communityId, segment: segment),
    );
    if (generation != _generation) return;
    emit(
      result.fold(
        (failure) => state.copyWith(
          state: RequestState.error,
          message: failure.message,
          errorCode: failure.code,
        ),
        (board) => state.copyWith(
          state: RequestState.loaded,
          board: board,
          items: board.items,
          nextCursor: board.nextCursor,
          segment: board.segment,
        ),
      ),
    );
  }

  Future<void> _changeFilter(
    PerformanceMonthFilter? filter,
    Emitter<PerformanceState> emit,
  ) async {
    if (!state.state.isLoaded || filter == state.filter) return;
    await _reloadPage(filter, state.filter, emit);
  }

  /// Re-reads the board for [filter] from its first page. The answer replaces
  /// the **whole** board — summary, trades, hidden count — because the filter
  /// narrows them together; patching only the list would leave cards for one
  /// set of months above trades from another. On failure the filter goes back
  /// to [previous] and the old board stays: a failed filter must not blank what
  /// the member is reading.
  Future<void> _reloadPage(
    PerformanceMonthFilter? filter,
    PerformanceMonthFilter? previous,
    Emitter<PerformanceState> emit,
  ) async {
    final generation = ++_generation;
    emit(
      state.copyWith(
        filter: filter,
        isListLoading: true,
        isLoadingMore: false,
        message: '',
      ),
    );
    final result = await _getBoard.execute(
      communityId: state.communityId,
      segment: state.segment,
      filter: filter,
    );
    if (generation != _generation) return;
    emit(
      result.fold(
        (failure) => state.copyWith(
          filter: previous,
          isListLoading: false,
          message: failure.message,
        ),
        (page) => state.copyWith(
          board: page,
          items: page.items,
          nextCursor: page.nextCursor,
          isListLoading: false,
        ),
      ),
    );
  }

  Future<void> _loadMore(Emitter<PerformanceState> emit) async {
    final cursor = state.nextCursor;
    if (!state.state.isLoaded ||
        cursor == null ||
        state.isLoadingMore ||
        state.isListLoading) {
      return;
    }
    final generation = _generation;
    emit(state.copyWith(isLoadingMore: true, message: ''));
    final result = await _getBoard.execute(
      communityId: state.communityId,
      segment: state.segment,
      filter: state.filter,
      cursor: cursor,
    );
    if (generation != _generation) return;
    final failure = result.swap().toOption().toNullable();
    if (failure?.code == _invalidCursor) {
      return _reloadPage(state.filter, state.filter, emit);
    }
    emit(
      result.fold(
        (f) => state.copyWith(isLoadingMore: false, message: f.message),
        (page) {
          final seen = {for (final t in state.items) t.id};
          return state.copyWith(
            items: [
              ...state.items,
              for (final t in page.items)
                if (!seen.contains(t.id)) t,
            ],
            nextCursor: page.nextCursor,
            isLoadingMore: false,
          );
        },
      ),
    );
  }
}
