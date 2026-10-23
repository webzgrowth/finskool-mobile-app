part of 'service_chat_bloc.dart';

extension ServiceChatHandlers on ServiceChatBloc {
  Future<void> _start(String id, Emitter<ServiceChatState> emit) async {
    _requestId = id;
    emit(
      state.copyWith(
        state: RequestState.loading,
        socket: _socket.currentStatus,
      ),
    );
    _socket.connect();

    final result = await _getRequest.execute(id);
    final request = result.fold((_) => null, (r) => r);
    if (request == null) {
      emit(
        state.copyWith(
          state: RequestState.error,
          message: result.fold((f) => f.message, (_) => ''),
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        state: RequestState.loaded,
        request: request,
        quotes: _withRequestQuote(state.quotes, request),
      ),
    );
    await _socket.whenLive();
    await _loadLatest(emit);
  }

  /// The request's own quote is always known, even if its card is on an older
  /// history page.
  Map<String, ServiceQuoteModel> _withRequestQuote(
    Map<String, ServiceQuoteModel> quotes,
    ServiceRequestModel request,
  ) {
    final q = request.quote;
    return q == null ? quotes : {...quotes, q.id: q};
  }

  Future<void> _loadLatest(Emitter<ServiceChatState> emit) async {
    final result = await _getHistory.execute(requestId: _requestId);
    final page = result.fold((_) => null, (p) => p);
    if (page == null) return; // the reconnect resync will try again
    _historyLoaded = true;
    emit(
      state.copyWith(
        messages: state.messages.mergedWithLatest(page.items),
        quotes: {...state.quotes, ...page.quotes},
        historyCursor: state.messages.isEmpty
            ? page.nextCursor
            : state.historyCursor,
      ),
    );
    await _markReadNow(emit);
  }

  Future<void> _markReadNow(Emitter<ServiceChatState> emit) async {
    final request = state.request;
    if (request == null || request.unreadCount == 0) return;
    final result = await _markRead.execute(_requestId);
    result.fold(
      (_) {},
      (_) => emit(state.copyWith(request: request.copyWith(unreadCount: 0))),
    );
  }

  Future<void> _loadEarlier(Emitter<ServiceChatState> emit) async {
    if (!state.hasEarlier || state.isLoadingEarlier) return;
    emit(state.copyWith(isLoadingEarlier: true));
    final result = await _getHistory.execute(
      requestId: _requestId,
      before: state.historyCursor,
    );
    result.fold(
      (f) => emit(state.copyWith(isLoadingEarlier: false, message: f.message)),
      (page) => emit(
        state.copyWith(
          isLoadingEarlier: false,
          messages: state.messages.withEarlier(page.items),
          quotes: {...page.quotes, ...state.quotes},
          historyCursor: page.nextCursor,
        ),
      ),
    );
  }

  Future<void> _sendText(String text, Emitter<ServiceChatState> emit) async {
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
    // Minted once; **reused on every retry**, so the server posts it once.
    final clientId = ServiceChatBloc._uuid.v4();
    _pending[clientId] = uploads;
    emit(
      state.copyWith(
        drafts: const [],
        messages: state.messages.withOptimistic(
          TicketMessageModel(
            id: 'local-$clientId',
            ticketId: _requestId,
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

  Future<void> _retry(String clientId, Emitter<ServiceChatState> emit) async {
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

  Future<void> _deliver(String clientId, Emitter<ServiceChatState> emit) async {
    final bubble = state.messages
        .where((m) => m.clientMessageId == clientId && m.isLocal)
        .firstOrNull;
    if (bubble == null) return;
    final result = await _send.execute(
      requestId: _requestId,
      clientMessageId: clientId,
      body: bubble.body,
      attachments: _pending[clientId] ?? const [],
    );
    await result.fold(
      (failure) async {
        if (failure.code == 'SERVICE_CLOSED') {
          // Closed while the member was typing: it can never be delivered.
          emit(
            state.copyWith(
              messages: state.messages.without(clientId),
              message: failure.message,
            ),
          );
          _pending.remove(clientId);
          await _refreshRequest(emit);
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

  Future<void> _refreshRequest(Emitter<ServiceChatState> emit) async {
    final result = await _getRequest.execute(_requestId);
    result.fold(
      (_) {},
      (r) => emit(
        state.copyWith(request: r, quotes: _withRequestQuote(state.quotes, r)),
      ),
    );
  }

  void _applyPaid(ServiceRequestModel request, Emitter<ServiceChatState> emit) {
    emit(
      state.copyWith(
        request: request,
        quotes: _withRequestQuote(state.quotes, request),
      ),
    );
  }

  Future<void> _cancelRequest(Emitter<ServiceChatState> emit) async {
    final request = state.request;
    if (request == null || !request.canCancel) return;
    emit(state.copyWith(cancel: RequestState.loading, message: ''));
    final result = await _cancel.execute(request.id);
    result.fold(
      (f) =>
          emit(state.copyWith(cancel: RequestState.error, message: f.message)),
      (r) => emit(
        state.copyWith(
          cancel: RequestState.loaded,
          request: r,
          // The waiting quote card is withdrawn.
          quotes: {
            for (final e in state.quotes.entries)
              e.key: e.value.isPayable
                  ? e.value.withStatus(ServiceQuoteStatus.cancelled)
                  : e.value,
          },
        ),
      ),
    );
  }

  Future<void> _pick(
    File file,
    String? pickedName,
    Emitter<ServiceChatState> emit,
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
    final id = ServiceChatBloc._uuid.v4();
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
    Emitter<ServiceChatState> emit,
  ) async {
    final fetched = await _refreshUrl.execute(
      requestId: _requestId,
      attachmentId: attachmentId,
    );
    fetched.fold(
      (f) {
        emit(state.copyWith(message: f.message));
        result.complete(null);
      },
      (url) {
        TicketAttachmentModel patch(TicketAttachmentModel a) =>
            a.id == attachmentId ? a.withUrl(url) : a;
        emit(
          state.copyWith(
            messages: [
              for (final m in state.messages)
                m.copyWith(attachments: m.attachments.map(patch).toList()),
            ],
          ),
        );
        result.complete(url);
      },
    );
  }

  Future<void> _submitRating(
    int rating,
    String? comment,
    Emitter<ServiceChatState> emit,
  ) async {
    final request = state.request;
    if (request == null || !request.canRate) return;
    emit(state.copyWith(rating: RequestState.loading, message: ''));
    final result = await _rate.execute(
      requestId: request.id,
      rating: rating,
      comment: comment,
    );
    result.fold(
      (f) =>
          emit(state.copyWith(rating: RequestState.error, message: f.message)),
      (r) => emit(state.copyWith(rating: RequestState.loaded, request: r)),
    );
  }

  Future<void> _openInvoice(
    Completer<InvoiceLink?> result,
    Emitter<ServiceChatState> emit,
  ) async {
    final fetched = await _invoice.execute(_requestId);
    fetched.fold((f) {
      emit(state.copyWith(message: f.message));
      result.complete(null);
    }, result.complete);
  }
}
