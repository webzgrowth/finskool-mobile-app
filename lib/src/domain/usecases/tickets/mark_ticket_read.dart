import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/repository/tickets_repository.dart';

/// Zeroes this ticket's unread count, here and on the member's other
/// devices. Call it when the messages are on screen, and again when new
/// admin messages arrive while they're still looking.
@lazySingleton
class MarkTicketRead {
  MarkTicketRead(this._repository);
  final TicketsRepository _repository;

  Future<Either<Failure, int>> execute(String ticketId) =>
      _repository.markRead(ticketId);
}
