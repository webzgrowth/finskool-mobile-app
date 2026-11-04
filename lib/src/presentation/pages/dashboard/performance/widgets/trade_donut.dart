import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// Figma `Donut` (`1554:6563`): a 96px ring — profit in green clockwise from
/// 12 o'clock, then loss in red — with the trade count at its centre. Drawn
/// rather than composed from images so the split follows the data.
///
/// Both shares are the server's, and they can add up to less than 1: a trade
/// that closed flat is neither, so whatever is left stays a neutral track
/// instead of being painted as a loss that didn't happen.
class TradeDonut extends StatelessWidget {
  const TradeDonut({
    super.key,
    required this.total,
    required this.profitShare,
    required this.lossShare,
  });

  final int total;
  final double profitShare;
  final double lossShare;

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
            painter: _RingPainter(profitShare, lossShare),
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
  _RingPainter(this.profitShare, this.lossShare);

  final double profitShare;
  final double lossShare;

  static const double _stroke = 10;
  // A hair of white between the arcs, as in the design.
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
    final profit = profitShare.clamp(0.0, 1.0);
    final loss = lossShare.clamp(0.0, 1.0 - profit);

    // The track shows through wherever neither arc is drawn (flat trades, or
    // a board with no trades yet).
    canvas.drawArc(rect, start, full, false, paint(AppPalette.perfTrack));

    void arc(double from, double share, Color color) {
      if (share <= 0) return;
      // A single full-circle arc has no neighbour to leave a gap beside.
      final whole = share >= 0.999;
      canvas.drawArc(
        rect,
        start + full * from + (whole ? 0 : _gap / 2),
        full * share - (whole ? 0 : _gap),
        false,
        paint(color),
      );
    }

    arc(0, profit, AppPalette.perfProfit);
    arc(profit, loss, AppPalette.ticketRed);
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.profitShare != profitShare || old.lossShare != lossShare;
}
