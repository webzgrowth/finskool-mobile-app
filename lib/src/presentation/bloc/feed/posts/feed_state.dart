part of 'feed_bloc.dart';

@freezed
sealed class FeedState with _$FeedState {
  const factory FeedState({
    required RequestState state,

    /// The last failure's copy. Shown as a snackbar rather than replacing the
    /// list, so a failed reaction or a failed extra page doesn't wipe the
    /// feed that's already rendered.
    required String message,
    required List<FeedPostModel> posts,
    required int page,
    required bool hasMore,
    required bool isLoadingMore,
    String? communityId,
  }) = _FeedState;

  const FeedState._();

  factory FeedState.initial() => const FeedState(
        state: RequestState.empty,
        message: '',
        posts: [],
        page: 0,
        hasMore: true,
        isLoadingMore: false,
      );

  /// Loaded, but the backend genuinely has nothing. Distinct from "the search
  /// box filtered everything out", which the screen computes itself.
  bool get hasNoPosts => state.isLoaded && posts.isEmpty;
}
