import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finskool/src/presentation/bloc/feed/filter/feed_filter_bloc.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'feed_filter_chip.dart';

/// Placeholder options — no filter-panel design exists in Figma, so these are
/// guessed, wired fully to [FeedFilterBloc], and meant to be replaced when a
/// real set is specified (see CLAUDE.md).
const _filters = ['Stocks', 'Videos', 'Buy calls', 'Sell calls'];

Future<void> showFeedFilterSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _FeedFilterSheet(),
  );
}

/// The sheet reuses the Reactions sheet's chrome: white, 20px top corners, an
/// 82x5 `#141414` handle 8px from the top, an Inter 600 · 18 title — with the
/// options as pill chips and a single teal action at the foot.
class _FeedFilterSheet extends StatelessWidget {
  const _FeedFilterSheet();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FeedFilterBloc>();
    final type = context.feedType;
    return Container(
      decoration: const BoxDecoration(
        color: AppPalette.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: BlocBuilder<FeedFilterBloc, FeedFilterState>(
            builder: (context, state) {
              final active = state.activeFilterIds;
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: Text('Filter posts', style: type.sheetTitle),
                      ),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 150),
                        opacity: active.isEmpty ? 0 : 1,
                        child: GestureDetector(
                          onTap: active.isEmpty
                              ? null
                              : () => bloc.add(
                                  const FeedFilterEvent.filtersCleared(),
                                ),
                          behavior: HitTestBehavior.opaque,
                          child: Text(
                            'Clear all',
                            style: type.tabLabel.copyWith(
                              fontSize: 13,
                              color: AppPalette.badgeTeal,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      for (final f in _filters)
                        FeedFilterChip(
                          label: f,
                          selected: active.contains(f),
                          onTap: () =>
                              bloc.add(FeedFilterEvent.filterToggled(f)),
                        ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      height: 42,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppPalette.badgeTeal,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        active.isEmpty ? 'Done' : 'Show posts',
                        style: context.ticketType.button,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
