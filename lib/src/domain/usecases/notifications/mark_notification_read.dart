import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/repository/notifications_repository.dart';

/// Marks one inbox row read.
@lazySingleton
class MarkNotificationRead {
  MarkNotificationRead(this._repository);

  final NotificationsRepository _repository;

  Future<Either<Failure, Unit>> execute(String id) => _repository.markRead(id);
}
