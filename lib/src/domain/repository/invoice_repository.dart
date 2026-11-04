import 'package:dartz/dartz.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/service/service_payment_model.dart';

/// Subscription invoices. Implemented by
/// `data/repository/invoice_repository_impl.dart`.
abstract class InvoiceRepository {
  /// A fresh short-lived link to the invoice PDF. Never cache the result.
  Future<Either<Failure, InvoiceLink>> getDownloadLink(String invoiceId);
}
