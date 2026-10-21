import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finskool/src/domain/model/ticket/ticket_model.dart';
import 'package:finskool/src/presentation/bloc/tickets/list/tickets_list_bloc.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_button.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'ticket_filter_chips.dart';
import 'ticket_list_card.dart';

/// The chips, the cards, the "Raise a new ticket" button and its footnote, in
/// one pull-to-refresh scroll. Figma's gaps: 19 under the chips, 12 between
/// cards, 19 above the button, 9 between the button and the footnote.
class TicketsListBody extends StatelessWidget {
  const TicketsListBody({
    super.key,
    required this.state,
    required this.onOpenTicket,
    required this.onRaise,
  });

  final TicketsListState state;
  final ValueChanged<TicketModel> onOpenTicket;
  final VoidCallback onRaise;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TicketsListBloc>();
    final tickets = state.visible;

    return RefreshIndicator(
      onRefresh: () async {
        bloc.add(const TicketsListEvent.refresh());
        await bloc.stream.firstWhere((s) => !s.state.isLoading);
      },
      child: NotificationListener<ScrollNotification>(
        // `extentAfter` is already `max - pixels` and never negative, so a
        // list shorter than the viewport reports 0 and can't be mistaken for
        // "at the bottom" the way `maxScrollExtent - 600` was on the feed.
        onNotification: (n) {
          if (n.metrics.extentAfter < 300 && n.metrics.maxScrollExtent > 0) {
            bloc.add(const TicketsListEvent.loadMore());
          }
          return false;
        },
        child: ListView(
          padding: EdgeInsets.fromLTRB(
            20,
            0,
            20,
            24 + MediaQuery.paddingOf(context).bottom,
          ),
          children: [
            TicketFilterChips(
              state: state,
              onSelect: (s) => bloc.add(TicketsListEvent.filterChanged(s)),
            ),
            const SizedBox(height: 19),
            for (final t in tickets) ...[
              TicketListCard(ticket: t, onTap: () => onOpenTicket(t)),
              const SizedBox(height: 12),
            ],
            if (state.isLoadingMore)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Center(child: CircularProgressIndicator()),
              ),
            const SizedBox(height: 7),
            TicketButton(label: 'Raise a new ticket', onTap: onRaise),
            const SizedBox(height: 9),
            // Figma: "You will be notified here and by email when support
            // replies." The API sends **no** email for replies (§10), so only
            // the true half is kept — same call as the form's footnote.
            Text(
              'You will be notified here when support replies.',
              textAlign: TextAlign.center,
              style: context.ticketType.footnote,
            ),
          ],
        ),
      ),
    );
  }
}
