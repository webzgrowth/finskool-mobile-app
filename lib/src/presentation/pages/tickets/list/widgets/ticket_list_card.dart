import 'package:flutter/material.dart';
import 'package:finskool/src/comman/ist_time.dart';
import 'package:finskool/src/domain/model/ticket/ticket_enums.dart';
import 'package:finskool/src/domain/model/ticket/ticket_model.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_card.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_chevron.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_status_pill.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// One row of My Tickets. Every gap inside is 10: number row → subject →
/// optional reply banner → divider → meta.
///
/// The subject is **Manrope** SemiBold here (and Inter on the summary card) —
/// the design differs between the two.
class TicketListCard extends StatelessWidget {
  const TicketListCard({super.key, required this.ticket, required this.onTap});

  final TicketModel ticket;
  final VoidCallback onTap;

  /// "Billing  ·  Raised 05 Oct 2026". The verb follows the status — raised,
  /// updated or closed — and the date is the matching one, shown in IST.
  String get _meta {
    final (verb, at) = switch (ticket.status) {
      TicketStatus.open => ('Raised', ticket.createdAt),
      TicketStatus.inProgress => ('Updated', ticket.lastMessageAt),
      TicketStatus.resolved => (
        'Closed',
        ticket.resolvedAt ?? ticket.lastMessageAt,
      ),
    };
    final category = ticket.category?.shortLabel ?? 'Ticket';
    return '$category  ·  $verb ${formatIst(at, 'dd MMM yyyy')}';
  }

  @override
  Widget build(BuildContext context) {
    final type = context.ticketType;
    return TicketCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text('#${ticket.label}', style: type.ticketNumber),
              ),
              TicketStatusPill(status: ticket.status),
            ],
          ),
          const SizedBox(height: 10),
          Text(ticket.subject, style: type.cardSubject),
          if (ticket.unreadCount > 0) ...[
            const SizedBox(height: 10),
            const _NewReply(),
          ],
          const SizedBox(height: 10),
          Container(height: 1, color: AppPalette.ticketDivider),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: Text(_meta, style: type.meta)),
              const TicketChevron(pointsRight: true),
            ],
          ),
        ],
      ),
    );
  }
}

/// "New reply from support": mint plate, a `#108B8B` hairline and dot.
class _NewReply extends StatelessWidget {
  const _NewReply();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppPalette.ticketTile,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppPalette.badgeTeal),
      ),
      child: Row(
        children: [
          Container(
            height: 6,
            width: 6,
            decoration: const BoxDecoration(
              color: AppPalette.badgeTeal,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text('New reply from support', style: context.ticketType.newReply),
        ],
      ),
    );
  }
}
