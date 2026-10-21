part of 'ticket_chat_bloc.dart';

/// The socket-driven half of the chat: pushed events and connection changes.
extension TicketChatLive on TicketChatBloc {
  Future<void> _onSocketEvent(
    SocketEvent e,
    Emitter<TicketChatState> emit,
  ) async {
    // The socket carries every ticket's traffic; this bloc owns just one.
    if (_ticketId.isEmpty || e.ticketId != _ticketId) return;
    final ticket = state.ticket;

    switch (e.event) {
      case 'ticket.message':
        final raw = e.data['message'];
        if (raw is! Map<String, dynamic>) return;
        final message = TicketMessageModel.fromJson(raw);
        emit(
          state.copyWith(
            // Also the second arrival of the member's own send — the ack
            // already placed it, and `withDelivered` makes this a no-op.
            messages: state.messages.withDelivered(message),
            ticket: _merged(ticket, e.data['ticket']),
          ),
        );
        // Support spoke while the member is looking: read it straight away,
        // or the badge would count a message they are reading right now.
        if (!message.isMine) await _markReadNow(emit);

      case 'ticket.updated':
        final next = _merged(ticket, e.data['ticket']);
        final changed =
            next != null && ticket != null && next.status != ticket.status;
        emit(
          state.copyWith(
            ticket: next,
            // "Status changed to In progress" can only be shown **live**:
            // the API keeps no status history (§10), so it can't be rebuilt
            // for a conversation opened afterwards. Resolved needs no pill
            // here — the screen derives it from `resolvedAt`.
            messages: changed && next.status == TicketStatus.inProgress
                ? state.messages.withDelivered(
                    _systemNotice(
                      'Status changed to ${TicketStatus.inProgress.label}',
                    ),
                  )
                : state.messages,
          ),
        );

      case 'ticket.read':
        if (ticket != null) {
          emit(state.copyWith(ticket: ticket.copyWith(unreadCount: 0)));
        }
    }
  }

  TicketModel? _merged(TicketModel? ticket, Object? rawSummary) {
    if (ticket == null || rawSummary is! Map<String, dynamic>) return ticket;
    return TicketSummaryModel.fromJson(rawSummary).mergeInto(ticket);
  }

  TicketMessageModel _systemNotice(String text) => TicketMessageModel(
    id: 'system-${TicketChatBloc._uuid.v4()}',
    ticketId: _ticketId,
    senderRole: 'system',
    senderName: 'Finskool',
    body: text,
    createdAt: DateTime.now().toUtc(),
  );

  Future<void> _onSocketStatus(
    SocketStatus status,
    Emitter<TicketChatState> emit,
  ) async {
    emit(state.copyWith(socket: status));
    final cameBack =
        status == SocketStatus.live && (_wasOffline || !_historyLoaded);
    _wasOffline = status != SocketStatus.live;

    // **Nothing is replayed** (§6.3.3): whatever happened while offline is
    // gone, so a reconnect refetches the ticket and the latest page and
    // merges them in. The same path recovers a first load that raced the
    // connection and found it down.
    if (cameBack && state.ticket != null) {
      await _refreshTicket(emit);
      await _loadLatest(emit);
    }
  }
}
