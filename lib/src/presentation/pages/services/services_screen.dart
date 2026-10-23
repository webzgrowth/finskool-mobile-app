import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/injections/injection.dart';
import 'package:finskool/src/comman/routes.dart';
import 'package:finskool/src/comman/widgets/search_top_bar.dart';
import 'package:finskool/src/domain/model/service/service_model.dart';
import 'package:finskool/src/presentation/bloc/services/catalog/services_catalog_bloc.dart';
import 'package:finskool/src/presentation/bloc/services/enquiry/service_enquiry_bloc.dart';
import 'package:finskool/src/presentation/bloc/services/filter/services_filter_bloc.dart';
import 'package:finskool/src/presentation/bloc/services/requests/service_requests_bloc.dart';
import 'package:finskool/src/presentation/bloc/services/unread/services_unread_bloc.dart';

import 'widgets/enquiry_submitted_dialog.dart';
import 'widgets/service_card.dart';
import 'widgets/services_body.dart';

/// The Services tab: what the support team can quote for, each with an
/// "Enquire now". Tapping it opens a request (a chat with the team, who send
/// a quote the member pays for), so the bell here opens **My requests** and
/// carries their unread count.
class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<ServiceEnquiryBloc>()),
        // Route-scoped, like `ServiceRequestsScreen`'s own — this is a
        // *second* instance, not the My Requests screen's one. It exists
        // purely so a card already backed by an open request can say so
        // ("View request") instead of re-enquiring into a 409.
        BlocProvider(
          create: (_) =>
              locator<ServiceRequestsBloc>()
                ..add(const ServiceRequestsEvent.load()),
        ),
      ],
      child: const _ServicesView(),
    );
  }
}

class _ServicesView extends StatefulWidget {
  const _ServicesView();

  @override
  State<_ServicesView> createState() => _ServicesViewState();
}

class _ServicesViewState extends State<_ServicesView> {
  /// Which card's button is spinning. Transient UI — the bloc only knows a
  /// submission is in flight, not which card started it.
  String? _activeId;
  ServiceModel? _active;

  @override
  void initState() {
    super.initState();
    context.read<ServicesCatalogBloc>().add(const ServicesCatalogEvent.load());
  }

  void _enquire(ServiceModel service) {
    _active = service;
    setState(() => _activeId = service.id);
    context.read<ServiceEnquiryBloc>().add(
      ServiceEnquiryEvent.submitted(service),
    );
  }

  /// Opens an already-open request's chat directly, re-reading the list on
  /// return — the same pattern `ServiceRequestsScreen._open` uses, so a
  /// request that got closed or paid while the member was in the chat flips
  /// this card's button back without a manual pull-to-refresh.
  Future<void> _viewRequest(BuildContext context, String requestId) async {
    final bloc = context.read<ServiceRequestsBloc>();
    await context.push(AppRoutes.serviceChat(requestId));
    if (context.mounted) bloc.add(const ServiceRequestsEvent.load());
  }

  Future<void> _onEnquiry(BuildContext context, ServiceEnquiryState s) async {
    final bloc = context.read<ServiceEnquiryBloc>();
    final router = GoRouter.of(context);
    if (s.submit.isError) {
      setState(() => _activeId = null);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(s.message)));
      return;
    }
    final request = s.request;
    if (!s.submit.isLoaded || request == null) return;
    setState(() => _activeId = null);
    // Flips the card to "View request" straight away — for a brand-new
    // enquiry as much as an `existing` one found via 409, since either way
    // there's now an open request for this service.
    context.read<ServiceRequestsBloc>().add(const ServiceRequestsEvent.load());
    final choice = await EnquirySubmittedDialog.show(
      context,
      serviceTitle: request.serviceTitle.isNotEmpty
          ? request.serviceTitle
          : _active?.title ?? 'this service',
      label: request.label,
      existing: s.existing,
    );
    bloc.add(const ServiceEnquiryEvent.dismissed());
    if (choice == EnquiryChoice.view) {
      router.push(AppRoutes.serviceChat(request.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final unread = context.select<ServicesUnreadBloc, int>(
      (b) => b.state.count,
    );
    return Scaffold(
      backgroundColor: cs.surfaceContainer,
      body: BlocListener<ServiceEnquiryBloc, ServiceEnquiryState>(
        listenWhen: (p, c) => p.submit != c.submit,
        listener: _onEnquiry,
        child: RefreshIndicator(
          edgeOffset: SearchTopBar.heightFor(context),
          onRefresh: () async {
            context.read<ServicesCatalogBloc>().add(
              const ServicesCatalogEvent.refresh(),
            );
            context.read<ServiceRequestsBloc>().add(
              const ServiceRequestsEvent.load(),
            );
          },
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverAppBar(
                floating: true,
                snap: true,
                toolbarHeight: SearchTopBar.heightFor(context),
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                elevation: 0,
                flexibleSpace: SearchTopBar(
                  hintText: 'Search services.........',
                  notificationCount: unread,
                  onNotificationsTap: () =>
                      context.push(AppRoutes.SERVICE_REQUESTS_ROUTE_PATH),
                  onQueryChanged: (v) => context.read<ServicesFilterBloc>().add(
                    ServicesFilterEvent.queryChanged(v),
                  ),
                ),
              ),
              // Figma: the first card sits 20 under the bar.
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
              BlocBuilder<ServiceRequestsBloc, ServiceRequestsState>(
                builder: (context, requestsState) {
                  // serviceId -> the member's open request for it, if any.
                  // `closed` requests don't count — the member is free to
                  // enquire again once one is done.
                  final open = <String, String>{
                    for (final r in requestsState.requests)
                      if (!r.isClosed) r.serviceId: r.id,
                  };
                  return ServicesBody(
                    builder: (service) {
                      final requestId = open[service.id];
                      return ServiceCard(
                        service: service,
                        loading: _activeId == service.id,
                        hasOpenRequest: requestId != null,
                        onEnquire: requestId != null
                            ? () => _viewRequest(context, requestId)
                            : (_activeId == null
                                  ? () => _enquire(service)
                                  : () {}),
                      );
                    },
                  );
                },
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
