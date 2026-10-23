import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/injections/injection.dart';
import 'package:finskool/src/comman/routes.dart';
import 'package:finskool/src/comman/widgets/skeleton.dart';
import 'package:finskool/src/presentation/bloc/services/requests/service_requests_bloc.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_card_skeleton.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_header.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_sheet_page.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'widgets/service_request_card.dart';

/// Services → My requests, reached from the Services tab's bell. The same
/// chrome as My Tickets; each row opens that request's chat.
class ServiceRequestsScreen extends StatelessWidget {
  const ServiceRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          locator<ServiceRequestsBloc>()
            ..add(const ServiceRequestsEvent.load()),
      child: const _RequestsView(),
    );
  }
}

class _RequestsView extends StatelessWidget {
  const _RequestsView();

  /// Re-reads the list on return: a conversation that cleared its unread dot
  /// has changed what this screen should show.
  Future<void> _open(BuildContext context, String id) async {
    final bloc = context.read<ServiceRequestsBloc>();
    await context.push(AppRoutes.serviceChat(id));
    bloc.add(const ServiceRequestsEvent.load());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceRequestsBloc, ServiceRequestsState>(
      builder: (context, state) => TicketSheetPage(
        header: TicketHeader(
          spec: TicketHeaderSpec.list,
          title: 'My Requests',
          subtitle: 'Your service enquiries and quotes',
          onBack: () => context.pop(),
        ),
        body: _body(context, state),
      ),
    );
  }

  Widget _body(BuildContext context, ServiceRequestsState state) {
    final type = context.ticketType;
    final bloc = context.read<ServiceRequestsBloc>();
    if (state.state.isLoading || state.state.isEmpty) {
      return const Shimmer(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 4, 20, 0),
          child: Column(
            children: [
              TicketCardSkeleton(),
              SizedBox(height: 12),
              TicketCardSkeleton(),
              SizedBox(height: 12),
              TicketCardSkeleton(),
            ],
          ),
        ),
      );
    }
    if (state.state.isError) {
      return _Centered(
        text: state.message,
        style: type.emptyBody,
        action: TextButton(
          onPressed: () => bloc.add(const ServiceRequestsEvent.load()),
          child: const Text('Try again'),
        ),
      );
    }
    if (state.requests.isEmpty) {
      return _Centered(
        text: 'No requests yet.\nTap “Enquire now” on a service to start one.',
        style: type.emptyBody,
      );
    }
    return RefreshIndicator(
      onRefresh: () async {
        bloc.add(const ServiceRequestsEvent.load());
        await bloc.stream.firstWhere((s) => !s.state.isLoading);
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (n) {
          if (n.metrics.extentAfter < 300 && n.metrics.maxScrollExtent > 0) {
            bloc.add(const ServiceRequestsEvent.loadMore());
          }
          return false;
        },
        child: ListView(
          padding: EdgeInsets.fromLTRB(
            20,
            4,
            20,
            24 + MediaQuery.paddingOf(context).bottom,
          ),
          children: [
            for (final r in state.requests) ...[
              ServiceRequestCard(request: r, onTap: () => _open(context, r.id)),
              const SizedBox(height: 12),
            ],
            if (state.isLoadingMore)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }
}

class _Centered extends StatelessWidget {
  const _Centered({required this.text, required this.style, this.action});

  final String text;
  final TextStyle style;
  final Widget? action;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text, textAlign: TextAlign.center, style: style),
          ?action,
        ],
      ),
    ),
  );
}
