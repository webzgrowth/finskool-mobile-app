import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/repository/tickets_repository.dart';

import 'package:finskool/src/domain/model/ticket/ticket_model.dart';

/// One ticket. A ticket that isn't the member's, or an id that isn't valid,
/// comes back **404 rather than 403** — so treat it as "gone" and close the
/// screen.
@lazySingleton
class GetTicket {
  GetTicket(this._repository);
  final TicketsRepository _repository;

  Future<Either<Failure, TicketModel>> execute(String ticketId) =>
      _repository.getTicket(ticketId);
}
