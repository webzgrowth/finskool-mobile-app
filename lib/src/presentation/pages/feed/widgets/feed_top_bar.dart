import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finskool/src/comman/widgets/search_top_bar.dart';
import 'package:finskool/src/presentation/bloc/feed/filter/feed_filter_bloc.dart';

import 'feed_filter_sheet.dart';

/// The feed's search bar — the shared [SearchTopBar] chrome bound to
/// [FeedFilterBloc]. The Communities tab uses the same bar with its own
/// copy and callbacks.
class FeedTopBar extends StatelessWidget {
  const FeedTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SearchTopBar(
      hintText: 'Search posts, stocks or tags...',
      onQueryChanged: (v) =>
          context.read<FeedFilterBloc>().add(FeedFilterEvent.queryChanged(v)),
      onFilterTap: () => showFeedFilterSheet(context),
    );
  }
}
