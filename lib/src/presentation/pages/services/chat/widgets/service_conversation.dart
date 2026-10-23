import 'package:flutter/material.dart';
import 'package:finskool/src/domain/model/service/service_request_model.dart';
import 'package:finskool/src/domain/model/ticket/ticket_attachment_model.dart';
import 'package:finskool/src/domain/model/ticket/ticket_message_model.dart';
import 'package:finskool/src/presentation/bloc/services/chat/service_chat_bloc.dart';
import 'package:finskool/src/presentation/pages/tickets/detail/widgets/message_bubble.dart';
import 'package:finskool/src/presentation/pages/tickets/detail/widgets/system_pill.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'quote_card.dart';

/// The whole conversation, every gap 14.
///
/// **The member's `needs` is the first bubble** — like a ticket's
/// description it is not in the message history, so it is synthesised, and
/// only once there are no earlier pages left. Quote messages render as
/// [QuoteCard]s; `system` rows as centred pills.
class ServiceConversation extends StatelessWidget {
  const ServiceConversation({
    super.key,
    required this.state,
    required this.memberAvatar,
    required this.onLoadEarlier,
    required this.onRetry,
    required this.onOpenAttachment,
    required this.onPay,
    required this.payBusy,
  });

  final ServiceChatState state;
  final Widget memberAvatar;
  final VoidCallback onLoadEarlier;
  final ValueChanged<String> onRetry;
  final ValueChanged<TicketAttachmentModel> onOpenAttachment;
  final ValueChanged<String> onPay;
  final bool payBusy;

  TicketMessageModel _needsOf(ServiceRequestModel r) => TicketMessageModel(
    id: 'needs-${r.id}',
    ticketId: r.id,
    senderRole: 'user',
    senderName: 'You',
    body: r.needs,
    attachments: r.attachments,
    createdAt: r.createdAt,
  );

  Widget _item(BuildContext context, TicketMessageModel m) {
    if (m.isSystem) return SystemPill(m.body ?? '');
    final quote = m.isQuote ? state.quotes[m.quoteId] : null;
    if (quote != null) {
      return QuoteCard(
        quote: quote,
        canPay: !state.isLocked && state.payableQuote?.id == quote.id,
        paying: payBusy,
        onPay: () => onPay(quote.id),
      );
    }
    return MessageBubble(
      message: m,
      onOpenAttachment: onOpenAttachment,
      onRetry: () => onRetry(m.clientMessageId ?? ''),
      memberAvatar: memberAvatar,
    );
  }

  @override
  Widget build(BuildContext context) {
    final request = state.request!;
    final items = <Widget>[
      if (state.hasEarlier)
        Center(
          child: state.isLoadingEarlier
              ? const SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : GestureDetector(
                  onTap: onLoadEarlier,
                  behavior: HitTestBehavior.opaque,
                  child: Text(
                    'View earlier messages',
                    style: context.ticketType.loadEarlier,
                  ),
                ),
        )
      else
        MessageBubble(
          message: _needsOf(request),
          onOpenAttachment: onOpenAttachment,
          onRetry: () {},
          memberAvatar: memberAvatar,
        ),
      for (final m in state.messages) _item(context, m),
      if (request.isClosed && request.closedReason != null)
        SystemPill(switch (request.closedReason!) {
          ServiceClosedReason.completed =>
            'Marked as completed by Support team',
          ServiceClosedReason.declined => 'Request declined by Support team',
          ServiceClosedReason.cancelledByMember => 'You cancelled this request',
        }),
      if (request.rating != null)
        SystemPill('You rated this request ${request.rating}/5'),
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
