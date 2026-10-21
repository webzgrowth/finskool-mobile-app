import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/repository/tickets_repository.dart';

/// Total unread admin replies across every ticket — the Profile row badge.
@lazySingleton
class GetTicketUnreadCount {
  GetTicketUnreadCount(this._repository);
  final TicketsRepository _repository;

  Future<Either<Failure, int>> execute() => _repository.getUnreadCount();
}
