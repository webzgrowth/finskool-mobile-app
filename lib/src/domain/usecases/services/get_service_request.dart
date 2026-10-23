import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/repository/services_repository.dart';
import 'package:finskool/src/domain/model/service/service_request_model.dart';

/// One request. Anything that is not the member's is a 404.
@lazySingleton
class GetServiceRequest {
  GetServiceRequest(this._repository);
  final ServicesRepository _repository;

  Future<Either<Failure, ServiceRequestModel>> execute(String id) =>
      _repository.getRequest(id);
}
