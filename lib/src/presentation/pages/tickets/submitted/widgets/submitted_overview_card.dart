import 'package:flutter/material.dart';
import 'package:finskool/src/comman/ist_time.dart';
import 'package:finskool/src/domain/model/ticket/ticket_enums.dart';
import 'package:finskool/src/domain/model/ticket/ticket_model.dart';
import 'package:finskool/src/comman/widgets/teal_section_card.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_status_pill.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// "Ticket Overview": number + status, subject, a hairline, then four
/// label/value rows on a 27px pitch.
class SubmittedOverviewCard extends StatelessWidget {
  const SubmittedOverviewCard({super.key, required this.ticket});

  final TicketModel ticket;

  @override
  Widget build(BuildContext context) {
    final type = context.ticketType;
    final files = ticket.attachments.length;
    return TealSectionCard(
      title: 'Ticket Overview',
      padding: const EdgeInsets.fromLTRB(17, 15, 17, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text('#${ticket.label}', style: type.summaryNumber),
              ),
              TicketStatusPill(status: ticket.status),
            ],
          ),
          const SizedBox(height: 15),
          Text(ticket.subject, style: type.summarySubject),
          const SizedBox(height: 12.5),
          Container(height: 1, color: AppPalette.ticketDivider),
          const SizedBox(height: 5.5),
          _Row('Category', ticket.category?.label ?? '—'),
          _Row('Subscription', ticket.communityName),
          _Row('Raised on', formatIst(ticket.createdAt, 'dd MMM yyyy, h:mm a')),
          _Row(
            'Attachments',
            files == 0 ? 'None' : '$files ${files == 1 ? 'file' : 'files'}',
          ),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final type = context.ticketType;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: type.summaryLabel),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: type.summaryValue,
            ),
          ),
        ],
      ),
    );
  }
}
