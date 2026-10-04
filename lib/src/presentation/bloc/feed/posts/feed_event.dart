part of 'feed_bloc.dart';

@freezed
class FeedEvent with _$FeedEvent {
  /// Omitting [communityId] loads the free community's feed, which every
  /// account is subscribed to.
  const factory FeedEvent.loadFeed({String? communityId}) = _LoadFeed;

  /// Re-fetches page 1 without clearing the list, so `RefreshIndicator`
  /// shows its own spinner over the posts already on screen.
  const factory FeedEvent.refreshFeed() = _RefreshFeed;

  const factory FeedEvent.loadMore() = _LoadMore;

  const factory FeedEvent.reactToPost({
    required String postId,
    required ReactionType reaction,
  }) = _ReactToPost;

  const factory FeedEvent.removeReaction({required String postId}) =
      _RemoveReaction;

  /// Internal. One post's reactor list arrived. The bloc dispatches this to
  /// itself so the emit happens inside a handler — a bloc must never emit
  /// from a detached future.
  ///
  /// Carries no counts: those come complete on the post list and on every
  /// write's response, so this fetch is purely "who reacted", for the
  /// Reactions sheet.
  const factory FeedEvent.reactionsHydrated({
    required int generation,
    required String postId,
    required List<ReactorModel> reactors,
  }) = _ReactionsHydrated;
}
