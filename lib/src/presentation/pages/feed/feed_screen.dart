import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/presentation/bloc/feed/posts/feed_bloc.dart';
import 'package:finskool/src/presentation/bloc/feed/filter/feed_filter_bloc.dart';
import 'widgets/feed_top_bar.dart';
import 'widgets/feed_post_card.dart';

/// The main feed tab. `SliverAppBar(floating: true, snap: true)` gives
/// the "hide on scroll down, snap back on scroll up" behavior for free —
/// Material's built-in floating-app-bar pattern, not a hand-rolled
/// `AnimationController` (see CLAUDE.md's "Bloc granularity" note on why
/// this scroll-driven visibility isn't a bloc either).
class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FeedBloc>().add(const FeedEvent.loadFeed());
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: cs.surfaceContainer,
      body: BlocBuilder<FeedFilterBloc, FeedFilterState>(
        builder: (context, filterState) {
          return BlocBuilder<FeedBloc, FeedState>(
            builder: (context, feedState) {
              final posts = feedState.posts.where((p) {
                final query = filterState.query.trim().toLowerCase();
                if (query.isEmpty) return true;
                return p.title.toLowerCase().contains(query) ||
                    p.body.toLowerCase().contains(query) ||
                    p.hashtags.any((h) => h.toLowerCase().contains(query));
              }).toList();

              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    floating: true,
                    snap: true,
                    toolbarHeight: 92,
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    flexibleSpace: const FeedTopBar(),
                  ),
                  if (feedState.state.isLoading || feedState.state.isEmpty)
                    const SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else
                    SliverList.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, i) =>
                          FeedPostCard(post: posts[i]),
                    ),
                  const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg)),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
