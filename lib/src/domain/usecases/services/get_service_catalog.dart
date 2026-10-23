import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/repository/services_repository.dart';
import 'package:finskool/src/domain/model/service/service_model.dart';

/// The active services, sorted by title.
@lazySingleton
class GetServiceCatalog {
  GetServiceCatalog(this._repository);
  final ServicesRepository _repository;

  Future<Either<Failure, List<ServiceModel>>> execute() =>
      _repository.getCatalog();
}
