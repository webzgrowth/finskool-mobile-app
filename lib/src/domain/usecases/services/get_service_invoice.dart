import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/repository/services_repository.dart';
import 'package:finskool/src/domain/model/community/invoice_file.dart';

/// The GST invoice PDF, downloaded from its short-lived signed link.
@lazySingleton
class GetServiceInvoice {
  GetServiceInvoice(this._repository);
  final ServicesRepository _repository;

  Future<Either<Failure, InvoiceFile>> execute(String requestId) =>
      _repository.getInvoice(requestId);
}
