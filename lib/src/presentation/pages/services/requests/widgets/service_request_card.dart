import 'package:flutter/material.dart';
import 'package:finskool/src/comman/ist_time.dart';
import 'package:finskool/src/domain/model/service/service_request_model.dart';
import 'package:finskool/src/presentation/pages/services/widgets/service_status_pill.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_card.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_chevron.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// One row of My requests — the My Tickets card with a service's number,
/// title and status. An unread reply or a ready quote gets the mint banner.
class ServiceRequestCard extends StatelessWidget {
  const ServiceRequestCard({
    super.key,
    required this.request,
    required this.onTap,
  });

  final ServiceRequestModel request;
  final VoidCallback onTap;

  String get _banner => request.status == ServiceStatus.quoteSent
      ? 'Your quote is ready'
      : 'New reply from support';

  @override
  Widget build(BuildContext context) {
    final type = context.ticketType;
    final attention =
        request.unreadCount > 0 || request.status == ServiceStatus.quoteSent;
    return TicketCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text('#${request.label}', style: type.ticketNumber),
              ),
              ServiceStatusPill(request: request),
            ],
          ),
          const SizedBox(height: 10),
          Text(request.serviceTitle, style: type.cardSubject),
          if (attention && !request.isClosed) ...[
            const SizedBox(height: 10),
            Container(
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
                  Text(_banner, style: type.newReply),
                ],
              ),
            ),
          ],
          const SizedBox(height: 10),
          Container(height: 1, color: AppPalette.ticketDivider),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Updated ${formatIst(request.lastMessageAt, 'dd MMM yyyy')}',
                  style: type.meta,
                ),
              ),
              const TicketChevron(pointsRight: true),
            ],
          ),
        ],
      ),
    );
  }
}
