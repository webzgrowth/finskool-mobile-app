import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/repository/services_repository.dart';

/// Unread replies across every request — the Services bell's badge.
@lazySingleton
class GetServiceUnreadCount {
  GetServiceUnreadCount(this._repository);
  final ServicesRepository _repository;

  Future<Either<Failure, int>> execute() => _repository.getUnreadCount();
}
