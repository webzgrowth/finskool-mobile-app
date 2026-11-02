import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/repository/notifications_repository.dart';

/// The bell's unread count, across every community.
@lazySingleton
class GetNotificationsUnreadCount {
  GetNotificationsUnreadCount(this._repository);

  final NotificationsRepository _repository;

  Future<Either<Failure, int>> execute() => _repository.getUnreadCount();
}
