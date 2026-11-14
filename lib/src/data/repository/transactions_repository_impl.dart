import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/error_handler.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/data/datasource/transactions_demo_datasource.dart';
import 'package:finskool/src/domain/model/transaction/transaction_model.dart';
import 'package:finskool/src/domain/repository/transactions_repository.dart';

@LazySingleton(as: TransactionsRepository)
class TransactionsRepositoryImpl implements TransactionsRepository {
  TransactionsRepositoryImpl(this._source);

  // Swap for a remote datasource when the endpoint exists; the repository's
  // contract does not change.
  final TransactionsDemoDatasource _source;

  @override
  Future<Either<Failure, List<TransactionModel>>> getTransactions() =>
      handleErrors(_source.getTransactions);
}
