import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/ticket/ticket_attachment_model.dart';
import 'package:finskool/src/domain/model/ticket/ticket_enums.dart';
import 'package:finskool/src/domain/model/ticket/ticket_model.dart';
import 'package:finskool/src/domain/repository/tickets_repository.dart';

/// Raise a ticket.
///
/// [idempotencyKey] is generated **when the form opens** and reused on every
/// retry of that submission. A repeated key returns the original ticket and
/// creates nothing, which is what makes a double tap or a retry after a
/// dropped network safe. Without the header the API answers
/// `400 IDEMPOTENCY_KEY_REQUIRED`.
@lazySingleton
class CreateTicket {
  CreateTicket(this._repository);
  final TicketsRepository _repository;

  Future<Either<Failure, TicketModel>> execute({
    required String idempotencyKey,
    required String communityId,
    required TicketCategory category,
    required TicketType type,
    required String subject,
    required String description,
    List<TicketUploadModel> attachments = const [],
  }) => _repository.createTicket(
    idempotencyKey: idempotencyKey,
    communityId: communityId,
    category: category,
    type: type,
    subject: subject,
    description: description,
    attachments: attachments,
  );
}
