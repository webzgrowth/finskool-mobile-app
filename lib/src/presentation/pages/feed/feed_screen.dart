import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finskool/src/presentation/bloc/feed/posts/feed_bloc.dart';
import 'widgets/feed_list_view.dart';
import 'widgets/feed_top_bar.dart';

/// The Feed **tab** — the free community's posts.
///
/// The feed itself lives in [FeedListView], shared with a single community's
/// feed (`CommunityDetailScreen`); this screen supplies only the tab's top
/// bar and its initial load. It reads the app-wide [FeedBloc] from
/// `main.dart`'s provider, where a community's feed scopes its own instance.
class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  void initState() {
    super.initState();
    // The tab lives in an IndexedStack and stays mounted, so only load when
    // there's nothing there yet — otherwise every rebuild refetches.
    final bloc = context.read<FeedBloc>();
    if (bloc.state.posts.isEmpty) {
      bloc.add(const FeedEvent.loadFeed());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      body: const FeedListView(topBar: FeedTopBar()),
    );
  }
}
