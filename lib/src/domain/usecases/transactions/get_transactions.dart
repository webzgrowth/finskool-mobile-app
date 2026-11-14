import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/transaction/transaction_model.dart';
import 'package:finskool/src/domain/repository/transactions_repository.dart';

/// Profile → Transaction history.
@lazySingleton
class GetTransactions {
  GetTransactions(this._repository);

  final TransactionsRepository _repository;

  Future<Either<Failure, List<TransactionModel>>> execute() =>
      _repository.getTransactions();
}
