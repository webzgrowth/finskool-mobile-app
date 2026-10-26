import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// Figma `Donut` (`1554:6563`): a 96px ring — profit in green clockwise from
/// 12 o'clock, loss in red for the rest — with the trade count at its centre.
/// Drawn rather than composed from images so the split follows the data.
class TradeDonut extends StatelessWidget {
  const TradeDonut({super.key, required this.total, required this.profitShare});

  final int total;
  final double profitShare;

  static const double size = 96;

  @override
  Widget build(BuildContext context) {
    final type = context.performanceType;
    return SizedBox(
      height: size,
      width: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size.square(size),
            painter: _RingPainter(profitShare),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('$total', style: type.donutValue),
              Text('Total Trades', style: type.donutCaption),
            ],
          ),
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter(this.profitShare);

  final double profitShare;

  static const double _stroke = 10;
  // A hair of white between the two arcs, as in the design.
  static const double _gap = 0.05;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = (Offset.zero & size).deflate(_stroke / 2);
    Paint paint(Color c) => Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = _stroke
      ..color = c;

    const full = math.pi * 2;
    const start = -math.pi / 2;
    final loss = 1 - profitShare;
    if (profitShare <= 0 || loss <= 0) {
      canvas.drawArc(
        rect,
        start,
        full,
        false,
        paint(profitShare > 0 ? AppPalette.perfProfit : AppPalette.ticketRed),
      );
      return;
    }
    final profitSweep = full * profitShare;
    canvas.drawArc(
      rect,
      start + _gap / 2,
      profitSweep - _gap,
      false,
      paint(AppPalette.perfProfit),
    );
    canvas.drawArc(
      rect,
      start + profitSweep + _gap / 2,
      full * loss - _gap,
      false,
      paint(AppPalette.ticketRed),
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) => old.profitShare != profitShare;
}
