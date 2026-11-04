import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'feed_filter_event.dart';
part 'feed_filter_state.dart';
part 'feed_filter_bloc.freezed.dart';

/// Owns the feed search text — kept
/// separate from [FeedBloc] since "what the user is searching
/// for" and "the post data itself" are different responsibilities (see
/// CLAUDE.md's "Bloc granularity" note). `FeedScreen` combines this
/// bloc's state with `FeedBloc`'s post list in the widget layer.
///
/// **`@injectable`, not `@singleton`** — the one deviation from the
/// convention in CLAUDE.md, and it is load-bearing. A community's feed
/// (`CommunityDetailScreen`) scopes its own instance, so entering a
/// community cannot clobber the Feed tab's posts, scroll position or
/// `communityId`. `main.dart`'s `BlocProvider(create: (_) => locator<T>())`
/// still yields exactly one app-lifetime instance for the tab; every other
/// `locator<T>()` call now returns a *new* bloc, so don't add one expecting
/// the shared instance.
@injectable
class FeedFilterBloc extends Bloc<FeedFilterEvent, FeedFilterState> {
  FeedFilterBloc() : super(FeedFilterState.initial()) {
    on<FeedFilterEvent>((event, emit) {
      event.map(
        queryChanged: (_QueryChanged value) =>
            emit(state.copyWith(query: value.query)),
        cleared: (_Cleared value) => emit(FeedFilterState.initial()),
      );
    });
  }
}
