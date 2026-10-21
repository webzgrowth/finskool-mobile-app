part of 'ticket_chat_bloc.dart';

@freezed
sealed class TicketChatState with _$TicketChatState {
  const factory TicketChatState({
    /// The first load of the ticket and its history.
    required RequestState state,

    /// A transient failure (a send, an upload, a rating) shown as a snackbar
    /// without disturbing the conversation on screen.
    required String message,
    required List<TicketMessageModel> messages,
    required bool isLoadingEarlier,
    required SocketStatus socket,
    required List<TicketAttachmentDraft> drafts,
    required RequestState rating,
    TicketModel? ticket,
    String? historyCursor,
  }) = _TicketChatState;

  const TicketChatState._();

  factory TicketChatState.initial() => const TicketChatState(
    state: RequestState.empty,
    message: '',
    messages: [],
    isLoadingEarlier: false,
    socket: SocketStatus.idle,
    drafts: [],
    rating: RequestState.empty,
  );

  bool get hasEarlier => historyCursor != null;

  /// A resolved ticket is **read-only for good** (§7): no reopen exists, so
  /// the composer locks permanently rather than merely disabling.
  bool get isLocked => ticket?.isResolved ?? false;

  bool get isUploading => drafts.any((d) => d.isUploading);

  /// Offline is not the same as locked: the composer stays visible but
  /// can't send, and the screen shows "Reconnecting…" (§1 requires it).
  bool get canSend => !isLocked && socket.canSend && !isUploading;

  bool get isReconnecting =>
      !socket.canSend && socket != SocketStatus.idle && ticket != null;
}
