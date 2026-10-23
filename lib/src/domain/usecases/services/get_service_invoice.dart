import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/repository/services_repository.dart';
import 'package:finskool/src/domain/model/service/service_payment_model.dart';

/// A short-lived signed link to the GST invoice PDF.
@lazySingleton
class GetServiceInvoice {
  GetServiceInvoice(this._repository);
  final ServicesRepository _repository;

  Future<Either<Failure, InvoiceLink>> execute(String requestId) =>
      _repository.getInvoice(requestId);
}
