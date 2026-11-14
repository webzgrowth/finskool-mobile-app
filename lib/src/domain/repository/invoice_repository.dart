import 'package:dartz/dartz.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/community/invoice_file.dart';

/// Subscription invoices. Implemented by
/// `data/repository/invoice_repository_impl.dart`.
abstract class InvoiceRepository {
  /// The invoice's PDF, fetched fresh. Never cache it: the signed link it comes
  /// from lives only a few minutes.
  Future<Either<Failure, InvoiceFile>> download(String invoiceId);

  /// The same, for the `downloadPath` the server gave a transaction.
  Future<Either<Failure, InvoiceFile>> downloadFromPath(String path);
}
