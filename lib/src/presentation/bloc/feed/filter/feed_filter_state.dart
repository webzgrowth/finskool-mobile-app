part of 'feed_filter_bloc.dart';

@freezed
sealed class FeedFilterState with _$FeedFilterState {
  const factory FeedFilterState({required String query}) = _FeedFilterState;

  factory FeedFilterState.initial() => const FeedFilterState(query: '');
}
