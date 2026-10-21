import 'package:flutter/material.dart';

/// A rounded rectangle with a dashed stroke — the upload box's border.
///
/// Figma draws it dashed, but the node data carries no dash pattern, so the
/// 3.5-on / 3.5-off rhythm is measured off the render (7px runs at 2x). Done with `PathMetrics` rather
/// than a package: it is one small painter.
class DashedBorder extends StatelessWidget {
  const DashedBorder({
    super.key,
    required this.child,
    required this.color,
    this.radius = 8,
    this.dash = 3.5,
    this.gap = 3.5,
    this.fill,
  });

  final Widget child;
  final Color color;
  final double radius;
  final double dash;
  final double gap;
  final Color? fill;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedPainter(color, radius, dash, gap, fill),
      child: child,
    );
  }
}

class _DashedPainter extends CustomPainter {
  _DashedPainter(this.color, this.radius, this.dash, this.gap, this.fill);

  final Color color;
  final double radius;
  final double dash;
  final double gap;
  final Color? fill;

  @override
  void paint(Canvas canvas, Size size) {
    // Inset half a stroke so the line sits inside the box, like a border.
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    ).deflate(0.5);
    if (fill != null) canvas.drawRRect(rrect, Paint()..color = fill!);

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    for (final metric in (Path()..addRRect(rrect)).computeMetrics()) {
      for (var d = 0.0; d < metric.length; d += dash + gap) {
        canvas.drawPath(metric.extractPath(d, d + dash), paint);
      }
    }
  }

  @override
  bool shouldRepaint(_DashedPainter old) =>
      old.color != color || old.radius != radius || old.fill != fill;
}
