import 'package:flutter/material.dart';
import 'package:finskool/src/domain/model/ticket/ticket_attachment_model.dart';
import 'package:finskool/src/domain/model/ticket/ticket_message_model.dart';
import 'package:finskool/src/domain/model/ticket/ticket_model.dart';
import 'package:finskool/src/presentation/bloc/tickets/chat/ticket_chat_bloc.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'message_bubble.dart';
import 'system_pill.dart';

/// The whole conversation, every gap 14.
///
/// **The description is the first bubble.** It is not part of the message
/// history (§4), so it is synthesised from the ticket — and only once there
/// are no earlier pages left to load, since it is the oldest thing here.
class ConversationSection extends StatelessWidget {
  const ConversationSection({
    super.key,
    required this.state,
    required this.onLoadEarlier,
    required this.onRetry,
    required this.onOpenAttachment,
    required this.memberAvatar,
  });

  final TicketChatState state;
  final VoidCallback onLoadEarlier;
  final ValueChanged<String> onRetry;
  final ValueChanged<TicketAttachmentModel> onOpenAttachment;
  final Widget memberAvatar;

  TicketMessageModel _descriptionOf(TicketModel t) => TicketMessageModel(
    id: 'description-${t.id}',
    ticketId: t.id,
    senderRole: 'user',
    senderName: 'You',
    body: t.description,
    attachments: t.attachments,
    createdAt: t.createdAt,
  );

  @override
  Widget build(BuildContext context) {
    final ticket = state.ticket!;
    final items = <Widget>[
      if (state.hasEarlier)
        _EarlierLink(loading: state.isLoadingEarlier, onTap: onLoadEarlier)
      else
        MessageBubble(
          message: _descriptionOf(ticket),
          onOpenAttachment: onOpenAttachment,
          onRetry: () {},
          memberAvatar: memberAvatar,
        ),
      for (final m in state.messages)
        if (m.isSystem)
          SystemPill(m.body ?? '')
        else
          MessageBubble(
            message: m,
            onOpenAttachment: onOpenAttachment,
            onRetry: () => onRetry(m.clientMessageId ?? ''),
            memberAvatar: memberAvatar,
          ),
      // Derived from `resolvedAt`, so it shows on a conversation opened after
      // the fact — unlike "Status changed to In progress", which can only be
      // shown live because the API keeps no status history.
      if (ticket.isResolved && ticket.resolvedAt != null)
        const SystemPill('Marked as resolved by Support team'),
      if (ticket.rating != null)
        SystemPill('You rated this ticket ${ticket.rating}/5'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < items.length; i++) ...[
          if (i > 0) const SizedBox(height: 14),
          items[i],
        ],
      ],
    );
  }
}

/// Figma: "View 3 earlier messages". The API reports no total, so the count
/// can't be shown — it reads "View earlier messages".
class _EarlierLink extends StatelessWidget {
  const _EarlierLink({required this.loading, required this.onTap});

  final bool loading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: loading
          ? const SizedBox(
              height: 16,
              width: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : GestureDetector(
              onTap: onTap,
              behavior: HitTestBehavior.opaque,
              child: Text(
                'View earlier messages',
                style: context.ticketType.loadEarlier,
              ),
            ),
    );
  }
}
