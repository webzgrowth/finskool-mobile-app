import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/domain/model/performance/performance_trade.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import '../performance_format.dart';
import 'stock_logo.dart';
import 'trade_details.dart';

/// One trade row (Figma `Trade / n`): logo, name, "#01 · date" with a Buy/Sell
/// tag, the result and a chevron. Tapping opens the details panel. Expansion
/// is local `State` — transient UI, not app state (CLAUDE.md "Not everything
/// is a bloc").
class TradeTile extends StatefulWidget {
  const TradeTile({super.key, required this.trade, this.initiallyOpen = false});

  final PerformanceTrade trade;
  final bool initiallyOpen;

  @override
  State<TradeTile> createState() => _TradeTileState();
}

class _TradeTileState extends State<TradeTile> {
  late bool _open = widget.initiallyOpen;

  @override
  Widget build(BuildContext context) {
    final t = widget.trade;
    final type = context.performanceType;
    final color = pnlColor(t.netPnl);
    final number = t.number.toString().padLeft(2, '0');

    return Semantics(
      button: true,
      expanded: _open,
      child: InkWell(
        onTap: () => setState(() => _open = !_open),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Column(
            children: [
              Row(
                children: [
                  StockLogo(stock: t.stock, initials: t.initials),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.stock,
                          style: type.stock,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                '#$number  ·  ${formatTradeDate(t.date)}',
                                style: type.meta,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            _SideTag(side: t.side),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        formatAmount(t.netPnl),
                        style: type.result.copyWith(color: color),
                      ),
                      Text(
                        '${t.returnPct.toStringAsFixed(2)}%',
                        style: type.resultPct.copyWith(color: color),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  AnimatedRotation(
                    turns: _open ? 0 : 0.5,
                    duration: const Duration(milliseconds: 180),
                    child: SvgPicture.asset(
                      'assets/icons/perf_chevron.svg',
                      width: 12,
                    ),
                  ),
                ],
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOut,
                alignment: Alignment.topCenter,
                child: _open
                    ? Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: TradeDetails(trade: t),
                      )
                    : const SizedBox(width: double.infinity),
              ),
            ],
          ),
        ),
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
