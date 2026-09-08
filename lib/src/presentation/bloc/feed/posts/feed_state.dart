part of 'feed_bloc.dart';

@freezed
sealed class FeedState with _$FeedState {
  const factory FeedState({
    required RequestState state,
    required List<FeedPostModel> posts,
  }) = _FeedState;

  factory FeedState.initial() =>
      const FeedState(state: RequestState.empty, posts: []);
}
