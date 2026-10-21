part of 'feed_bloc.dart';

/// `FeedBloc`'s handlers, split out so the bloc file stays readable. A part
/// file rather than a standalone extension because these touch the bloc's
/// private `_generation` and `_pendingWrites`.
extension FeedBlocHandlers on FeedBloc {
  Future<void> _load(Emitter<FeedState> emit, {String? communityId}) async {
    _generation++;
    emit(
      state.copyWith(
        state: RequestState.loading,
        message: '',
        communityId: communityId,
      ),
    );
    final result = await _getPosts.execute(page: 1, communityId: communityId);
    result.fold(
      (failure) => emit(
        state.copyWith(state: RequestState.error, message: failure.message),
      ),
      (page) {
        emit(
          state.copyWith(
            state: RequestState.loaded,
            message: '',
            posts: page.posts,
            page: page.page,
            hasMore: page.hasMore,
            isLoadingMore: false,
          ),
        );
        _hydrate(page.posts, _generation);
      },
    );
  }

  Future<void> _loadMore(Emitter<FeedState> emit) async {
    if (!state.hasMore || state.isLoadingMore || !state.state.isLoaded) return;
    final generation = _generation;
    emit(state.copyWith(isLoadingMore: true));
    final result = await _getPosts.execute(
      page: state.page + 1,
      communityId: state.communityId,
    );
    if (generation != _generation) return;
    result.fold(
      // A failed extra page keeps the rendered list and leaves `hasMore`
      // alone, so scrolling again retries. Flipping to `error` here would
      // blank a feed the user is already reading.
      (failure) =>
          emit(state.copyWith(isLoadingMore: false, message: failure.message)),
      (page) {
        emit(
          state.copyWith(
            posts: [...state.posts, ...page.posts],
            page: page.page,
            hasMore: page.hasMore,
            isLoadingMore: false,
            message: '',
          ),
        );
        _hydrate(page.posts, generation);
      },
    );
  }

  /// Fetches each post's reactions, deliberately **not** awaited: the posts
  /// are already emitted, so they paint while these fill in. Returns `void`
  /// rather than a future so nothing downstream can accidentally block on it.
  ///
  /// One post's failure is not the feed's failure — it just leaves that card
  /// with no badge stack.
  void _hydrate(List<FeedPostModel> posts, int generation) {
    for (final post in posts) {
      _hydrateOne(post.id, generation);
    }
  }

  /// One post's reactor list. Split out of [_hydrate] because a write has to
  /// re-run it for the post that was just reacted to: `PUT`/`DELETE` answer
  /// with counts but never with rows, so without this the Reactions sheet
  /// would keep showing whoever had reacted at load time — nobody at all, for
  /// a post whose first reaction is the user's own.
  ///
  /// Counts and `myReaction` are **not** taken from here. The post list
  /// carries both, exactly; this endpoint pages at 50, so folding its rows
  /// would undercount a popular post.
  void _hydrateOne(String postId, int generation) {
    _getPostReactions.execute(postId).then((result) {
      if (isClosed || generation != _generation) return;
      result.fold(
        (failure) =>
            logger.warning('Reactions for $postId failed: ${failure.message}'),
        (page) => add(
          FeedEvent.reactionsHydrated(
            generation: generation,
            postId: postId,
            reactors: page.reactors,
          ),
        ),
      );
    });
  }

  void _onHydrated(_ReactionsHydrated value, Emitter<FeedState> emit) {
    if (value.generation != _generation) return;
    emit(
      state.copyWith(
        posts: state.posts.applyReactors(value.postId, value.reactors),
      ),
    );
  }

  /// Patches the post optimistically, then reconciles with the server's
  /// authoritative counts — or rolls that one post back on failure. Stays in
  /// `RequestState.loaded` throughout: a failed reaction must never blank the
  /// feed, it just raises a message.
  Future<void> _write(
    Emitter<FeedState> emit,
    String postId,
    List<FeedPostModel> Function(List<FeedPostModel>) optimistic,
    Future<Either<Failure, ReactionSummaryModel>> Function() call,
  ) async {
    final before = state.posts;
    _pendingWrites.add(postId);
    emit(state.copyWith(posts: optimistic(before), message: ''));
    final result = await call();
    _pendingWrites.remove(postId);
    emit(
      result.fold(
        (failure) => state.copyWith(
          posts: state.posts.replacing(before.byId(postId)),
          message: failure.message,
        ),
        (summary) => state.copyWith(
          posts: state.posts.applySummary(postId, summary),
          message: '',
        ),
      ),
    );
    // The summary carries no rows, so re-read them — the sheet behind the
    // card is live and would otherwise still list the pre-write reactors.
    if (result.isRight()) _hydrateOne(postId, _generation);
  }
}
