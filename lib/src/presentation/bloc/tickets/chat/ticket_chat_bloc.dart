import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/data/socket/socket_frames.dart';
import 'package:finskool/src/data/socket/tickets_socket.dart';
import 'package:finskool/src/domain/model/ticket/ticket_attachment_model.dart';
import 'package:finskool/src/domain/model/ticket/ticket_enums.dart';
import 'package:finskool/src/domain/model/ticket/ticket_message_model.dart';
import 'package:finskool/src/domain/model/ticket/ticket_model.dart';
import 'package:finskool/src/domain/model/ticket/ticket_summary_model.dart';
import 'package:finskool/src/domain/usecases/tickets/get_ticket.dart';
import 'package:finskool/src/domain/usecases/tickets/get_ticket_history.dart';
import 'package:finskool/src/domain/usecases/tickets/mark_ticket_read.dart';
import 'package:finskool/src/domain/usecases/tickets/rate_ticket.dart';
import 'package:finskool/src/domain/usecases/tickets/refresh_attachment_url.dart';
import 'package:finskool/src/domain/usecases/tickets/send_ticket_message.dart';
import 'package:finskool/src/domain/usecases/tickets/upload_ticket_attachment.dart';
import 'package:finskool/src/presentation/bloc/tickets/form/ticket_attachment_draft.dart';

import 'ticket_message_patch.dart';

part 'ticket_chat_event.dart';
part 'ticket_chat_state.dart';
part 'ticket_chat_handlers.dart';
part 'ticket_chat_live.dart';
part 'ticket_chat_bloc.freezed.dart';

/// One ticket's conversation, over the socket.
///
/// There are **no REST chat endpoints** (§1): history, send and read all go
/// through `TicketsSocket`, so with the socket down the member can neither
/// send nor load — `state.socket` exists to make that visible.
///
/// Route-scoped (`@injectable`): it must not outlive its ticket, and its
/// socket subscriptions are cancelled in [close].
@injectable
class TicketChatBloc extends Bloc<TicketChatEvent, TicketChatState> {
  TicketChatBloc(
    this._getTicket,
    this._getHistory,
    this._send,
    this._markRead,
    this._rate,
    this._upload,
    this._refreshUrl,
    this._socket,
  ) : super(TicketChatState.initial()) {
    on<TicketChatEvent>((event, emit) async {
      await event.map(
        started: (e) => _start(e.ticketId, emit),
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
        rated: (e) => _submitRating(e.rating, e.comment, emit),
        socketEvent: (e) => _onSocketEvent(e.event, emit),
        socketStatus: (e) => _onSocketStatus(e.status, emit),
      );
    });

    _events = _socket.events.listen((e) => add(TicketChatEvent.socketEvent(e)));
    _statusSub = _socket.status.listen(
      (s) => add(TicketChatEvent.socketStatus(s)),
    );
  }

  final GetTicket _getTicket;
  final GetTicketHistory _getHistory;
  final SendTicketMessage _send;
  final MarkTicketRead _markRead;
  final RateTicket _rate;
  final UploadTicketAttachment _upload;
  final RefreshAttachmentUrl _refreshUrl;
  final TicketsSocket _socket;

  static const _uuid = Uuid();

  StreamSubscription<SocketEvent>? _events;
  StreamSubscription<SocketStatus>? _statusSub;
  String _ticketId = '';
  bool _wasOffline = false;
  bool _historyLoaded = false;

  /// Uploads belonging to a bubble that hasn't been confirmed, by
  /// `clientMessageId` — kept so a **retry** can resend the same files.
  final Map<String, List<TicketUploadModel>> _pending = {};

  @override
  Future<void> close() {
    _events?.cancel();
    _statusSub?.cancel();
    return super.close();
  }
}
