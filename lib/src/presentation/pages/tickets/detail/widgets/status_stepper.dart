import 'package:flutter/material.dart';
import 'package:finskool/src/comman/ist_time.dart';
import 'package:finskool/src/domain/model/ticket/ticket_enums.dart';
import 'package:finskool/src/domain/model/ticket/ticket_model.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

enum _StepState { done, current, pending }

/// Raised — In progress — Resolved.
///
/// Each column hugs its label with the 20px disc centred over it; the 2px
/// connectors fill the space between, inset 7 / 6 from the columns (measured
/// off Figma's render).
///
/// **The middle date is blank**: the API keeps no status history (§10), so
/// "In progress — 05 Oct" has no source and isn't invented. Raised and
/// Resolved come from `createdAt` / `resolvedAt`.
class StatusStepper extends StatelessWidget {
  const StatusStepper({super.key, required this.ticket});

  final TicketModel ticket;

  _StepState _state(int step) {
    final reached = switch (ticket.status) {
      TicketStatus.open => 0,
      TicketStatus.inProgress => 1,
      TicketStatus.resolved => 2,
    };
    if (step < reached || (step == 2 && reached == 2)) return _StepState.done;
    return step == reached ? _StepState.current : _StepState.pending;
  }

  String? _date(int step) => switch (step) {
    0 => formatIst(ticket.createdAt, 'dd MMM'),
    2 when ticket.resolvedAt != null => formatIst(ticket.resolvedAt!, 'dd MMM'),
    _ => null,
  };

  @override
  Widget build(BuildContext context) {
    const labels = ['Raised', 'In progress', 'Resolved'];
    final children = <Widget>[];
    for (var i = 0; i < 3; i++) {
      if (i > 0) {
        children.add(const SizedBox(width: 7));
        children.add(
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 9),
              child: Container(
                height: 2,
                color: _state(i) == _StepState.pending
                    ? AppPalette.ticketPendingLine
                    : AppPalette.badgeTeal,
              ),
            ),
          ),
        );
        children.add(const SizedBox(width: 6));
      }
      children.add(_Step(label: labels[i], state: _state(i), date: _date(i)));
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}

class _Step extends StatelessWidget {
  const _Step({required this.label, required this.state, required this.date});

  final String label;
  final _StepState state;
  final String? date;

  @override
  Widget build(BuildContext context) {
    final type = context.ticketType;
    final pending = state == _StepState.pending;
    return Column(
      children: [
        _Disc(state),
        const SizedBox(height: 3.5),
        Text(label, style: pending ? type.stepPending : type.stepTitle),
        const SizedBox(height: 5),
        if (pending)
          Text('•Pending', style: type.pendingRed)
        else
          Text(date ?? '', style: type.stepDate),
      ],
    );
  }
}

class _Disc extends StatelessWidget {
  const _Disc(this.state);

  final _StepState state;

  @override
  Widget build(BuildContext context) {
    const size = 20.0;
    return switch (state) {
      _StepState.done => Container(
        height: size,
        width: size,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AppPalette.badgeTeal,
          shape: BoxShape.circle,
        ),
        child: const CustomPaint(size: Size(10, 10), painter: _CheckPainter()),
      ),
      _StepState.current => Container(
        height: size,
        width: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppPalette.white,
          shape: BoxShape.circle,
          border: Border.all(color: AppPalette.badgeTeal, width: 2),
        ),
        child: Container(
          height: 8,
          width: 8,
          decoration: const BoxDecoration(
            color: AppPalette.badgeTeal,
            shape: BoxShape.circle,
          ),
        ),
      ),
      _StepState.pending => Container(
        height: size,
        width: size,
        decoration: const BoxDecoration(
          color: AppPalette.ticketPending,
          shape: BoxShape.circle,
        ),
      ),
    };
  }
}

/// The tick inside a done step: drawn, so it renders identically everywhere
/// (a Material icon needs its font bundled, which the golden tests lack).
class _CheckPainter extends CustomPainter {
  const _CheckPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppPalette.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.12, size.height * 0.55)
        ..lineTo(size.width * 0.4, size.height * 0.82)
        ..lineTo(size.width * 0.88, size.height * 0.22),
      paint,
    );
  }

  @override
  bool shouldRepaint(_CheckPainter old) => false;
}
