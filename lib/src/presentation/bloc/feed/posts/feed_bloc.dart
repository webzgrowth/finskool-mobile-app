import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/data/datasource/feed_mock_datasource.dart';
import 'package:finskool/src/domain/model/feed_post_model.dart';
import 'package:finskool/src/domain/model/reaction_type.dart';

part 'feed_event.dart';
part 'feed_state.dart';
part 'feed_bloc.freezed.dart';

/// Owns the post list and each post's reaction state. Search/filter state
/// lives separately in [FeedFilterBloc] — see CLAUDE.md's "Bloc
/// granularity" note on why these aren't merged.
@singleton
class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc() : super(FeedState.initial()) {
    on<FeedEvent>((event, emit) {
      event.map(
        loadFeed: (_LoadFeed value) => emit(state.copyWith(
          state: RequestState.loaded,
          posts: FeedMockDatasource.getPosts(),
        )),
        reactToPost: (_ReactToPost value) =>
            emit(state.copyWith(posts: _applyReaction(value))),
        removeReaction: (_RemoveReaction value) =>
            emit(state.copyWith(posts: _applyRemoval(value.postId))),
      );
    });
  }

  List<FeedPostModel> _applyReaction(_ReactToPost value) {
    return state.posts.map((post) {
      if (post.id != value.postId) return post;
      final counts = Map<ReactionType, int>.from(post.reactionCounts);
      if (post.currentUserReaction != null) {
        final previous = post.currentUserReaction!;
        counts[previous] = (counts[previous] ?? 1) - 1;
        if (counts[previous]! <= 0) counts.remove(previous);
      }
      counts[value.reaction] = (counts[value.reaction] ?? 0) + 1;
      return post.copyWith(
        reactionCounts: counts,
        currentUserReaction: value.reaction,
      );
    }).toList();
  }

  List<FeedPostModel> _applyRemoval(String postId) {
    return state.posts.map((post) {
      if (post.id != postId || post.currentUserReaction == null) return post;
      final counts = Map<ReactionType, int>.from(post.reactionCounts);
      final previous = post.currentUserReaction!;
      counts[previous] = (counts[previous] ?? 1) - 1;
      if (counts[previous]! <= 0) counts.remove(previous);
      return post.copyWith(
        reactionCounts: counts,
        clearCurrentUserReaction: true,
      );
    }).toList();
  }
}
