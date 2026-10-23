import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'services_filter_event.dart';
part 'services_filter_state.dart';
part 'services_filter_bloc.freezed.dart';

/// The Services search text, apart from the catalog — the same split as
/// `CommunityFilterBloc` and `FeedFilterBloc`.
@singleton
class ServicesFilterBloc
    extends Bloc<ServicesFilterEvent, ServicesFilterState> {
  ServicesFilterBloc() : super(ServicesFilterState.initial()) {
    on<ServicesFilterEvent>((event, emit) {
      event.map(
        queryChanged: (e) => emit(state.copyWith(query: e.query)),
        cleared: (_) => emit(ServicesFilterState.initial()),
      );
    });
  }
}
