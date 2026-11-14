import 'package:dartz/dartz.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/transaction/transactions_page.dart';

/// The member's payment history. Implemented by
/// `data/repository/transactions_repository_impl.dart`.
abstract class TransactionsRepository {
  /// One page, newest first (1-based).
  Future<Either<Failure, TransactionsPage>> getTransactions(int page);
}
