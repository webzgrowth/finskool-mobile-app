part of 'ticket_chat_bloc.dart';

extension TicketChatHandlers on TicketChatBloc {
  Future<void> _start(String ticketId, Emitter<TicketChatState> emit) async {
    _ticketId = ticketId;
    emit(
      state.copyWith(
        state: RequestState.loading,
        socket: _socket.currentStatus,
      ),
    );
    _socket.connect();

    // Both go out together; the history waits for the socket below.
    final ticketResult = await _getTicket.execute(ticketId);
    final ticket = ticketResult.fold((_) => null, (t) => t);
    if (ticket == null) {
      // A ticket that isn't the member's is a 404, never a 403 — so this is
      // "gone", and the screen closes.
      emit(
        state.copyWith(
          state: RequestState.error,
          message: ticketResult.fold((f) => f.message, (_) => ''),
        ),
      );
      return;
    }
    emit(state.copyWith(state: RequestState.loaded, ticket: ticket));
    await _socket.whenLive();
    await _loadLatest(emit);
  }

  /// The newest page, merged over whatever is on screen. Used for the first
  /// load **and** after every reconnect, since nothing is replayed (§6.3.3).
  Future<void> _loadLatest(Emitter<TicketChatState> emit) async {
    final result = await _getHistory.execute(ticketId: _ticketId);
    final page = result.fold((_) => null, (p) => p);
    if (page == null) return; // the reconnect resync will try again
    _historyLoaded = true;
    emit(
      state.copyWith(
        messages: state.messages.mergedWithLatest(page.items),
        // Only the first load sets the cursor; a resync must not rewind the
        // paging position the member has already scrolled past.
        historyCursor: state.messages.isEmpty
            ? page.nextCursor
            : state.historyCursor,
      ),
    );
    await _markReadNow(emit);
  }

  Future<void> _markReadNow(Emitter<TicketChatState> emit) async {
    final ticket = state.ticket;
    if (ticket == null || ticket.unreadCount == 0) return;
    final result = await _markRead.execute(_ticketId);
    result.fold(
      (_) {}, // harmless: the next event or reconnect retries
      (_) => emit(state.copyWith(ticket: ticket.copyWith(unreadCount: 0))),
    );
  }

