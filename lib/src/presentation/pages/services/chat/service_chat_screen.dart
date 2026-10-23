import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/injections/injection.dart';
import 'package:finskool/src/domain/model/auth/user_model.dart';
import 'package:finskool/src/presentation/bloc/authentication/authenticator_watcher/authenticator_watcher_bloc.dart';
import 'package:finskool/src/presentation/bloc/services/chat/service_chat_bloc.dart';
import 'package:finskool/src/presentation/bloc/services/payment/service_payment_bloc.dart';
import 'package:finskool/src/presentation/pages/tickets/detail/widgets/chat_scroll_anchor.dart';
import 'package:finskool/src/presentation/pages/tickets/detail/widgets/member_avatar.dart';
import 'package:finskool/src/presentation/pages/tickets/detail/widgets/open_attachment.dart';
import 'package:finskool/src/presentation/pages/tickets/detail/widgets/rating_popup.dart';
import 'package:finskool/src/presentation/pages/tickets/detail/widgets/reply_bar.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/pick_ticket_files.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_header.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_sheet_page.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'widgets/billing_sheet.dart';
import 'widgets/razorpay_checkout.dart';
import 'widgets/service_actions.dart';
import 'widgets/service_conversation.dart';

/// A service request's conversation: chat with the team, their quote as a
/// card, **Pay** (billing → Razorpay → server verification), then — once the
/// work is done — a single rating. Built on the My Tickets chrome.
class ServiceChatScreen extends StatelessWidget {
  const ServiceChatScreen({super.key, required this.requestId});

  final String requestId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              locator<ServiceChatBloc>()
                ..add(ServiceChatEvent.started(requestId)),
        ),
        BlocProvider(create: (_) => locator<ServicePaymentBloc>()),
      ],
      child: _ChatView(requestId: requestId),
    );
  }
}

class _ChatView extends StatefulWidget {
  const _ChatView({required this.requestId});

  final String requestId;

