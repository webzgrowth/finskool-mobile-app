import 'ticket_attachment_model.dart';

/// One chat message. Arrives **only over the socket** — there are no REST
/// chat endpoints (§1).
class TicketMessageModel {
  const TicketMessageModel({
    required this.id,
    required this.ticketId,
    required this.senderRole,
    required this.senderName,
    required this.createdAt,
    this.senderId,
    this.body,
    this.clientMessageId,
    this.attachments = const [],
    this.delivery = MessageDelivery.sent,
  });

  final String id;
  final String ticketId;

  /// `user` is the member — i.e. "me" — and `admin` is support. Anything
  /// else is treated as support rather than dropped, so an unexpected role
  /// still renders on the correct side.
  final String senderRole;
  final String senderName;
  final String? senderId;

  /// Null for a file-only message (§4).
  final String? body;

  /// Our own id for the send, echoed back. It is how an optimistic bubble
  /// finds its real counterpart, and **reusing it on retry** is what makes a
  /// resend safe: the server stores each `(ticket, clientMessageId)` once.
  final String? clientMessageId;

  final List<TicketAttachmentModel> attachments;
  final DateTime createdAt;

  /// Local only — never sent, never parsed.
  final MessageDelivery delivery;

  bool get isMine => senderRole == 'user';

  /// A local-only notice ("Status changed to In progress"). The ticket API
  /// has **no system-message variant** — that belongs to the services
  /// module — so these are never parsed from the wire; the chat bloc
  /// synthesises them from `ticket.updated` and `resolvedAt`.
  bool get isSystem => senderRole == 'system';

  /// An optimistic bubble not yet confirmed by the server.
  bool get isLocal => id.startsWith('local-');

  TicketMessageModel copyWith({
    MessageDelivery? delivery,
    List<TicketAttachmentModel>? attachments,
  }) => TicketMessageModel(
    id: id,
    ticketId: ticketId,
    senderRole: senderRole,
    senderName: senderName,
    senderId: senderId,
    body: body,
    clientMessageId: clientMessageId,
    attachments: attachments ?? this.attachments,
    createdAt: createdAt,
    delivery: delivery ?? this.delivery,
  );

  factory TicketMessageModel.fromJson(Map<String, dynamic> json) =>
      TicketMessageModel(
        id: json['id'] as String,
        ticketId: json['ticketId'] as String? ?? '',
        senderRole: json['senderRole'] as String? ?? 'admin',
        senderName: json['senderName'] as String? ?? '',
        senderId: json['senderId'] as String?,
        body: json['body'] as String?,
        clientMessageId: json['clientMessageId'] as String?,
        attachments: TicketAttachmentModel.listFrom(json['attachments']),
        createdAt:
            DateTime.tryParse(json['createdAt'] as String? ?? '')?.toUtc() ??
            DateTime.now().toUtc(),
      );
}

/// Where an outgoing message has got to. The spec's optimistic-UI rule
/// (§6.3.2): show it immediately as sending, swap it for the real one when
/// the ack or the event lands, and leave a failure tappable to retry.
enum MessageDelivery { sending, sent, failed }
