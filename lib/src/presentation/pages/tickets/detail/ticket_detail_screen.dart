import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/injections/injection.dart';
import 'package:finskool/src/presentation/bloc/tickets/chat/ticket_chat_bloc.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/pick_ticket_files.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_header.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_sheet_page.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'widgets/chat_scroll_anchor.dart';
import 'widgets/conversation_section.dart';
import 'widgets/open_attachment.dart';
import 'widgets/member_avatar.dart';
import 'widgets/rating_popup.dart';
import 'widgets/reply_bar.dart';
import 'widgets/status_button.dart';
import 'widgets/status_popover.dart';

/// "How Can We Help?" — a ticket and its conversation. One screen: "In
/// progress" and "Resolved" are the same layout in two states, and a resolved
/// ticket simply loses its composer and gains the rating card. The Status
/// button opens the stepper popover.
class TicketDetailScreen extends StatelessWidget {
  const TicketDetailScreen({
    super.key,
    required this.ticketId,
    this.memberAvatar,
  });

  final String ticketId;

  /// Overrides the signed-in user's avatar — for tests, which have no
  /// `AuthenticatorWatcherBloc`.
  final Widget? memberAvatar;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          locator<TicketChatBloc>()..add(TicketChatEvent.started(ticketId)),
      child: _DetailView(ticketId: ticketId, memberAvatar: memberAvatar),
    );
  }
}

class _DetailView extends StatefulWidget {
  const _DetailView({required this.ticketId, this.memberAvatar});

  final String ticketId;
  final Widget? memberAvatar;

  @override
  State<_DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<_DetailView> {
  final _scroll = ScrollController();

  // Transient presentation state — which overlay is up — not app state, so
  // it is local rather than bloc state (CLAUDE.md, "Not everything is a bloc").
  bool _statusOpen = false;
  bool _ratingDismissed = false;
  late final ChatScrollAnchor _anchor = ChatScrollAnchor(
    _scroll,
    isMounted: () => mounted,
  );

  Future<void> _attach(BuildContext context) async {
    final bloc = context.read<TicketChatBloc>();
    for (final file in await pickTicketFiles(context)) {
      bloc.add(TicketChatEvent.attachmentPicked(file.file, file.name));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TicketChatBloc, TicketChatState>(
      // `isLoadingEarlier` is listed on purpose: the prepend-anchoring in
      // `_onState` keys off it toggling, which changes no message.
      listenWhen: (a, b) =>
          a.message != b.message ||
          a.messages != b.messages ||
          a.isLoadingEarlier != b.isLoadingEarlier,
      listener: (context, state) {
        _anchor.onState(state);
        if (state.message.isNotEmpty) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final bloc = context.read<TicketChatBloc>();
        final ticket = state.ticket;
        final showRating =
            ticket != null && ticket.canRate && !_ratingDismissed;
        return TicketSheetPage(
          header: TicketHeader(
            spec: TicketHeaderSpec.chat,
            title: 'How Can We Help?',
            subtitle: 'Tell us what happened and we\u2019ll help.',
            onBack: () => context.pop(),
            trailing: ticket == null
                ? null
                : Positioned(
                    right: 19,
                    top: 9,
                    child: StatusButton(
                      onTap: () => setState(() => _statusOpen = true),
                    ),
                  ),
          ),
          body: ticket == null
              ? _Placeholder(
                  failed: state.state.isError,
                  message: state.message,
                  onRetry: () =>
                      bloc.add(TicketChatEvent.started(widget.ticketId)),
                )
              : ListView(
                  controller: _scroll,
                  // Room under the last message for the rating card, which
                  // floats over the (absent) composer.
                  padding: EdgeInsets.only(bottom: showRating ? 240 : 24),
                  children: [
                    ConversationSection(
                      state: state,
                      memberAvatar: widget.memberAvatar ?? const MemberAvatar(),
                      onLoadEarlier: () =>
                          bloc.add(const TicketChatEvent.loadEarlier()),
                      onRetry: (id) => bloc.add(TicketChatEvent.retried(id)),
                      onOpenAttachment: (a) => openTicketAttachment(context, a),
                    ),
                  ],
                ),
          // A resolved ticket is read-only for good — there is no reopen — so
          // the composer is gone, not merely disabled (Figma has none there).
          bottomBar: ticket == null || state.isLocked
              ? null
              : ReplyBar(
                  drafts: state.drafts,
                  enabled: state.canSend,
                  reconnecting: state.isReconnecting,
                  onSend: (text) => bloc.add(TicketChatEvent.sent(text)),
                  onAttach: () => _attach(context),
                  onRemoveDraft: (id) =>
                      bloc.add(TicketChatEvent.attachmentRemoved(id)),
                ),
          overlays: [
            if (ticket != null && _statusOpen)
              StatusPopover(
                ticket: ticket,
                onClose: () => setState(() => _statusOpen = false),
              ),
            if (showRating)
              RatingPopup(
                submitting: state.rating.isLoading,
                onSubmit: (stars) =>
                    bloc.add(TicketChatEvent.rated(stars, null)),
                onClose: () => setState(() => _ratingDismissed = true),
              ),
          ],
        );
      },
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