  @override
  State<_ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<_ChatView> {
  final _scroll = ScrollController();
  late final ChatScrollAnchor _anchor = ChatScrollAnchor(
    _scroll,
    isMounted: () => mounted,
  );
  late final RazorpayCheckout _checkout;
  bool _ratingDismissed = false; // transient overlay state, not bloc state

  @override
  void initState() {
    super.initState();
    final payment = context.read<ServicePaymentBloc>();
    _checkout = RazorpayCheckout(
      onSuccess: (p) => payment.add(ServicePaymentEvent.checkoutSucceeded(p)),
      onError: (m) => payment.add(ServicePaymentEvent.checkoutFailed(m)),
      onDismissed: () =>
          payment.add(const ServicePaymentEvent.checkoutDismissed()),
    );
  }

  @override
  void dispose() {
    _checkout.dispose();
    _scroll.dispose();
    super.dispose();
  }

  UserModel? get _user => context
      .read<AuthenticatorWatcherBloc>()
      .state
      .mapOrNull(authenticated: (s) => s.user);

  void _snack(String text, {SnackBarAction? action}) =>
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(text), action: action));

  Future<void> _pay(String quoteId) async {
    final chat = context.read<ServiceChatBloc>();
    final payment = context.read<ServicePaymentBloc>();
    final quote = chat.state.quotes[quoteId];
    if (quote == null || !quote.isPayable) return;
    final billing = await showBillingSheet(
      context,
      quote: quote,
      initialName: _user?.name ?? '',
    );
    if (billing == null) return;
    payment.add(
      ServicePaymentEvent.payTapped(
        requestId: widget.requestId,
        quote: quote,
        billing: billing,
      ),
    );
  }

  void _onPayment(BuildContext context, ServicePaymentState s) {
    final chat = context.read<ServiceChatBloc>();
    final payment = context.read<ServicePaymentBloc>();
    switch (s.step) {
      case PaymentStep.awaitingCheckout:
        final order = s.order;
        if (order != null) {
          _checkout.open(
            order,
            title: chat.state.request?.serviceTitle ?? 'Service',
            email: _user?.email,
            phone: _user?.phone,
          );
        }
      case PaymentStep.done:
        final paid = s.paid;
        if (paid != null) chat.add(ServiceChatEvent.paid(paid));
        _snack('Payment received. Your invoice is ready.');
      case PaymentStep.verifyFailed:
        // Money may have moved: keep the proof and let the member re-check.
        final proof = s.pendingProof;
        _snack(
          s.message,
          action: proof == null
              ? null
              : SnackBarAction(
                  label: 'Retry',
                  onPressed: () =>
                      payment.add(ServicePaymentEvent.checkoutSucceeded(proof)),
                ),
        );
      case PaymentStep.idle:
        if (s.message.isNotEmpty) _snack(s.message);
      case PaymentStep.creatingOrder || PaymentStep.verifying:
        break;
    }
    if (s.staleQuote) chat.add(const ServiceChatEvent.refreshed());
  }

  Future<void> _attach() async {
    final bloc = context.read<ServiceChatBloc>();
    for (final f in await pickTicketFiles(context)) {
      bloc.add(ServiceChatEvent.attachmentPicked(f.file, f.name));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ServicePaymentBloc, ServicePaymentState>(
      listenWhen: (a, b) => a.step != b.step || a.staleQuote != b.staleQuote,
      listener: _onPayment,
      child: BlocConsumer<ServiceChatBloc, ServiceChatState>(
        listenWhen: (a, b) =>
            a.message != b.message ||
            a.messages != b.messages ||
            a.isLoadingEarlier != b.isLoadingEarlier,
        listener: (context, state) {
          _anchor.onServiceState(state);
          if (state.message.isNotEmpty) _snack(state.message);
        },
        builder: _build,
      ),
    );
  }

  Widget _build(BuildContext context, ServiceChatState state) {
    final bloc = context.read<ServiceChatBloc>();
    final request = state.request;
    final busy = context.select<ServicePaymentBloc, bool>(
      (b) => b.state.step.isBusy,
    );
    final showRating = request != null && request.canRate && !_ratingDismissed;
    return TicketSheetPage(
      header: TicketHeader(
        spec: TicketHeaderSpec.chat,
        title: request?.serviceTitle ?? 'Service request',
        subtitle: request == null ? null : '#${request.label}',
        onBack: () => context.pop(),
      ),
      body: request == null
          ? _Placeholder(
              failed: state.state.isError,
              message: state.message,
              onRetry: () =>
                  bloc.add(ServiceChatEvent.started(widget.requestId)),
            )
          : ListView(
              controller: _scroll,
              padding: EdgeInsets.only(bottom: showRating ? 240 : 24),
              children: [
                ServiceActions(
                  request: request,
                  cancelling: state.cancel.isLoading,
                ),
                ServiceConversation(
                  state: state,
                  payBusy: busy,
                  memberAvatar: const MemberAvatar(),
                  onPay: _pay,
                  onLoadEarlier: () =>
                      bloc.add(const ServiceChatEvent.loadEarlier()),
                  onRetry: (id) => bloc.add(ServiceChatEvent.retried(id)),
                  onOpenAttachment: (a) => openAttachment(
                    context,
                    a,
                    (id, r) =>
                        bloc.add(ServiceChatEvent.attachmentOpened(id, r)),
                  ),
                ),
              ],
            ),
      // A closed request is read-only for good, so the composer is gone.
      bottomBar: request == null || state.isLocked
          ? null
          : ReplyBar(
              drafts: state.drafts,
              enabled: state.canSend,
              reconnecting: state.isReconnecting,
              onSend: (t) => bloc.add(ServiceChatEvent.sent(t)),
              onAttach: _attach,
              onRemoveDraft: (id) =>
                  bloc.add(ServiceChatEvent.attachmentRemoved(id)),
            ),
      overlays: [
        if (showRating)
          RatingPopup(
            submitting: state.rating.isLoading,
            onSubmit: (stars) => bloc.add(ServiceChatEvent.rated(stars, null)),
            onClose: () => setState(() => _ratingDismissed = true),
          ),
      ],
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({
    required this.failed,
    required this.message,
    required this.onRetry,
  });

  final bool failed;
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    if (!failed) return const Center(child: CircularProgressIndicator());
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
