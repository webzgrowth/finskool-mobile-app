import 'package:flutter/material.dart';
import 'package:finskool/src/domain/model/ticket/ticket_enums.dart';
import 'package:finskool/src/domain/model/ticket/ticket_model.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_close_button.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_status_pill.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'status_stepper.dart';

/// The card the Status button opens: number + pill, subject, "Category ·
/// Community", a hairline and the [StatusStepper]. Figma floats it at (21, 57)
/// — over the status-bar band — 335 wide, with a ✕ at its top-right.
///
/// A tap outside dismisses it too; the design draws no scrim, so the page
/// behind is left untouched.
class StatusPopover extends StatelessWidget {
  const StatusPopover({super.key, required this.ticket, required this.onClose});

  final TicketModel ticket;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final type = context.ticketType;
    final top = MediaQuery.paddingOf(context).top + 13;
    return Positioned.fill(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onClose,
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: top, left: 21, right: 20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 335),
              // Swallows taps so touching the card doesn't dismiss it.
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    color: AppPalette.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppPalette.ticketCardBorder),
                    boxShadow: const [
                      BoxShadow(
                        color: AppPalette.ticketShadow,
                        blurRadius: 24,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 37, 16, 28),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '#${ticket.label}',
                                    style: type.ticketNumber,
                                  ),
                                ),
                                TicketStatusPill(status: ticket.status),
                              ],
                            ),
                            const SizedBox(height: 11),
                            Text(ticket.subject, style: type.summarySubject),
                            const SizedBox(height: 12),
                            Text(
                              '${ticket.category?.label ?? 'Ticket'}  ·  '
                              '${ticket.communityName}',
                              style: type.detailMeta,
                            ),
                            const SizedBox(height: 12),
                            Container(
                              height: 1,
                              color: AppPalette.ticketDivider,
                            ),
                            const SizedBox(height: 12.5),
                            StatusStepper(ticket: ticket),
                          ],
                        ),
                      ),
                      Positioned(
                        top: -7,
                        right: -2,
                        child: TicketCloseButton(onTap: onClose),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
