import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/repository/notifications_repository.dart';

/// Marks every inbox row read.
@lazySingleton
class MarkAllNotificationsRead {
  MarkAllNotificationsRead(this._repository);

  final NotificationsRepository _repository;

  Future<Either<Failure, Unit>> execute() => _repository.markAllRead();
}
