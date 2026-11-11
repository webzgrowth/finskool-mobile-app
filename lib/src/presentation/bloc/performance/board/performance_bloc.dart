import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/comman/min_skeleton.dart';
import 'package:finskool/src/domain/model/performance/performance_board.dart';
import 'package:finskool/src/domain/model/performance/performance_filter.dart';
import 'package:finskool/src/domain/model/performance/performance_kind.dart';
import 'package:finskool/src/domain/model/performance/performance_trade.dart';
import 'package:finskool/src/domain/usecases/performance/get_performance_board.dart';

part 'performance_event.dart';
part 'performance_state.dart';
part 'performance_actions.dart';
part 'performance_bloc.freezed.dart';

/// One community's Performance screen: its summary, trades, investor segment
/// and month filter (a month, or a From–To run).
///
/// **`@injectable`, route-scoped** like `FeedBloc` in a community — a board
/// must never outlive its screen, so one community's trades can't show under
/// the next. Segment, filter and paging are parameters of the same query, so
/// they live here rather than in blocs of their own.
@injectable
class PerformanceBloc extends Bloc<PerformanceEvent, PerformanceState> {
  PerformanceBloc(this._getBoard) : super(PerformanceState.initial()) {
    on<PerformanceEvent>((event, emit) async {
      await event.map(
        load: (e) => _load(e.communityId, e.segment, emit),
        segmentChanged: (e) => e.segment == state.segment
            ? Future<void>.value()
            : _switchSegment(e.segment, emit),
        filterChanged: (e) => _changeFilter(e.filter, emit),
        loadMore: (_) => _loadMore(emit),
      );
    });
  }

  final GetPerformanceBoard _getBoard;

  /// Bumped by every load and filter change, so a slow answer for a list the
  /// member has already left (another segment, another month) is dropped.
  int _generation = 0;

  /// The last settled screen before a tab switch began, so a failed switch can
  /// put the member back where they were.
  PerformanceState? _beforeSwitch;
}
