part of 'feed_bloc.dart';

@freezed
class FeedEvent with _$FeedEvent {
  const factory FeedEvent.loadFeed() = _LoadFeed;
  const factory FeedEvent.reactToPost({
    required String postId,
    required ReactionType reaction,
  }) = _ReactToPost;
  const factory FeedEvent.removeReaction({required String postId}) =
      _RemoveReaction;
}
