import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// The ✕ on the status popover and the rating card: a 10px cross, drawn.
///
/// Painted rather than typed: Inter has no ✕ glyph, so a `Text('✕')` falls
/// back to a different font on each platform. The tap target is 44.
class TicketCloseButton extends StatelessWidget {
  const TicketCloseButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Close',
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: const SizedBox(
          height: 44,
          width: 44,
          child: CustomPaint(painter: _CrossPainter()),
        ),
      ),
    );
  }
}

class _CrossPainter extends CustomPainter {
  const _CrossPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    final paint = Paint()
      ..color = AppPalette.ticketInk
      ..strokeWidth = 1.1
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(c + const Offset(-3, -3), c + const Offset(3, 3), paint);
    canvas.drawLine(c + const Offset(-3, 3), c + const Offset(3, -3), paint);
  }

  @override
  bool shouldRepaint(_CrossPainter old) => false;
}
