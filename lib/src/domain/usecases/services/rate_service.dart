import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/repository/services_repository.dart';
import 'package:finskool/src/domain/model/service/service_request_model.dart';

/// Rates a completed request, once.
@lazySingleton
class RateService {
  RateService(this._repository);
  final ServicesRepository _repository;

  Future<Either<Failure, ServiceRequestModel>> execute({
    required String requestId,
    required int rating,
    String? comment,
  }) =>
      _repository.rate(requestId: requestId, rating: rating, comment: comment);
}
