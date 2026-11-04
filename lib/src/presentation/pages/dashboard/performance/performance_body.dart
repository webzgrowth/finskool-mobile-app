import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/domain/model/performance/performance_kind.dart';
import 'package:finskool/src/domain/model/performance/performance_summary.dart';
import 'package:finskool/src/presentation/bloc/performance/board/performance_bloc.dart';

import 'widgets/month_filter.dart';
import 'widgets/overall_pl_card.dart';
import 'widgets/performance_note.dart';
import 'widgets/performance_states.dart';
import 'widgets/segment_tabs.dart';
import 'widgets/swing_summary_card.dart';
import 'widgets/trade_list.dart';
import 'widgets/trades_summary_card.dart';
import 'widgets/unlock_copy.dart';
import 'widgets/unlock_section.dart';

/// Everything under the header: the first-load skeleton, a failure, or the
/// board — segment tabs, the summary, the month filter, the trades and, for a
/// free member, how many more a subscription adds.
class PerformanceBody extends StatelessWidget {
  const PerformanceBody({
    super.key,
    required this.communityId,
    required this.controller,
    required this.bottomInset,
  });

  final String communityId;
  final ScrollController controller;
  final double bottomInset;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PerformanceBloc>();
    return BlocBuilder<PerformanceBloc, PerformanceState>(
      builder: (context, state) {
        final padding = EdgeInsets.fromLTRB(14, 16, 14, 32 + bottomInset);
        final board = state.board;
        if (state.state.isError) {
          return ListView(
            padding: padding,
            children: [
              if (state.notFound)
                const PerformanceMessage(
                  title: 'No performance to show yet',
                  body: "This community hasn't published a performance board.",
                )
              else
                PerformanceMessage(
                  title: "Couldn't load performance",
                  body: state.message,
                  actionLabel: 'Try again',
                  onAction: () => bloc.add(
                    PerformanceEvent.load(
                      communityId: communityId,
                      segment: state.segment,
                    ),
                  ),
                ),
            ],
          );
        }
        if (board == null) {
          return ListView(
            padding: padding,
            physics: const NeverScrollableScrollPhysics(),
            children: const [PerformanceSkeleton()],
          );
        }
        final summary = board.summary;
        return ListView(
          controller: controller,
          padding: padding,
          children: [
            if (board.segments.length > 1) ...[
              SegmentTabs(
                segments: board.segments,
                selected: state.segment,
                onSelected: (s) => bloc.add(PerformanceEvent.segmentChanged(s)),
              ),
              const SizedBox(height: 14),
            ],
            // A filter change is a new request that replaces the whole screen:
            // the cards stay up, dimmed, until the answer replaces them.
            AnimatedOpacity(
              duration: const Duration(milliseconds: 150),
              opacity: state.isListLoading ? 0.4 : 1,
              child: switch (summary) {
                final IntradaySummary s => Column(
                  children: [
                    OverallPlCard(summary: s),
                    const SizedBox(height: 14),
                    TradesSummaryCard(summary: s),
                    if (board.noteText != null) ...[
                      const SizedBox(height: 14),
                      PerformanceNote(text: board.noteText!),
                    ],
                  ],
                ),
                final SwingSummary s => SwingSummaryCard(summary: s),
              },
            ),
            const SizedBox(height: 18),
            MonthFilter(
              // A new tab has its own months: start the pickers afresh.
              key: ValueKey(state.segment),
              range: board.kind != PerformanceKind.intraday,
              months: board.months,
              filter: state.filter,
              onChanged: (f) => bloc.add(PerformanceEvent.filterChanged(f)),
            ),
            const SizedBox(height: 4),
            if (state.isListLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (state.items.isEmpty)
              PerformanceMessage(
                title: board.isPaid ? 'No trades' : 'No trades to preview yet',
                body: state.filter != null
                    ? 'Nothing was traded in the months you picked.'
                    : board.isPaid
                    ? 'No trades have been added yet.'
                    : 'Subscribe to see every trade.',
              )
            else
              TradeList(
                title: board.communityName.isEmpty
                    ? 'Trades'
                    : '${board.communityName} Dashboard',
                trades: state.items,
                hasMore: state.hasMore,
                subtitle: board.isPaid
                    ? null
                    : UnlockCopy.of(
                        board,
                        shown: state.items.length,
                      ).listSubtitle,
              ),
            if (state.isLoadingMore)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(child: CircularProgressIndicator()),
              ),
            // Counts the hidden trades in the picked months (or on the whole
            // segment with no filter), and shows even when the list is empty:
            // a free member who picks an old month sees none and a banner.
            if (!board.isPaid && (board.hiddenCount ?? 0) > 0) ...[
              const SizedBox(height: 14),
              UnlockSection(
                copy: UnlockCopy.of(board, shown: state.items.length),
                // The plans are on the community's own card in the list this
                // screen was opened from.
                onTap: () => context.pop(),
              ),
            ],
          ],
        );
      },
    );
  }
}
