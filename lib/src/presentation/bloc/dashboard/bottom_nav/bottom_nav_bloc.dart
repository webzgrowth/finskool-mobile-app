import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'bottom_nav_event.dart';
part 'bottom_nav_state.dart';
part 'bottom_nav_bloc.freezed.dart';

/// Owns only which of the 4 dashboard tabs is selected — kept separate
/// from [FeedBloc]/[FeedFilterBloc] per the one-bloc-per-responsibility
/// rule (see CLAUDE.md's "Bloc granularity" note).
@singleton
class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(BottomNavState.initial()) {
    on<BottomNavEvent>((event, emit) {
      event.map(
        tabChanged: (_TabChanged value) =>
            emit(state.copyWith(selectedIndex: value.index)),
      );
    });
  }
}
