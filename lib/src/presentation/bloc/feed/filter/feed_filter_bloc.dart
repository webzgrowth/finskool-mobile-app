import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'feed_filter_event.dart';
part 'feed_filter_state.dart';
part 'feed_filter_bloc.freezed.dart';

/// Owns the feed search text and active filter-chip selection — kept
/// separate from [FeedBloc] since "what the user is searching/filtering
/// for" and "the post data itself" are different responsibilities (see
/// CLAUDE.md's "Bloc granularity" note). `FeedScreen` combines this
/// bloc's state with `FeedBloc`'s post list in the widget layer.
@singleton
class FeedFilterBloc extends Bloc<FeedFilterEvent, FeedFilterState> {
  FeedFilterBloc() : super(FeedFilterState.initial()) {
    on<FeedFilterEvent>((event, emit) {
      event.map(
        queryChanged: (_QueryChanged value) =>
            emit(state.copyWith(query: value.query)),
        filterToggled: (_FilterToggled value) {
          final ids = Set<String>.from(state.activeFilterIds);
          if (!ids.remove(value.filterId)) ids.add(value.filterId);
          emit(state.copyWith(activeFilterIds: ids));
        },
        filtersCleared: (_FiltersCleared value) =>
            emit(state.copyWith(activeFilterIds: {})),
      );
    });
  }
}
