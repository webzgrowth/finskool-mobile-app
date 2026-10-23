import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/repository/services_repository.dart';
import 'package:finskool/src/domain/model/service/service_payment_model.dart';

/// Every state / UT with its GST code, for the billing sheet.
@lazySingleton
class GetGstStates {
  GetGstStates(this._repository);
  final ServicesRepository _repository;

  Future<Either<Failure, List<GstState>>> execute() =>
      _repository.getGstStates();
}
