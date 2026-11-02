import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/repository/notifications_repository.dart';

/// The push master switch.
@lazySingleton
class GetPushEnabled {
  GetPushEnabled(this._repository);

  final NotificationsRepository _repository;

  Future<Either<Failure, bool>> execute() => _repository.getPushEnabled();
}
