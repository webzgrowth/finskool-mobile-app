import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finskool/src/comman/widgets/skeleton.dart';
import 'package:finskool/src/domain/model/feed_post_model.dart';
import 'package:finskool/src/presentation/bloc/feed/posts/feed_bloc.dart';

import 'feed_post_card.dart';
import 'feed_post_card_skeleton.dart';
import 'feed_status_slivers.dart';

/// The feed's list-or-status slivers, split out of `feed_screen.dart` so that
/// file stays within the line rule. Which branch shows depends on three
/// things at once: whether anything loaded, whether it failed, and whether
/// the search box filtered everything out.
List<Widget> feedBodySlivers(
  BuildContext context,
  FeedState state,
  String query,
) {
  final posts = _filtered(state, query.toLowerCase());

  if (state.posts.isEmpty) {
    if (state.state.isLoading || state.state.isEmpty) {
      return const [
        SliverToBoxAdapter(
          child: Shimmer(
            child: Column(
              children: [
                FeedPostCardSkeleton(),
                FeedPostCardSkeleton(),
                FeedPostCardSkeleton(),
              ],
            ),
          ),
        ),
      ];
    }
    if (state.state.isError) {
      return [
        FeedErrorSliver(
          message: state.message,
          // Retry the feed we were actually on. Without the id, a failed
          // community feed would retry as the *free* community's.
          onRetry: () => context.read<FeedBloc>().add(
            FeedEvent.loadFeed(communityId: state.communityId),
          ),
        ),
      ];
    }
    return const [FeedEmptySliver(message: 'No posts yet. Check back soon.')];
  }

  if (posts.isEmpty) {
    return [FeedEmptySliver(message: 'Nothing matches "$query".')];
  }

  return [
    SliverList.builder(
      itemCount: posts.length,
      // A stable key per post, not per list position. Without it Flutter
      // reuses the Element (and `PostReactionBar`'s State — its live
      // `_picker` overlay entry and button `RenderBox` included) at the same
      // *index* across rebuilds, even once a different post occupies that
      // slot — a pull-to-refresh or a new post arriving bumps position 0
      // the most of any slot, which is exactly why the long-press reaction
      // picker read as "works, then doesn't" specifically on the first card.
      itemBuilder: (context, i) =>
          FeedPostCard(key: ValueKey(posts[i].id), post: posts[i]),
    ),
    if (state.isLoadingMore) const FeedLoadMoreFooter(),
  ];
}

/// Client-side search, as before — the endpoint has no text query.
List<FeedPostModel> _filtered(FeedState state, String query) {
  if (query.isEmpty) return state.posts;
  return state.posts
      .where(
        (p) =>
            p.title.toLowerCase().contains(query) ||
            p.body.toLowerCase().contains(query) ||
            p.hashtags.any((h) => h.toLowerCase().contains(query)),
      )
      .toList();
}
