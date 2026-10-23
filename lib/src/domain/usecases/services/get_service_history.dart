import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/repository/services_repository.dart';

/// One page of chat history, **newest first**.
@lazySingleton
class GetServiceHistory {
  GetServiceHistory(this._repository);
  final ServicesRepository _repository;

  Future<Either<Failure, ServiceHistoryPage>> execute({
    required String requestId,
    String? before,
  }) => _repository.getHistory(requestId: requestId, before: before);
}
