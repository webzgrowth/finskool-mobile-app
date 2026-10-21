import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/repository/tickets_repository.dart';

import 'package:finskool/src/domain/model/ticket/ticket_enums.dart';
import 'package:finskool/src/domain/model/ticket/ticket_page_model.dart';

/// One cursor-paged page of the member's tickets, newest activity first.
@lazySingleton
class GetTickets {
  GetTickets(this._repository);
  final TicketsRepository _repository;

  Future<Either<Failure, TicketPageModel>> execute({
    TicketStatus? status,
    String? cursor,
  }) => _repository.getTickets(status: status, cursor: cursor);
}
