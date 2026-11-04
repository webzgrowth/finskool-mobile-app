import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/domain/model/performance/performance_board_entry.dart';
import 'package:finskool/src/domain/usecases/performance/get_performance_boards.dart';

part 'performance_boards_event.dart';
part 'performance_boards_state.dart';
part 'performance_boards_bloc.freezed.dart';

/// Which communities have a Performance screen — one call, kept for the app
/// run. The Communities tab reads it to decide who gets a Performance button.
///
/// App-lifetime, so it is loaded when the session is confirmed and reset at
/// sign-out like every bloc holding account data. A failed load is quiet: the
/// buttons simply stay hidden, and a stale list is never blanked by a failed
/// refresh.
@singleton
class PerformanceBoardsBloc
    extends Bloc<PerformanceBoardsEvent, PerformanceBoardsState> {
  PerformanceBoardsBloc(this._getBoards)
    : super(PerformanceBoardsState.initial()) {
    on<PerformanceBoardsEvent>((event, emit) async {
      await event.map(
        load: (_) => _load(emit),
        reset: (_) async {
          _epoch++;
          emit(PerformanceBoardsState.initial());
        },
      );
    });
  }

  final GetPerformanceBoards _getBoards;

  /// Bumped by `reset`, so an answer for a signed-out session is dropped.
  int _epoch = 0;

  Future<void> _load(Emitter<PerformanceBoardsState> emit) async {
    final epoch = _epoch;
    final result = await _getBoards.execute();
    if (epoch != _epoch) return;
    emit(
      result.fold(
        (failure) => state.copyWith(
          state: state.boards.isEmpty
              ? RequestState.error
              : RequestState.loaded,
          message: failure.message,
        ),
        (boards) => state.copyWith(
          state: RequestState.loaded,
          boards: boards,
          message: '',
        ),
      ),
    );
  }
}
