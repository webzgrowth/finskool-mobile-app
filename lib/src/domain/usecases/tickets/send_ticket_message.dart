import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/repository/tickets_repository.dart';

import 'package:finskool/src/domain/model/ticket/ticket_attachment_model.dart';
import 'package:finskool/src/domain/model/ticket/ticket_message_model.dart';

/// Send a chat message over the socket.
///
/// [clientMessageId] is generated once per message and **reused on every
/// retry**: the server stores each `(ticket, clientMessageId)` once, so a
/// resend after a timeout returns the original rather than posting twice.
@lazySingleton
class SendTicketMessage {
  SendTicketMessage(this._repository);
  final TicketsRepository _repository;

  Future<Either<Failure, TicketMessageModel>> execute({
    required String ticketId,
    required String clientMessageId,
    String? body,
    List<TicketUploadModel> attachments = const [],
  }) => _repository.sendMessage(
    ticketId: ticketId,
    clientMessageId: clientMessageId,
    body: body,
    attachments: attachments,
  );
}
