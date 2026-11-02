import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/error_handler.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/data/datasource/notifications_remote_datasource.dart';
import 'package:finskool/src/domain/model/notification/app_notification.dart';
import 'package:finskool/src/domain/repository/notifications_repository.dart';

@LazySingleton(as: NotificationsRepository)
class NotificationsRepositoryImpl implements NotificationsRepository {
  NotificationsRepositoryImpl(this._remote);

  final NotificationsRemoteDatasource _remote;

  @override
  Future<Either<Failure, NotificationsPage>> getPage(int page) =>
      handleErrors(() => _remote.getPage(page));

  @override
  Future<Either<Failure, int>> getUnreadCount() =>
      handleErrors(_remote.getUnreadCount);

  @override
  Future<Either<Failure, Unit>> markRead(String id) => handleErrors(() async {
    await _remote.markRead(id);
    return unit;
  });

  @override
  Future<Either<Failure, Unit>> markAllRead() => handleErrors(() async {
    await _remote.markAllRead();
    return unit;
  });

  @override
  Future<Either<Failure, bool>> getPushEnabled() =>
      handleErrors(_remote.getPushEnabled);

  @override
  Future<Either<Failure, bool>> setPushEnabled(bool enabled) =>
      handleErrors(() => _remote.setPushEnabled(enabled));
}
