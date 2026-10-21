part of 'ticket_chat_bloc.dart';

@freezed
class TicketChatEvent with _$TicketChatEvent {
  /// Opens a conversation: the ticket (REST) and its latest history page
  /// (socket), then marks it read.
  const factory TicketChatEvent.started(String ticketId) = _Started;

  /// "View N earlier messages" — the next history page.
  const factory TicketChatEvent.loadEarlier() = _LoadEarlier;

  const factory TicketChatEvent.sent(String text) = _Sent;

  /// Retries a failed bubble **with its original `clientMessageId`**, so the
  /// server can recognise it if the first attempt actually landed.
  const factory TicketChatEvent.retried(String clientMessageId) = _Retried;

  const factory TicketChatEvent.attachmentPicked(File file, [String? name]) =
      _AttachmentPicked;
  const factory TicketChatEvent.attachmentRemoved(String draftId) =
      _AttachmentRemoved;

  /// The member tapped an attachment. Its signed link lasts ~5 minutes, so
  /// in a conversation left open it is probably dead — fetch a fresh one
  /// **every tap** and hand it back through [result].
  ///
  /// A `Completer` rather than state because this is a request/response, not
  /// something to render: the widget awaits the URL and launches it. (A tap is
  /// not the "retry loop" §7 warns against — that is an *automatic* retry of
  /// a failed image.)
  const factory TicketChatEvent.attachmentOpened(
    String attachmentId,
    Completer<String?> result,
  ) = _AttachmentOpened;

  const factory TicketChatEvent.rated(int rating, String? comment) = _Rated;

  /// Internal. A pushed event for any ticket; the bloc filters to its own.
  const factory TicketChatEvent.socketEvent(SocketEvent event) = _SocketEvent;

  /// Internal. The connection came back or dropped.
  const factory TicketChatEvent.socketStatus(SocketStatus status) =
      _SocketStatus;
}
