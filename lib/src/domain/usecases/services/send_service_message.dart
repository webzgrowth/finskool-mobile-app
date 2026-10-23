import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/repository/services_repository.dart';
import 'package:finskool/src/domain/model/ticket/ticket_attachment_model.dart';
import 'package:finskool/src/domain/model/ticket/ticket_message_model.dart';

/// Sends a chat message over the socket. [clientMessageId] is reused on retry.
@lazySingleton
class SendServiceMessage {
  SendServiceMessage(this._repository);
  final ServicesRepository _repository;

  Future<Either<Failure, TicketMessageModel>> execute({
    required String requestId,
    required String clientMessageId,
    String? body,
    List<TicketUploadModel> attachments = const [],
  }) => _repository.sendMessage(
    requestId: requestId,
    clientMessageId: clientMessageId,
    body: body,
    attachments: attachments,
  );
}
