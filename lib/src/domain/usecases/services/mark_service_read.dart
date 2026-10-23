import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/repository/services_repository.dart';

/// Marks a request read; returns the new unread count.
@lazySingleton
class MarkServiceRead {
  MarkServiceRead(this._repository);
  final ServicesRepository _repository;

  Future<Either<Failure, int>> execute(String requestId) =>
      _repository.markRead(requestId);
}
