import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/injections/injection.dart';
import 'package:finskool/src/comman/widgets/search_top_bar.dart';
import 'package:finskool/src/presentation/bloc/communities/list/communities_bloc.dart';
import 'package:finskool/src/presentation/bloc/feed/filter/feed_filter_bloc.dart';

import 'focused_post_loader.dart';

import 'package:finskool/src/presentation/bloc/feed/posts/feed_bloc.dart';
import 'package:finskool/src/presentation/pages/feed/widgets/feed_list_view.dart';
import 'package:finskool/src/presentation/pages/feed/widgets/feed_top_bar.dart';

/// The inside of a community: its own feed, scoped to [communityId].
///
/// Identical UI to the Feed tab — same cards, reactions, search,
/// pull-to-refresh and paging — because it is literally [FeedListView], the
/// widget that tab uses. Only the top bar differs, gaining a back arrow and
/// the community's name.
///
/// **Both blocs are scoped to this route.** They are `@injectable`
/// factories, so `locator<T>()` hands back fresh instances: entering a
/// community cannot disturb the Feed tab's posts, scroll offset or search
/// text, and leaving disposes them. Everything below resolves its bloc from
/// `context`, so the whole subtree follows automatically.
class CommunityDetailScreen extends StatelessWidget {
  const CommunityDetailScreen({
    super.key,
    required this.communityId,
    this.communityName,
    this.focusPostId,
  });

  final String communityId;

  /// Null when the screen was opened from a notification, which carries only
  /// an id; the title is then looked up in the loaded communities.
  final String? communityName;

  /// A post to bring to the top (a tapped "New announcement"). The feed pages
  /// on until it turns up, so it is found however old it is.
  final String? focusPostId;

  /// The community's name from the loaded catalog, watched so a cold start
  /// that opens before the catalog arrives fixes its title when it does.
  String _titleFor(BuildContext context) {
    for (final c in context.watch<CommunitiesBloc>().state.communities) {
      if (c.id == communityId) return c.name;
    }
    return 'Community';
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          // Dispatched here rather than in an `initState`: `add()` only
          // queues, and creating-then-loading in one expression means the
          // first build already has a request in flight.
          create: (_) =>
              locator<FeedBloc>()
                ..add(FeedEvent.loadFeed(communityId: communityId)),
        ),
        BlocProvider(create: (_) => locator<FeedFilterBloc>()),
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        body: FocusedPostLoader(
          postId: focusPostId,
          child: FeedListView(
            focusPostId: focusPostId,
            // Taller than the tab's bar: it carries a back arrow and the
            // community name above the search field.
            toolbarHeight: SearchTopBar.heightFor(context, hasTitle: true),
            topBar: FeedTopBar(
              onBack: () => context.pop(),
              title: communityName ?? _titleFor(context),
              // Notifications are read from the tabs, not from inside a
              // single community.
              showNotifications: false,
            ),
          ),
        ),
      ),
    );
  }
}
