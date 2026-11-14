import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/error_handler.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/data/datasource/transactions_remote_datasource.dart';
import 'package:finskool/src/domain/model/transaction/transactions_page.dart';
import 'package:finskool/src/domain/repository/transactions_repository.dart';

@LazySingleton(as: TransactionsRepository)
class TransactionsRepositoryImpl implements TransactionsRepository {
  TransactionsRepositoryImpl(this._source);

  final TransactionsRemoteDatasource _source;

  @override
  Future<Either<Failure, TransactionsPage>> getTransactions(int page) =>
      handleErrors(() => _source.getPage(page));
}
