import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/data/socket/socket_frames.dart';
import 'package:finskool/src/data/socket/tickets_socket.dart';
import 'package:finskool/src/domain/model/service/service_payment_model.dart';
import 'package:finskool/src/domain/model/service/service_quote_model.dart';
import 'package:finskool/src/domain/model/service/service_request_model.dart';
import 'package:finskool/src/domain/model/ticket/ticket_attachment_model.dart';
import 'package:finskool/src/domain/model/ticket/ticket_message_model.dart';
import 'package:finskool/src/domain/repository/services_repository.dart';
import 'package:finskool/src/domain/usecases/services/cancel_service_request.dart';
import 'package:finskool/src/domain/usecases/services/get_service_history.dart';
import 'package:finskool/src/domain/usecases/services/get_service_invoice.dart';
import 'package:finskool/src/domain/usecases/services/get_service_request.dart';
import 'package:finskool/src/domain/usecases/services/mark_service_read.dart';
import 'package:finskool/src/domain/usecases/services/rate_service.dart';
import 'package:finskool/src/domain/usecases/services/refresh_service_attachment_url.dart';
import 'package:finskool/src/domain/usecases/services/send_service_message.dart';
import 'package:finskool/src/domain/usecases/services/upload_service_attachment.dart';
import 'package:finskool/src/presentation/bloc/tickets/chat/ticket_message_patch.dart';
import 'package:finskool/src/presentation/bloc/tickets/form/ticket_attachment_draft.dart';

part 'service_chat_event.dart';
part 'service_chat_state.dart';
part 'service_chat_handlers.dart';
part 'service_chat_live.dart';
part 'service_chat_bloc.freezed.dart';

/// One service request's conversation, over the socket — including its quote
/// cards.
///
/// It reuses the ticket chat's list logic (`TicketMessagePatch`) and message
/// model on purpose: a service message is a ticket message plus, for
/// `kind: "quote"`, a `quoteId`. The quotes themselves live in
/// [ServiceChatState.quotes], keyed by id, so a card's `status` can change
/// (replaced, expired, paid) without rewriting the message list.
///
/// Route-scoped (`@injectable`): it must not outlive its request.
@injectable
class ServiceChatBloc extends Bloc<ServiceChatEvent, ServiceChatState> {
  ServiceChatBloc(
    this._getRequest,
    this._getHistory,
    this._send,
    this._markRead,
    this._cancel,
    this._rate,
    this._upload,
    this._refreshUrl,
    this._invoice,
    this._socket,
  ) : super(ServiceChatState.initial()) {
    on<ServiceChatEvent>((event, emit) async {
      await event.map(
        started: (e) => _start(e.requestId, emit),
        loadEarlier: (_) => _loadEarlier(emit),
        sent: (e) => _sendText(e.text, emit),
        retried: (e) => _retry(e.clientMessageId, emit),
        attachmentPicked: (e) => _pick(e.file, e.name, emit),
        attachmentRemoved: (e) async => emit(
          state.copyWith(
            drafts: state.drafts.where((d) => d.id != e.draftId).toList(),
          ),
        ),
        attachmentOpened: (e) =>
            _openAttachment(e.attachmentId, e.result, emit),
        cancelled: (_) => _cancelRequest(emit),
        rated: (e) => _submitRating(e.rating, e.comment, emit),
        invoiceRequested: (e) => _openInvoice(e.result, emit),
        refreshed: (_) => _refreshRequest(emit),
        paid: (e) async => _applyPaid(e.request, emit),
        socketEvent: (e) => _onSocketEvent(e.event, emit),
        socketStatus: (e) => _onSocketStatus(e.status, emit),
      );
    });

    _events = _socket.events.listen(
      (e) => add(ServiceChatEvent.socketEvent(e)),
    );
    _statusSub = _socket.status.listen(
      (s) => add(ServiceChatEvent.socketStatus(s)),
    );
  }

  final GetServiceRequest _getRequest;
  final GetServiceHistory _getHistory;
  final SendServiceMessage _send;
  final MarkServiceRead _markRead;
  final CancelServiceRequest _cancel;
  final RateService _rate;
  final UploadServiceAttachment _upload;
  final RefreshServiceAttachmentUrl _refreshUrl;
  final GetServiceInvoice _invoice;
  final TicketsSocket _socket;

  static const _uuid = Uuid();

  StreamSubscription<SocketEvent>? _events;
  StreamSubscription<SocketStatus>? _statusSub;
  String _requestId = '';
  bool _wasOffline = false;
  bool _historyLoaded = false;

  /// Uploads belonging to an unconfirmed bubble, by `clientMessageId`, so a
  /// **retry** resends the same files.
  final Map<String, List<TicketUploadModel>> _pending = {};

  @override
  Future<void> close() {
    _events?.cancel();
    _statusSub?.cancel();
    return super.close();
  }
}
