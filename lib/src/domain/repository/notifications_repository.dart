import 'package:dartz/dartz.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/notification/app_notification.dart';

/// The notification inbox and the push master switch.
abstract class NotificationsRepository {
  Future<Either<Failure, NotificationsPage>> getPage(int page);

  Future<Either<Failure, int>> getUnreadCount();

  Future<Either<Failure, Unit>> markRead(String id);

  Future<Either<Failure, Unit>> markAllRead();

  Future<Either<Failure, bool>> getPushEnabled();

  /// Returns the server's resulting value.
  Future<Either<Failure, bool>> setPushEnabled(bool enabled);
}
