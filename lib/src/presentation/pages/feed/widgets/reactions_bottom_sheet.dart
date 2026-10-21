import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/domain/model/feed_post_model.dart';
import 'package:finskool/src/domain/model/reaction_type.dart';
import 'package:finskool/src/presentation/bloc/feed/posts/feed_bloc.dart';

import 'reaction_icons.dart';
import 'reaction_tab.dart';
import 'reactor_list_tile.dart';

/// Who reacted, filterable by reaction. Measured from Figma's sheet in
/// frame `605:16036`: 486/852 of the screen, white, 10px top corners, an
/// 82x5 near-black handle, an 18px semibold title, then the underlined tab
/// row over a `#D9D9D9` rule.
///
/// Takes a post **id**, not a reactor list: it reads the post back out of
/// [FeedBloc] so the sheet keeps up with reaction data still arriving from
/// hydration, and with the user reacting from the card behind it.
Future<void> showReactionsSheet(
  BuildContext context, {
  required String postId,
}) {
  final bloc = context.read<FeedBloc>();
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    // The sheet is pushed on the root navigator, outside this subtree, so
    // the bloc has to be handed across explicitly.
    builder: (_) => BlocProvider.value(
      value: bloc,
      child: BlocSelector<FeedBloc, FeedState, FeedPostModel?>(
        selector: (state) => _postById(state, postId),
        builder: (_, post) => post == null
            ? const SizedBox.shrink()
            : _ReactionsSheet(post: post),
      ),
    ),
  );
}

FeedPostModel? _postById(FeedState state, String postId) {
  for (final post in state.posts) {
    if (post.id == postId) return post;
  }
  return null;
}

class _ReactionsSheet extends StatefulWidget {
  const _ReactionsSheet({required this.post});

  final FeedPostModel post;

  @override
  State<_ReactionsSheet> createState() => _ReactionsSheetState();
}

class _ReactionsSheetState extends State<_ReactionsSheet> {
  ReactionType? _filter;

  /// Figma: sheet 486 tall on an 852 frame.
  static const double _heightFraction = 486 / 852;

  /// Figma: content inset 13 from each edge.
  static const double _inset = 13;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final type = context.feedType;

    final reactors = widget.post.reactors;
    // The post's own counts, not a fold over [reactors]: a write answers with
    // authoritative counts and no rows, so the rows lag by one round-trip
    // while the re-read lands.
    final counts = widget.post.reactionCounts;
    final visible = _filter == null
        ? reactors
        : reactors.where((r) => r.reaction == _filter).toList();

    return Container(
      height: MediaQuery.sizeOf(context).height * _heightFraction,
      decoration: BoxDecoration(
        color: cs.surface,
        // Figma corner radii are [10, 10, 0, 0] — square at the bottom.
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
      ),
      // SafeArea goes around the content, not the whole sheet — wrapping
      // the Container itself shrinks it away from the true bottom edge,
      // leaving the modal scrim visible below it as a "cut off" gap.
      child: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
            Center(
              child: Container(
                height: 5,
                width: 82,
                decoration: BoxDecoration(
                  color: AppPalette.sheetHandle,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 11),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: _inset),
              child: Text('Reactions', style: type.sheetTitle),
            ),
            const SizedBox(height: 7),
            _TabRow(
              inset: _inset,
              // The post's authoritative total, which can exceed the rows
              // fetched — the reactions endpoint pages at 50.
              total: widget.post.totalReactions,
              counts: counts,
              filter: _filter,
              onSelect: (f) => setState(() => _filter = f),
            ),
            Expanded(
              child: visible.isEmpty
                  ? Center(
                      child: Text('No reactions yet', style: type.timestamp),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(top: 6),
                      itemCount: visible.length,
                      itemBuilder: (context, i) => ReactorListTile(
                        reactor: visible[i],
                        showDivider: i != visible.length - 1,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The filter row: a full-width rule with the selected tab's teal underline
/// drawn over it. Scrolls horizontally — six reactions plus "All" is wider
/// than Figma's five.
class _TabRow extends StatelessWidget {
  const _TabRow({
    required this.inset,
    required this.total,
    required this.counts,
    required this.filter,
    required this.onSelect,
  });

  final double inset;
  final int total;
  final Map<ReactionType, int> counts;
  final ReactionType? filter;
  final ValueChanged<ReactionType?> onSelect;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // The rule sits behind every tab, inset like the rest of the content.
        Positioned(
          left: inset,
          right: inset,
          bottom: 0,
          child: Container(height: 1, color: AppPalette.tabDivider),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: inset),
          child: Row(
            children: [
              ReactionTab(
                count: total,
                selected: filter == null,
                onTap: () => onSelect(null),
              ),
              // Every reaction gets a tab, including zero-count ones — Figma
              // shows "0" tabs rather than hiding them.
              for (final reaction in ReactionIcons.sheetOrder)
                ReactionTab(
                  reaction: reaction,
                  count: counts[reaction] ?? 0,
                  selected: filter == reaction,
                  onTap: () => onSelect(reaction),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
