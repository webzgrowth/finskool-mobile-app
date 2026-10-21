import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/domain/model/ticket/ticket_model.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_button.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_header.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_sheet_page.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'widgets/submitted_badge.dart';
import 'widgets/submitted_overview_card.dart';
import 'widgets/what_happens_next.dart';

/// Ticket submitted.
///
/// It **pops with a result** rather than navigating: `true` means "View
/// ticket", anything else (the back arrow) means back to the list. My
/// Tickets owns the chain (raise → this → ticket), because replacing a route
/// would orphan the future the list is awaiting.
class TicketSubmittedScreen extends StatelessWidget {
  const TicketSubmittedScreen({super.key, required this.ticket});

  final TicketModel ticket;

  @override
  Widget build(BuildContext context) {
    final type = context.ticketType;
    return TicketSheetPage(
      header: TicketHeader(
        spec: TicketHeaderSpec.submitted,
        onBack: () => context.pop(false),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          20,
          0,
          20,
          24 + MediaQuery.paddingOf(context).bottom,
        ),
        children: [
          const Center(child: SubmittedBadge()),
          const SizedBox(height: 8),
          Text(
            'Ticket submitted',
            textAlign: TextAlign.center,
            style: type.successTitle,
          ),
          const SizedBox(height: 2),
          Text(
            'Your query has reached the support team',
            textAlign: TextAlign.center,
            style: type.successSubtitle,
          ),
          const SizedBox(height: 24),
          SubmittedOverviewCard(ticket: ticket),
          const SizedBox(height: 14),
          const WhatHappensNext(),
          const SizedBox(height: 14),
          TicketButton(label: 'View ticket', onTap: () => context.pop(true)),
        ],
      ),
    );
  }
}
