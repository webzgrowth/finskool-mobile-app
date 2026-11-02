import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/notification/app_notification.dart';
import 'package:finskool/src/domain/repository/notifications_repository.dart';

/// One page of the inbox, newest first.
@lazySingleton
class GetNotifications {
  GetNotifications(this._repository);

  final NotificationsRepository _repository;

  Future<Either<Failure, NotificationsPage>> execute(int page) =>
      _repository.getPage(page);
}
