import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/repository/services_repository.dart';
import 'package:finskool/src/domain/model/service/service_request_model.dart';

/// The member backs out **before paying**.
@lazySingleton
class CancelServiceRequest {
  CancelServiceRequest(this._repository);
  final ServicesRepository _repository;

  Future<Either<Failure, ServiceRequestModel>> execute(String id) =>
      _repository.cancel(id);
}
