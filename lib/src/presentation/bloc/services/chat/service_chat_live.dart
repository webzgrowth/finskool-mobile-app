part of 'service_chat_bloc.dart';

/// The socket-driven half: pushed events and connection changes.
extension ServiceChatLive on ServiceChatBloc {
  Future<void> _onSocketEvent(
    SocketEvent e,
    Emitter<ServiceChatState> emit,
  ) async {
    // The socket carries every request's traffic; this bloc owns one.
    final id = e.requestId ?? (e.data['request'] as Map?)?['id'];
    if (_requestId.isEmpty || id != _requestId) return;
    final request = state.request;

    switch (e.event) {
      case 'service.message':
        final raw = e.data['message'];
        if (raw is! Map<String, dynamic>) return;
        final message = serviceMessageFromJson(raw);
        var quotes = {
          ...state.quotes,
          ...quotesIn([raw]),
        };
        // A new quote card **disables the one it replaced**.
        final old = e.data['supersededQuoteId'];
        if (old is String && quotes[old] != null) {
          quotes[old] = quotes[old]!.withStatus(ServiceQuoteStatus.superseded);
        }
        emit(
          state.copyWith(
            // Also the second arrival of the member's own send; the ack
            // placed it and `withDelivered` makes this a no-op.
            messages: state.messages.withDelivered(message),
            quotes: quotes,
            request: _merged(request, e.data['request']),
          ),
        );
        if (!message.isMine) await _markReadNow(emit);

      case 'service.updated':
        final next = _merged(request, e.data['request']);
        emit(
          state.copyWith(
            request: next,
            quotes: next == null
                ? state.quotes
                : _withRequestQuote(state.quotes, next),
          ),
        );
        // The summary has no invoice id; a request just paid needs the full
        // one for the invoice action.
        if (next != null && next.isPaid && (next.invoice?.id ?? '').isEmpty) {
          await _refreshRequest(emit);
        }

      case 'service.read':
        if (request != null) {
          emit(state.copyWith(request: request.copyWith(unreadCount: 0)));
        }
    }
  }

  ServiceRequestModel? _merged(ServiceRequestModel? request, Object? summary) {
    if (request == null || summary is! Map<String, dynamic>) return request;
    return request.mergedWithSummary(summary);
  }

  Future<void> _onSocketStatus(
    SocketStatus status,
    Emitter<ServiceChatState> emit,
  ) async {
    emit(state.copyWith(socket: status));
    final cameBack =
        status == SocketStatus.live && (_wasOffline || !_historyLoaded);
    _wasOffline = status != SocketStatus.live;
    // Nothing is replayed after a disconnect: refetch the request and the
    // latest page, and merge them in.
    if (cameBack && state.request != null) {
      await _refreshRequest(emit);
      await _loadLatest(emit);
    }
  }
}
