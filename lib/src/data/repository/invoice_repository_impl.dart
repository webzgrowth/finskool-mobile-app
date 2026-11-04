import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/error_handler.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/data/datasource/invoice_remote_datasource.dart';
import 'package:finskool/src/domain/model/community/invoice_file.dart';
import 'package:finskool/src/domain/repository/invoice_repository.dart';

@LazySingleton(as: InvoiceRepository)
class InvoiceRepositoryImpl implements InvoiceRepository {
  InvoiceRepositoryImpl(this._remote);

  final InvoiceRemoteDatasource _remote;

  @override
  Future<Either<Failure, InvoiceFile>> download(String invoiceId) =>
      handleErrors(() => _remote.download(invoiceId));
}
