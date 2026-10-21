import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/injections/injection.dart';
import 'package:finskool/src/comman/routes.dart';
import 'package:finskool/src/domain/model/ticket/ticket_model.dart';
import 'package:finskool/src/presentation/bloc/tickets/list/tickets_list_bloc.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_header.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_sheet_page.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'widgets/tickets_empty_view.dart';
import 'widgets/tickets_list_body.dart';

/// Profile → My tickets.
///
/// The hero changes height with the content: 172 when there are tickets, 128
/// on the empty state — Figma draws them as two different heroes, not one
/// that resizes.
class TicketsScreen extends StatelessWidget {
  const TicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          locator<TicketsListBloc>()..add(const TicketsListEvent.load()),
      child: const _TicketsView(),
    );
  }
}

class _TicketsView extends StatelessWidget {
  const _TicketsView();

  /// Pushes a route, then re-reads the list: a conversation that cleared its
  /// unread dot has changed what this screen should show.
  Future<void> _open(BuildContext context, String path) async {
    final bloc = context.read<TicketsListBloc>();
    await context.push(path);
    bloc.add(const TicketsListEvent.refresh());
  }

  /// Raise → confirmation → (optionally) the new ticket, then refresh.
  ///
  /// **This screen runs the whole chain**, each step popping a result,
  /// because `pushReplacement` would orphan the awaited push — go_router
  /// drops a replaced route's completer without completing it — and the list
  /// would never learn a ticket had been raised.
  Future<void> _raise(BuildContext context) async {
    final bloc = context.read<TicketsListBloc>();
    final created = await context.push<TicketModel>(
      AppRoutes.TICKET_NEW_ROUTE_PATH,
    );
    if (created != null && context.mounted) {
      final view = await context.push<bool>(
        AppRoutes.TICKET_SUBMITTED_ROUTE_PATH,
        extra: created,
      );
      if (view == true && context.mounted) {
        await context.push(AppRoutes.ticketDetail(created.id));
      }
    }
    bloc.add(const TicketsListEvent.refresh());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TicketsListBloc, TicketsListState>(
      // A failed refresh or extra page keeps the rows and says why.
      listenWhen: (a, b) =>
          b.message.isNotEmpty &&
          a.message != b.message &&
          b.tickets.isNotEmpty,
      listener: (context, state) =>
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message))),
      builder: (context, state) => TicketSheetPage(
        header: TicketHeader(
          spec: TicketHeaderSpec.list,
          title: 'My Tickets',
          subtitle: 'Track your queries and their status',
          onBack: () => context.pop(),
        ),
        body: _body(context, state, state.isEmptyForReal),
      ),
    );
  }

  Widget _body(BuildContext context, TicketsListState state, bool empty) {
    if (state.state.isLoading || state.state.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.state.isError) {
      return _Retry(
        message: state.message,
        onRetry: () =>
            context.read<TicketsListBloc>().add(const TicketsListEvent.load()),
      );
    }
    if (empty) {
      return SingleChildScrollView(
        child: TicketsEmptyView(
          onRaise: () => _raise(context),
          // Figma's "Need help?" — Help & support is the nearest real
          // destination, and starts working on its own when that screen is
          // built.
          onNeedHelp: () => context.push(AppRoutes.HELP_SUPPORT_ROUTE_PATH),
        ),
      );
    }
    return TicketsListBody(
      state: state,
      onOpenTicket: (t) => _open(context, AppRoutes.ticketDetail(t.id)),
      onRaise: () => _raise(context),
    );
  }
}

class _Retry extends StatelessWidget {
  const _Retry({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: context.ticketType.emptyBody,
            ),
            const SizedBox(height: 14),
            TextButton(onPressed: onRetry, child: const Text('Try again')),
          ],
        ),
      ),
    );
  }
}
