import 'package:flutter/material.dart';
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
    this.subtitle,
  });

  final String title;
  final List<PerformanceTrade> trades;

  /// More pages exist, so the count is "N+".
  final bool hasMore;

  /// A free member's line under the title ("Past trades"); it replaces the
  /// count pill, which a paid member sees.
  final String? subtitle;

  String get _count => '${trades.length}${hasMore ? '+' : ''} trades';

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
                      number: i + 1,
                      initiallyOpen: i == 0 && subtitle == null,
                    ),
                    final SwingTrade t => SwingTradeTile(
                      key: ValueKey(t.id),
                      trade: t,
                      number: i + 1,
                      initiallyOpen: i == 0 && subtitle == null,
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
