import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/feed_post_model.dart';
import 'package:finskool/src/domain/model/reaction_summary_model.dart';
import 'package:finskool/src/domain/model/reaction_type.dart';
import 'package:finskool/src/domain/model/reactor_model.dart';
import 'package:finskool/src/domain/usecases/feed/get_post_reactions.dart';
import 'package:finskool/src/domain/usecases/feed/get_posts.dart';
import 'package:finskool/src/domain/usecases/feed/react_to_post.dart';
import 'package:finskool/src/domain/usecases/feed/remove_reaction.dart';
import 'package:finskool/src/presentation/bloc/feed/posts/feed_reaction_patch.dart';
import 'package:finskool/src/utilities/logger.dart';

part 'feed_event.dart';
part 'feed_state.dart';
part 'feed_bloc_handlers.dart';
part 'feed_bloc.freezed.dart';

/// Owns the post list and each post's reaction state. Search/filter state
/// lives separately in [FeedFilterBloc] — see CLAUDE.md's "Bloc
/// granularity" note on why these aren't merged.
///
/// `GET /mobile/posts` carries each post's `reactionCounts` and `myReaction`,
/// so those need no extra call. Only the *reactor list* behind the Reactions
/// sheet is fetched per post afterwards — see [_hydrate].///
/// **`@injectable`, not `@singleton`** — the one deviation from the
/// convention in CLAUDE.md, and it is load-bearing. A community's feed
/// (`CommunityDetailScreen`) scopes its own instance, so entering a
/// community cannot clobber the Feed tab's posts, scroll position or
/// `communityId`. `main.dart`'s `BlocProvider(create: (_) => locator<T>())`
/// still yields exactly one app-lifetime instance for the tab; every other
/// `locator<T>()` call now returns a *new* bloc, so don't add one expecting
/// the shared instance.
@injectable
class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc(
    this._getPosts,
    this._getPostReactions,
    this._reactToPost,
    this._removeReaction,
  ) : super(FeedState.initial()) {
    on<FeedEvent>((event, emit) async {
      await event.map(
        loadFeed: (value) => _load(emit, communityId: value.communityId),
        refreshFeed: (_) => _load(emit, communityId: state.communityId),
        loadMore: (_) => _loadMore(emit),
        reactToPost: (value) => _write(
          emit,
          value.postId,
          (posts) => posts.applyOptimistic(value.postId, value.reaction),
          () => _reactToPost.execute(
            postId: value.postId,
            reaction: value.reaction,
          ),
        ),
        removeReaction: (value) => _write(
          emit,
          value.postId,
          (posts) => posts.applyOptimisticRemoval(value.postId),
          () => _removeReaction.execute(value.postId),
        ),
        reactionsHydrated: (value) async => _onHydrated(value, emit),
      );
    });
  }

  final GetPosts _getPosts;
  final GetPostReactions _getPostReactions;
  final ReactToPost _reactToPost;
  final RemoveReaction _removeReaction;

  /// Bumped by every (re)load. A hydration response tagged with an older
  /// generation belongs to a feed that's been replaced, and is dropped.
  int _generation = 0;

  /// Posts with a reaction write in flight, so a rollback can tell a failed
  /// write apart from a stale one.
  final Set<String> _pendingWrites = {};
}
