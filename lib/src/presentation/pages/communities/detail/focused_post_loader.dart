import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finskool/src/presentation/bloc/feed/posts/feed_bloc.dart';

/// Keeps loading the community's feed until [postId] is in it, so a tapped
/// notification can bring that post to the top however many pages back it is.
///
/// There is no single-post endpoint, so this is the only way to find one. It
/// gives up after [maxPages] pages (the post is then simply not shown first)
/// and does nothing at all when [postId] is null.
class FocusedPostLoader extends StatelessWidget {
  const FocusedPostLoader({
    super.key,
    required this.postId,
    required this.child,
    this.maxPages = 10,
  });

  final String? postId;
  final Widget child;
  final int maxPages;

  @override
  Widget build(BuildContext context) {
    final id = postId;
    if (id == null) return child;
    return BlocListener<FeedBloc, FeedState>(
      listener: (context, state) {
        final settled = state.state.isLoaded && !state.isLoadingMore;
        final found = state.posts.any((p) => p.id == id);
        if (settled && !found && state.hasMore && state.page < maxPages) {
          context.read<FeedBloc>().add(const FeedEvent.loadMore());
        }
      },
      child: child,
    );
  }
}
