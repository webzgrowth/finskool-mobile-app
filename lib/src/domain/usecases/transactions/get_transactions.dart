import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/transaction/transactions_page.dart';
import 'package:finskool/src/domain/repository/transactions_repository.dart';

/// Profile → Transaction history: one page of the member's payments.
@lazySingleton
class GetTransactions {
  GetTransactions(this._repository);

  final TransactionsRepository _repository;

  Future<Either<Failure, TransactionsPage>> execute({int page = 1}) =>
      _repository.getTransactions(page);
}
