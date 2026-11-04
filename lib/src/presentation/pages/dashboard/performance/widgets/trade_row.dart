import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'stock_logo.dart';

/// A trade in the list: logo, name, a meta line and a result on the right,
/// tapping to open [details]. The intraday and swing rows differ only in what
/// they put in each slot, so the chrome — and its open/close animation — lives
/// here once.
class TradeRow extends StatefulWidget {
  const TradeRow({
    super.key,
    required this.name,
    required this.initials,
    required this.meta,
    required this.result,
    required this.details,
    this.logoUrl,
    this.tag,
    this.initiallyOpen = false,
  });

  final String name;
  final String initials;

  /// "#01 · 24 Aug 2026".
  final String meta;

  /// The right-hand column (amounts, or the Target Met badge).
  final Widget result;
  final Widget details;

  /// The stock's logo URL, or null for initials.
  final String? logoUrl;

  /// A small pill after the meta line (Buy / Sell).
  final Widget? tag;
  final bool initiallyOpen;

  @override
  State<TradeRow> createState() => _TradeRowState();
}

class _TradeRowState extends State<TradeRow> {
  late bool _open = widget.initiallyOpen;

  @override
  Widget build(BuildContext context) {
    final type = context.performanceType;
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
                  StockLogo(
                    stock: widget.name,
                    initials: widget.initials,
                    logoUrl: widget.logoUrl,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: type.stock,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                widget.meta,
                                style: type.meta,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (widget.tag != null) ...[
                              const SizedBox(width: 8),
                              widget.tag!,
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  widget.result,
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
                        child: widget.details,
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
