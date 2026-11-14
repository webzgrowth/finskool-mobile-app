import 'package:dartz/dartz.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/transaction/transaction_model.dart';

/// The member's payment history. Implemented by
/// `data/repository/transactions_repository_impl.dart`.
abstract class TransactionsRepository {
  /// Newest first.
  Future<Either<Failure, List<TransactionModel>>> getTransactions();
}
