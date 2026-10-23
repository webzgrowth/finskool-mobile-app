part of 'service_chat_bloc.dart';

@freezed
sealed class ServiceChatState with _$ServiceChatState {
  const factory ServiceChatState({
    required RequestState state,

    /// A transient failure, shown as a snackbar without disturbing the chat.
    required String message,
    required List<TicketMessageModel> messages,

    /// Every quote seen, by id. Quote *cards* read their status from here.
    required Map<String, ServiceQuoteModel> quotes,
    required bool isLoadingEarlier,
    required SocketStatus socket,
    required List<TicketAttachmentDraft> drafts,
    required RequestState rating,
    required RequestState cancel,
    ServiceRequestModel? request,
    String? historyCursor,
  }) = _ServiceChatState;

  const ServiceChatState._();

  factory ServiceChatState.initial() => const ServiceChatState(
    state: RequestState.empty,
    message: '',
    messages: [],
    quotes: {},
    isLoadingEarlier: false,
    socket: SocketStatus.idle,
    drafts: [],
    rating: RequestState.empty,
    cancel: RequestState.empty,
  );

  bool get hasEarlier => historyCursor != null;

  /// A closed request is read-only for good.
  bool get isLocked => request?.isClosed ?? false;
  bool get isUploading => drafts.any((d) => d.isUploading);
  bool get canSend => !isLocked && socket.canSend && !isUploading;
  bool get isReconnecting =>
      !socket.canSend && socket != SocketStatus.idle && request != null;

  /// The quote the member can pay right now, if any.
  ServiceQuoteModel? get payableQuote {
    final q = request?.quote;
    if (q == null) return null;
    final current = quotes[q.id] ?? q;
    return current.isPayable ? current : null;
  }
}
