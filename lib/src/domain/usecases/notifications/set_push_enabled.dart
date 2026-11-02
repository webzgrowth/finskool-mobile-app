import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/repository/notifications_repository.dart';

/// Flips the push master switch; resolves to the server's value.
@lazySingleton
class SetPushEnabled {
  SetPushEnabled(this._repository);

  final NotificationsRepository _repository;

  Future<Either<Failure, bool>> execute(bool enabled) =>
      _repository.setPushEnabled(enabled);
}
