import 'package:flutter/material.dart';
import 'package:finskool/src/domain/model/performance/performance_trade.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import '../performance_format.dart';
import 'trade_details.dart';
import 'trade_row.dart';

/// An intraday trade: net P&L and return on the right; entry, exit, P/L,
/// P&L, charges and net P&L when opened.
class IntradayTradeTile extends StatelessWidget {
  const IntradayTradeTile({
    super.key,
    required this.trade,
    required this.number,
    this.initiallyOpen = false,
  });

  final IntradayTrade trade;

  /// 1-based position in the list — the API sends no serial number.
  final int number;
  final bool initiallyOpen;

  @override
  Widget build(BuildContext context) {
    final t = trade;
    final type = context.performanceType;
    final color = pnlColor(t.netPnl);
    return TradeRow(
      name: t.name,
      initials: t.initials,
      logoUrl: t.logoUrl,
      meta:
          '#${number.toString().padLeft(2, '0')}  ·  '
          '${formatTradeDate(t.tradeDate)}',
      tag: _SideTag(side: t.side),
      initiallyOpen: initiallyOpen,
      result: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            formatAmount(t.netPnl),
            style: type.result.copyWith(color: color),
          ),
          Text(
            formatPct(t.plPct),
            style: type.resultPct.copyWith(color: color),
          ),
        ],
      ),
      details: TradeDetailsGrid(
        rows: [
          [
            DetailCell('Entry', formatPrice(t.entryPrice)),
            DetailCell('Exit', formatPrice(t.exitPrice)),
            DetailCell(
              'P/L',
              formatPrice(t.plPerShare),
              pnlColor(t.plPerShare),
            ),
          ],
          [
            DetailCell('P&L', formatAmount(t.grossPnl), pnlColor(t.grossPnl)),
            // Charges are a positive cost on the wire; shown as a deduction.
            DetailCell(
              'Charges',
              formatAmount(-t.charges),
              AppPalette.perfMuted,
            ),
            DetailCell('Net P&L', formatAmount(t.netPnl), color),
          ],
        ],
      ),
    );
  }
}

class _SideTag extends StatelessWidget {
  const _SideTag({required this.side});

  final TradeSide side;

  @override
  Widget build(BuildContext context) {
    final buy = side == TradeSide.buy;
    final style = context.performanceType.tag;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: buy ? AppPalette.infoVerifiedPlate : AppPalette.perfSellPlate,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        buy ? 'Buy' : 'Sell',
        style: style.copyWith(
          color: buy ? AppPalette.badgeTeal : AppPalette.warning,
        ),
      ),
    );
  }
}
