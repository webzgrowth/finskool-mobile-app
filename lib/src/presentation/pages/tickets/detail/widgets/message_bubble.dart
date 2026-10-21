import 'package:flutter/material.dart';
import 'package:finskool/src/comman/ist_time.dart';
import 'package:finskool/src/domain/model/ticket/ticket_attachment_model.dart';
import 'package:finskool/src/domain/model/ticket/ticket_message_model.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'attachment_chip.dart';

/// One chat message: the member's on the right in `#108B8B` beside their own
/// avatar, support's on the left in `#F6F6F6` behind a 28px "FS" avatar.
///
/// Both bubbles occupy the same 262px column (x=56..318 at design size) with
/// the avatars outside it. Corner radii were measured off Figma's render,
/// since the node data only says "mixed": 18 everywhere but a **4** tail at
/// the top corner nearest the sender's avatar.
class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
    required this.onOpenAttachment,
    required this.onRetry,
    required this.memberAvatar,
  });

  final TicketMessageModel message;
  final ValueChanged<TicketAttachmentModel> onOpenAttachment;
  final VoidCallback onRetry;

  /// The member's own avatar, supplied by the screen (it needs the signed-in
  /// user, which this widget has no business reading).
  final Widget memberAvatar;

  /// Figma: bubbles start 56 from the left and end 57 from the right.
  static const double _leftInset = 56;
  static const double _rightInset = 57;

  @override
  Widget build(BuildContext context) {
    final mine = message.isMine;
    final failed = message.delivery == MessageDelivery.failed;
    return LayoutBuilder(
      builder: (context, box) {
        final maxWidth = box.maxWidth - _leftInset - _rightInset;
        final bubble = _Bubble(
          message: message,
          mine: mine,
          onOpenAttachment: onOpenAttachment,
        );
        final column = ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Column(
            crossAxisAlignment: mine
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: failed ? onRetry : null,
                child: Opacity(
                  opacity: message.delivery == MessageDelivery.sending
                      ? 0.6
                      : 1,
                  child: bubble,
                ),
              ),
              const SizedBox(height: 4),
              _Caption(message: message, onRetry: onRetry),
            ],
          ),
        );
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: mine
              ? [
                  const SizedBox(width: _leftInset),
                  Expanded(
                    child: Align(alignment: Alignment.topRight, child: column),
                  ),
                  const SizedBox(width: 6),
                  memberAvatar,
                  const SizedBox(width: 23),
                ]
              : [
                  const SizedBox(width: 20),
                  const _Avatar(),
                  const SizedBox(width: 8),
                  column,
                ],
        );
      },
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({
    required this.message,
    required this.mine,
    required this.onOpenAttachment,
  });

  final TicketMessageModel message;
  final bool mine;
  final ValueChanged<TicketAttachmentModel> onOpenAttachment;

  @override
  Widget build(BuildContext context) {
    final type = context.ticketType;
    final text = mine
        ? type.bubble.copyWith(color: AppPalette.white)
        : type.bubble;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: mine ? AppPalette.badgeTeal : AppPalette.ticketCard,
        border: mine ? null : Border.all(color: AppPalette.ticketBubbleBorder),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(mine ? 18 : 4),
          topRight: Radius.circular(mine ? 4 : 18),
          bottomLeft: const Radius.circular(18),
          bottomRight: const Radius.circular(18),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (message.body != null && message.body!.isNotEmpty)
            Text(message.body!, style: text),
          for (final a in message.attachments) ...[
            if (message.body != null || a != message.attachments.first)
              const SizedBox(height: 10),
            AttachmentChip(
              attachment: a,
              onDark: mine,
              onTap: () => onOpenAttachment(a),
            ),
          ],
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      width: 28,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppPalette.badgeTeal,
        shape: BoxShape.circle,
      ),
      child: Text('FS', style: context.ticketType.avatarInitials),
    );
  }
}

/// "You  ·  05 Oct, 4:18 PM" — and, for a message still in flight or not
/// sent, the state in place of the time.
class _Caption extends StatelessWidget {
  const _Caption({required this.message, required this.onRetry});

  final TicketMessageModel message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final type = context.ticketType;
    if (message.delivery == MessageDelivery.failed) {
      return GestureDetector(
        onTap: onRetry,
        child: Text('Not sent  ·  Tap to retry', style: type.fieldError),
      );
    }
    if (message.delivery == MessageDelivery.sending) {
      return Text('Sending…', style: type.bubbleCaption);
    }
    // Support is "Support team", not the admin's own name: the design shows
    // one team voice, and the API's `senderName` is an individual.
    final who = message.isMine ? 'You' : 'Support team';
    final when = formatIst(message.createdAt, 'dd MMM, h:mm a');
    return Text('$who  ·  $when', style: type.bubbleCaption);
  }
}
