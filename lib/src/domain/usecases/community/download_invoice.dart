import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/community/invoice_file.dart';
import 'package:finskool/src/domain/repository/invoice_repository.dart';

/// Downloads a subscription invoice's PDF.
@lazySingleton
class DownloadInvoice {
  DownloadInvoice(this._repository);

  final InvoiceRepository _repository;

  Future<Either<Failure, InvoiceFile>> execute(String invoiceId) =>
      _repository.download(invoiceId);

  Future<Either<Failure, InvoiceFile>> fromPath(String path) =>
      _repository.downloadFromPath(path);
}
