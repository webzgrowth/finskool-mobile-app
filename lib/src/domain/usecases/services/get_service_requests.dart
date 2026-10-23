import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/repository/services_repository.dart';
import 'package:finskool/src/domain/model/service/service_request_model.dart';

/// One cursor-paged page of the member's requests, newest activity first.
@lazySingleton
class GetServiceRequests {
  GetServiceRequests(this._repository);
  final ServicesRepository _repository;

  Future<Either<Failure, ServiceRequestPage>> execute({
    ServiceStatus? status,
    String? cursor,
  }) => _repository.getRequests(status: status, cursor: cursor);
}
