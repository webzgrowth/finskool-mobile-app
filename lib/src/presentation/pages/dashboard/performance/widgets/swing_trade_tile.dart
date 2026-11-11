import 'package:flutter/material.dart';
import 'package:finskool/src/domain/model/performance/performance_trade.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import '../performance_format.dart';
import 'trade_details.dart';
import 'trade_row.dart';

/// A swing / investor trade. On the right: a **Target Met** badge once the
/// trade has an exit date, otherwise the return so far (a dash when unknown).
class SwingTradeTile extends StatelessWidget {
  const SwingTradeTile({
    super.key,
    required this.trade,
    required this.number,
    this.initiallyOpen = false,
  });

  final SwingTrade trade;
  final int? number;
  final bool initiallyOpen;

  @override
  Widget build(BuildContext context) {
    final t = trade;
    final type = context.performanceType;
    final code = t.symbol == null || t.symbol!.isEmpty
        ? ''
        : '${t.symbol}  ·  ';
    return TradeRow(
      name: t.name,
      initials: t.initials,
      logoUrl: t.logoUrl,
      meta: '${serialLead(number)}$code${formatTradeDate(t.tradeDate)}',
      initiallyOpen: initiallyOpen,
      result: t.targetMet
          ? const _TargetMetBadge()
          : Text(
              t.returnPct == null ? '—' : formatSignedPct(t.returnPct!),
              style: type.result.copyWith(
                color: t.returnPct == null
                    ? AppPalette.perfMuted
                    : pnlColor(t.returnPct!),
              ),
            ),
      details: TradeDetailsGrid(
        rows: [
          [
            DetailCell('Entry', formatPrice(t.entryPrice)),
            // As of the admin's last upload, not live.
            DetailCell('CMP', t.cmp == null ? '—' : formatPrice(t.cmp!)),
            DetailCell(
              'Target',
              t.targetPct == null ? '—' : '${t.targetPct!.toStringAsFixed(0)}%',
            ),
          ],
          [
            DetailCell(
              'Target Price',
              t.targetPrice == null ? '—' : formatPrice(t.targetPrice!),
            ),
            DetailCell(
              'Exit Date',
              t.exitDate == null ? 'Open' : formatTradeDate(t.exitDate!),
            ),
            DetailCell(
              'Holding Days',
              t.holdingDays == null ? '—' : '${t.holdingDays}',
            ),
          ],
          if (t.analysis != null) [DetailCell('Analysis', t.analysis!)],
        ],
      ),
    );
  }
}

class _TargetMetBadge extends StatelessWidget {
  const _TargetMetBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppPalette.infoVerifiedPlate,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        'Target Met',
        style: context.performanceType.tag.copyWith(
          color: AppPalette.perfProfit,
        ),
      ),
    );
  }
}
