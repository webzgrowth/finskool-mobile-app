import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/repository/tickets_repository.dart';

/// One page of chat history, **newest first** — reverse it for display.
@lazySingleton
class GetTicketHistory {
  GetTicketHistory(this._repository);
  final TicketsRepository _repository;

  Future<Either<Failure, TicketHistoryPage>> execute({
    required String ticketId,
    String? before,
  }) => _repository.getHistory(ticketId: ticketId, before: before);
}