  Future<void> _loadEarlier(Emitter<TicketChatState> emit) async {
    if (!state.hasEarlier || state.isLoadingEarlier) return;
    emit(state.copyWith(isLoadingEarlier: true));
    final result = await _getHistory.execute(
      ticketId: _ticketId,
      before: state.historyCursor,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(isLoadingEarlier: false, message: failure.message),
      ),
      (page) => emit(
        state.copyWith(
          isLoadingEarlier: false,
          messages: state.messages.withEarlier(page.items),
          historyCursor: page.nextCursor,
        ),
      ),
    );
  }

  Future<void> _sendText(String text, Emitter<TicketChatState> emit) async {
    final body = text.trim();
    final uploads = [
      for (final d in state.drafts)
        if (d.isReady) d.upload!,
    ];
    if (body.isEmpty && uploads.isEmpty) return;
    if (!state.canSend) {
      emit(state.copyWith(message: 'You are offline. Reconnecting…'));
      return;
    }

    // Our own id, minted once. **Reused on every retry** of this message, so
    // the server stores it once even if the first attempt actually landed.
    final clientId = TicketChatBloc._uuid.v4();
    _pending[clientId] = uploads;

    emit(
      state.copyWith(
        drafts: const [],
        messages: state.messages.withOptimistic(
          TicketMessageModel(
            id: 'local-$clientId',
            ticketId: _ticketId,
            senderRole: 'user',
            senderName: 'You',
            body: body.isEmpty ? null : body,
            clientMessageId: clientId,
            createdAt: DateTime.now().toUtc(),
            delivery: MessageDelivery.sending,
            attachments: [
              for (final u in uploads)
                TicketAttachmentModel(
                  id: 'local-${u.objectKey}',
                  fileName: u.fileName,
                  mimeType: '',
                  sizeBytes: u.sizeBytes,
                ),
            ],
          ),
        ),
      ),
    );
    await _deliver(clientId, emit);
  }

  Future<void> _retry(String clientId, Emitter<TicketChatState> emit) async {
    if (!state.canSend) {
      emit(state.copyWith(message: 'You are offline. Reconnecting…'));
      return;
    }
    emit(
      state.copyWith(
        messages: state.messages.withDelivery(
          clientId,
          MessageDelivery.sending,
        ),
      ),
    );
    await _deliver(clientId, emit);
  }

  Future<void> _deliver(String clientId, Emitter<TicketChatState> emit) async {
    final bubble = state.messages
        .where((m) => m.clientMessageId == clientId && m.isLocal)
        .firstOrNull;
    if (bubble == null) return;

    final result = await _send.execute(
      ticketId: _ticketId,
      clientMessageId: clientId,
      body: bubble.body,
      attachments: _pending[clientId] ?? const [],
    );

    await result.fold(
      (failure) async {
        if (failure.code == 'TICKET_RESOLVED') {
          // Resolved while the member was typing. Drop the bubble — it can
          // never be delivered — and refetch so the composer locks.
          emit(
            state.copyWith(
              messages: state.messages.without(clientId),
              message: failure.message,
            ),
          );
          _pending.remove(clientId);
          await _refreshTicket(emit);
          return;
        }
        emit(
          state.copyWith(
            messages: state.messages.withDelivery(
              clientId,
              MessageDelivery.failed,
            ),
            message: failure.message,
          ),
        );
      },
      (message) async {
        _pending.remove(clientId);
        emit(state.copyWith(messages: state.messages.withDelivered(message)));
      },
    );
  }

  Future<void> _refreshTicket(Emitter<TicketChatState> emit) async {
    final result = await _getTicket.execute(_ticketId);
    result.fold((_) {}, (t) => emit(state.copyWith(ticket: t)));
  }

  Future<void> _pick(
    File file,
    String? pickedName,
    Emitter<TicketChatState> emit,
  ) async {
    final name = pickedName ?? file.uri.pathSegments.last;
    final size = await file.length();
    final problem = UploadRules.check(
      fileName: name,
      sizeBytes: size,
      currentCount: state.drafts.length,
    );
    if (problem != null) {
      emit(state.copyWith(message: problem));
      return;
    }

    final id = TicketChatBloc._uuid.v4();
    emit(
      state.copyWith(
        drafts: [
          ...state.drafts,
          TicketAttachmentDraft(
            id: id,
            fileName: name,
            sizeBytes: size,
            localPath: file.path,
            status: DraftStatus.uploading,
          ),
        ],
      ),
    );

    final result = await _upload.execute(file, fileName: name);
    // Read `state.drafts` now, not before the await — other uploads and a
    // send may have landed meanwhile.
    emit(
      state.copyWith(
        drafts: [
          for (final d in state.drafts)
            if (d.id != id)
              d
            else
              result.fold(
                (f) => d.copyWith(status: DraftStatus.failed, error: f.message),
                (u) => d.copyWith(status: DraftStatus.uploaded, upload: u),
              ),
        ],
      ),
    );
  }

  Future<void> _openAttachment(
    String attachmentId,
    Completer<String?> result,
    Emitter<TicketChatState> emit,
  ) async {
    final fetched = await _refreshUrl.execute(
      ticketId: _ticketId,
      attachmentId: attachmentId,
    );
    fetched.fold(
      (failure) {
        emit(state.copyWith(message: failure.message));
        result.complete(null);
      },
      (url) {
        TicketAttachmentModel patch(TicketAttachmentModel a) =>
            a.id == attachmentId ? a.withUrl(url) : a;
        final ticket = state.ticket;
        emit(
          state.copyWith(
            messages: [
              for (final m in state.messages)
                m.copyWith(attachments: m.attachments.map(patch).toList()),
            ],
            ticket: ticket?.copyWith(
              attachments: ticket.attachments.map(patch).toList(),
            ),
          ),
        );
        result.complete(url);
      },
    );
  }

  Future<void> _submitRating(
    int rating,
    String? comment,
    Emitter<TicketChatState> emit,
  ) async {
    final ticket = state.ticket;
    if (ticket == null || !ticket.canRate) return;
    emit(state.copyWith(rating: RequestState.loading, message: ''));
    final result = await _rate.execute(
      ticketId: _ticketId,
      rating: rating,
      comment: comment,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(rating: RequestState.error, message: failure.message),
      ),
      (updated) =>
          emit(state.copyWith(rating: RequestState.loaded, ticket: updated)),
    );
  }
}
