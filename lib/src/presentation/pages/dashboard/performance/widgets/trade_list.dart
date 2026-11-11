import 'package:flutter/material.dart';
import 'package:finskool/src/domain/model/performance/performance_kind.dart';
import 'package:finskool/src/domain/model/performance/performance_trade.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'perf_card.dart';
import 'swing_trade_tile.dart';
import 'trade_tile.dart';

/// The trades a member can see: a title with a count pill, then the rows.
/// Intraday and swing rows differ; the list itself does not.
class TradeList extends StatelessWidget {
  const TradeList({
    super.key,
    required this.title,
    required this.trades,
    required this.hasMore,
    this.totalTrades,
    this.subtitle,
    this.segment = PerformanceSegment.main,
  });

  final String title;
  final List<PerformanceTrade> trades;

  /// More pages exist, so the count is "N+".
  final bool hasMore;

  /// The segment's total trade count, which makes the **admin's S.N.**
  /// possible: the admin counts oldest first, the list is newest first, so the
  /// first row is `totalTrades` and each next one is one less. Null (a free
  /// member, whose list is a hand-picked subset, so a row's place in the whole
  /// can't be known) shows no number rather than a wrong one.
  final int? totalTrades;

  /// A free member's line under the title ("Past trades"); it replaces the
  /// count pill, which a paid member sees.
  final String? subtitle;

  /// The investor board's tab (see `SwingTradeTile.segment`).
  final PerformanceSegment segment;

  /// The real count: the summary's `totalTrades` (the segment's, or the picked
  /// months') — not the rows loaded so far, which read "20+" until every page
  /// had arrived. Only when no total is known does it fall back to the loaded
  /// rows, with a "+" while more pages remain.
  String get _count {
    final total = totalTrades;
    final n = total != null && total >= trades.length ? total : trades.length;
    final more = total == null && hasMore ? '+' : '';
    return '$n$more ${n == 1 && more.isEmpty ? 'trade' : 'trades'}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 10, 4, 0),
          child: subtitle == null
              ? _PaidHeader(title: title, count: _count)
              : _FreeHeader(title: title, subtitle: subtitle!),
        ),
        const SizedBox(height: 14),
        if (trades.isNotEmpty)
          PerfCard(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
            child: Column(
              children: [
                for (var i = 0; i < trades.length; i++) ...[
                  if (i > 0)
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: AppPalette.perfRowRule,
                    ),
                  switch (trades[i]) {
                    final IntradayTrade t => IntradayTradeTile(
                      key: ValueKey(t.id),
                      trade: t,
                      number: serialFor(i, trades.length, totalTrades),
                      initiallyOpen: i == 0 && subtitle == null,
                    ),
                    final SwingTrade t => SwingTradeTile(
                      key: ValueKey(t.id),
                      trade: t,
                      number: serialFor(i, trades.length, totalTrades),
                      initiallyOpen: i == 0 && subtitle == null,
                      segment: segment,
                    ),
                  },
                ],
              ],
            ),
          ),
      ],
    );
  }
}

/// The admin's S.N. for row [index] of [loaded] newest-first rows, given the
/// segment's [total]: `total - index`. Null when [total] is unknown or smaller
/// than the rows already loaded (the list and the count disagree — number
/// nothing rather than something wrong).
int? serialFor(int index, int loaded, int? total) {
  if (total == null || total < loaded) return null;
  return total - index;
}

class _PaidHeader extends StatelessWidget {
  const _PaidHeader({required this.title, required this.count});

  final String title;
  final String count;

  @override
  Widget build(BuildContext context) {
    final type = context.performanceType;
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: type.listTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
          decoration: BoxDecoration(
            color: AppPalette.perfCountPill,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(count, style: type.count),
        ),
      ],
    );
  }
}

/// Free members: the title over a quiet line, no pill (Figma `List header`).
class _FreeHeader extends StatelessWidget {
  const _FreeHeader({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final type = context.performanceType;
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: type.listTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(subtitle, style: type.meta),
        ],
      ),
    );
  }
}
