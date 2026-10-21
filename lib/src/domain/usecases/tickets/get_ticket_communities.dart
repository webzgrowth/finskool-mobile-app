import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/repository/tickets_repository.dart';

import 'package:finskool/src/domain/model/ticket/ticket_page_model.dart';

/// The communities this member may raise a ticket against. An **empty list
/// means they cannot raise one at all** — disable the form.
@lazySingleton
class GetTicketCommunities {
  GetTicketCommunities(this._repository);
  final TicketsRepository _repository;

  Future<Either<Failure, List<TicketCommunityModel>>> execute() =>
      _repository.getCommunities();
}
