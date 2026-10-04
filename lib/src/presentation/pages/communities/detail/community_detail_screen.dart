import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/injections/injection.dart';
import 'package:finskool/src/comman/widgets/search_top_bar.dart';
import 'package:finskool/src/presentation/bloc/feed/filter/feed_filter_bloc.dart';
import 'package:finskool/src/presentation/bloc/feed/posts/feed_bloc.dart';
import 'package:finskool/src/presentation/pages/feed/widgets/feed_list_view.dart';
import 'package:finskool/src/presentation/pages/feed/widgets/feed_top_bar.dart';

/// The inside of a community: its own feed, scoped to [communityId].
///
/// Identical UI to the Feed tab — same cards, reactions, search, filter,
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
    required this.communityName,
  });

  final String communityId;
  final String communityName;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          // Dispatched here rather than in an `initState`: `add()` only
          // queues, and creating-then-loading in one expression means the
          // first build already has a request in flight.
          create: (_) => locator<FeedBloc>()
            ..add(FeedEvent.loadFeed(communityId: communityId)),
        ),
        BlocProvider(create: (_) => locator<FeedFilterBloc>()),
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        body: FeedListView(
          // Taller than the tab's bar: it carries a back arrow and the
          // community name above the search field.
          toolbarHeight: SearchTopBar.heightFor(context, hasTitle: true),
          topBar: FeedTopBar(
            onBack: () => context.pop(),
            title: communityName,
            // Notifications are read from the tabs, not from inside a
            // single community.
            showNotifications: false,
          ),
        ),
      ),
    );
  }
}
