import 'package:flutter/material.dart';
import 'package:finskool/src/domain/model/service/service_request_model.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// How a request's status reads to the member, with the ticket pill's tokens
/// so it matches the rest of the support surfaces.
extension ServiceRequestView on ServiceRequestModel {
  String get statusLabel => switch (status) {
    ServiceStatus.requested => 'Awaiting quote',
    ServiceStatus.quoteSent => 'Quote ready',
    ServiceStatus.paid => 'Paid',
    ServiceStatus.closed => switch (closedReason) {
      ServiceClosedReason.completed => 'Completed',
      ServiceClosedReason.declined => 'Declined',
      ServiceClosedReason.cancelledByMember => 'Cancelled',
      null => 'Closed',
    },
  };

  (Color, Color) get statusColors => switch (status) {
    ServiceStatus.requested => (
      AppPalette.ticketProgressSurface,
      AppPalette.ticketProgressInk,
    ),
    // Needs the member's attention, so it takes the "open" red.
    ServiceStatus.quoteSent => (
      AppPalette.ticketOpenSurface,
      AppPalette.ticketRed,
    ),
    ServiceStatus.paid => (
      AppPalette.ticketResolvedSurface,
      AppPalette.ticketResolvedInk,
    ),
    ServiceStatus.closed =>
      isCompleted
          ? (AppPalette.ticketResolvedSurface, AppPalette.ticketResolvedInk)
          : (AppPalette.ticketSystemSurface, AppPalette.ticketProgressInk),
  };
}

/// The 21px dot-and-label pill — same shape as `TicketStatusPill`.
class ServiceStatusPill extends StatelessWidget {
  const ServiceStatusPill({super.key, required this.request});

  final ServiceRequestModel request;

  @override
  Widget build(BuildContext context) {
    final (surface, ink) = request.statusColors;
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
            request.statusLabel,
            style: context.ticketType.statusPill.copyWith(color: ink),
          ),
        ],
      ),
    );
  }
}
