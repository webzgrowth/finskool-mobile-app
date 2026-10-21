import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/presentation/bloc/feed/posts/feed_bloc.dart';
import 'package:finskool/src/presentation/bloc/feed/filter/feed_filter_bloc.dart';
import 'package:finskool/src/comman/widgets/search_top_bar.dart';

import 'feed_body_slivers.dart';

/// The feed itself — top bar, post list, pull-to-refresh, infinite scroll
/// and the failure snackbar.
///
/// Shared by the Feed **tab** and a single community's feed, which differ
/// only in their top bar and in which `communityId` their [FeedBloc] was
/// loaded with. Everything here resolves its blocs from `context`, so a
/// scoped `BlocProvider` above this widget is all it takes to point the
/// whole subtree at a different community.
///
/// It deliberately does **not** dispatch the initial load: the tab loads
/// only when empty (it stays mounted in an `IndexedStack`), a community
/// loads once when its bloc is created. Each owner does its own.
class FeedListView extends StatefulWidget {
  const FeedListView({super.key, required this.topBar, this.toolbarHeight});

  /// Rendered inside a floating [SliverAppBar] — Material's hide-on-scroll
  /// pattern, not a hand-rolled controller.
  final Widget topBar;

  /// The `SliverAppBar` cannot size itself to [topBar], so a bar that is
  /// taller than the default — one carrying a back arrow and a community
  /// name — must say so, or it overflows its box. Use
  /// [SearchTopBar.heightFor].
  /// Null asks for [SearchTopBar.heightFor] — the plain bar, including the
  /// status-bar shortfall on devices whose inset is under Figma's 44.
  final double? toolbarHeight;

  @override
  State<FeedListView> createState() => _FeedListViewState();
}

class _FeedListViewState extends State<FeedListView> {
  final _controller = ScrollController();

  /// How far from the bottom to ask for the next page.
  static const double _loadMoreThreshold = 600;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_controller.hasClients) return;
    final position = _controller.position;

    // Nothing to page into until the list is long enough to scroll at all.
    // Without this, a feed shorter than the viewport reports a
    // `maxScrollExtent` of 0 and every guard below reads as "at the bottom".
    if (position.maxScrollExtent <= 0) return;

    // The threshold is clamped to half the list rather than subtracted flat.
    // `maxScrollExtent - 600` goes *negative* on any feed shorter than 600px,
    // so `pixels < trigger` was false from `pixels: 0` onward and loadMore
    // fired on every scroll tick, in both directions.
    final trigger =
        position.maxScrollExtent -
        math.min(_loadMoreThreshold, position.maxScrollExtent / 2);
    if (position.pixels < trigger) return;

    // The same guard the bloc applies, repeated here so a feed that has no
    // next page stops dispatching at the source instead of churning one
    // dropped event per scroll notification.
    final bloc = context.read<FeedBloc>();
    final state = bloc.state;
    if (!state.hasMore || state.isLoadingMore || !state.state.isLoaded) return;
    bloc.add(const FeedEvent.loadMore());
  }

  /// `refreshFeed` keeps whichever community this feed is scoped to — it
  /// re-reads `state.communityId` rather than resetting to the free feed.
  Future<void> _refresh() {
    final bloc = context.read<FeedBloc>()..add(const FeedEvent.refreshFeed());
    return bloc.stream.firstWhere((s) => !s.state.isLoading);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FeedBloc, FeedState>(
      // A failed reaction or a failed extra page keeps the rendered feed
      // and surfaces the server's copy here instead.
      listenWhen: (previous, current) =>
          current.message.isNotEmpty &&
          current.message != previous.message &&
          current.posts.isNotEmpty,
      listener: (context, state) =>
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message))),
      child: BlocBuilder<FeedFilterBloc, FeedFilterState>(
        builder: (context, filterState) {
          final query = filterState.query.trim();
          return BlocBuilder<FeedBloc, FeedState>(
            builder: (context, feedState) => RefreshIndicator(
              onRefresh: _refresh,
              child: CustomScrollView(
                controller: _controller,
                slivers: [
                  SliverAppBar(
                    floating: true,
                    snap: true,
                    toolbarHeight:
                        widget.toolbarHeight ?? SearchTopBar.heightFor(context),
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    flexibleSpace: widget.topBar,
                  ),
                  // Figma: the first card sits 20 under the bar.
                  const SliverToBoxAdapter(child: SizedBox(height: 20)),
                  ...feedBodySlivers(context, feedState, query),
                  const SliverToBoxAdapter(child: SizedBox(height: 20)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
