import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/service/service_payment_model.dart';
import 'package:finskool/src/domain/repository/invoice_repository.dart';

/// A fresh link to a subscription invoice's PDF.
@lazySingleton
class GetInvoiceLink {
  GetInvoiceLink(this._repository);

  final InvoiceRepository _repository;

  Future<Either<Failure, InvoiceLink>> execute(String invoiceId) =>
      _repository.getDownloadLink(invoiceId);
}
