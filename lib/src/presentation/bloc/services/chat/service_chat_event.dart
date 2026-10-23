part of 'service_chat_bloc.dart';

@freezed
class ServiceChatEvent with _$ServiceChatEvent {
  /// Opens a request: the request (REST), then its latest history (socket).
  const factory ServiceChatEvent.started(String requestId) = _Started;
  const factory ServiceChatEvent.loadEarlier() = _LoadEarlier;
  const factory ServiceChatEvent.sent(String text) = _Sent;

  /// Retries a failed bubble **with its original `clientMessageId`**.
  const factory ServiceChatEvent.retried(String clientMessageId) = _Retried;
  const factory ServiceChatEvent.attachmentPicked(File file, [String? name]) =
      _AttachmentPicked;
  const factory ServiceChatEvent.attachmentRemoved(String draftId) =
      _AttachmentRemoved;

  /// Fetches a fresh signed link (the first lasts ~5 minutes) and hands it
  /// back through [result].
  const factory ServiceChatEvent.attachmentOpened(
    String attachmentId,
    Completer<String?> result,
  ) = _AttachmentOpened;

  /// Cancel the request before paying.
  const factory ServiceChatEvent.cancelled() = _Cancelled;
  const factory ServiceChatEvent.rated(int rating, String? comment) = _Rated;

  /// Resolves with the invoice PDF's signed link, or null on failure.
  const factory ServiceChatEvent.invoiceRequested(
    Completer<InvoiceLink?> result,
  ) = _InvoiceRequested;

  /// Refetch the request — a quote went stale under the member.
  const factory ServiceChatEvent.refreshed() = _Refreshed;

  /// Payment confirmed by `/verify`; adopt the server's `paid` request.
  const factory ServiceChatEvent.paid(ServiceRequestModel request) = _Paid;

  const factory ServiceChatEvent.socketEvent(SocketEvent event) = _SocketEvent;
  const factory ServiceChatEvent.socketStatus(SocketStatus status) =
      _SocketStatus;
}
