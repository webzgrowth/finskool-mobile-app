import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/repository/tickets_repository.dart';

import 'package:finskool/src/domain/model/ticket/ticket_model.dart';

/// Rate a resolved ticket. **Once, and final** — a second attempt is
/// refused with `ALREADY_RATED`, and rating before resolution with
/// `TICKET_NOT_RESOLVED`.
@lazySingleton
class RateTicket {
  RateTicket(this._repository);
  final TicketsRepository _repository;

  Future<Either<Failure, TicketModel>> execute({
    required String ticketId,
    required int rating,
    String? comment,
  }) => _repository.rateTicket(
    ticketId: ticketId,
    rating: rating,
    comment: comment,
  );
}
