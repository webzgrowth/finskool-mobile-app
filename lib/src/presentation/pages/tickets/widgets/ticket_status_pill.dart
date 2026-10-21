import 'package:flutter/material.dart';
import 'package:finskool/src/domain/model/ticket/ticket_enums.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// Figma's `Status / Open | In progress | Resolved`: a 21px pill, a 6px dot and
/// a label in the same colour.
///
/// Padding is 4/10/4/8 — **8 on the left, where the dot sits, and 10 on the
/// right** — which is why this isn't a symmetric `Chip`.
class TicketStatusPill extends StatelessWidget {
  const TicketStatusPill({super.key, required this.status});

  final TicketStatus status;

  @override
  Widget build(BuildContext context) {
    final (surface, ink) = switch (status) {
      TicketStatus.open => (AppPalette.ticketOpenSurface, AppPalette.ticketRed),
      TicketStatus.inProgress => (
        AppPalette.ticketProgressSurface,
        AppPalette.ticketProgressInk,
      ),
      TicketStatus.resolved => (
        AppPalette.ticketResolvedSurface,
        AppPalette.ticketResolvedInk,
      ),
    };
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 4, 10, 4),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 6,
            width: 6,
            decoration: BoxDecoration(color: ink, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            status.label,
            style: context.ticketType.statusPill.copyWith(color: ink),
          ),
        ],
      ),
    );
  }
}
