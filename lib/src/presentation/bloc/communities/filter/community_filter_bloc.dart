import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'community_filter_event.dart';
part 'community_filter_state.dart';
part 'community_filter_bloc.freezed.dart';

/// Owns the Communities search text, kept separate from
/// [CommunitiesBloc] exactly as [FeedFilterBloc] is from [FeedBloc] —
/// "what the user is searching for" and "the catalog itself" are different
/// responsibilities. The screen combines both in the widget layer.
@singleton
class CommunityFilterBloc
    extends Bloc<CommunityFilterEvent, CommunityFilterState> {
  CommunityFilterBloc() : super(CommunityFilterState.initial()) {
    on<CommunityFilterEvent>((event, emit) {
      event.map(
        queryChanged: (value) => emit(state.copyWith(query: value.query)),
        cleared: (_) => emit(CommunityFilterState.initial()),
      );
    });
  }
}
