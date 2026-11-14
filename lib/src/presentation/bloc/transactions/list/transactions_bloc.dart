import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/comman/min_skeleton.dart';
import 'package:finskool/src/domain/model/transaction/transaction_model.dart';
import 'package:finskool/src/domain/usecases/transactions/get_transactions.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';
part 'transactions_bloc.freezed.dart';

/// The member's payment history.
///
/// **`@injectable`, route-scoped** on the Transactions screen, like
/// `TicketsListBloc`: it holds one member's payments, so it must not outlive
/// the screen (or the session) the way a singleton would.
@injectable
class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  TransactionsBloc(this._get) : super(TransactionsState.initial()) {
    on<TransactionsEvent>((event, emit) async {
      await event.map(
        load: (_) => _load(emit, quiet: false),
        refresh: (_) => _load(emit, quiet: true),
      );
    });
  }

  final GetTransactions _get;

  /// [quiet] re-reads without the skeleton (pull-to-refresh), and a failure
  /// then keeps the rows already on screen.
  Future<void> _load(
    Emitter<TransactionsState> emit, {
    required bool quiet,
  }) async {
    if (!quiet) emit(state.copyWith(state: RequestState.loading, message: ''));
    final result = quiet
        ? await _get.execute()
        : await holdSkeletonOnFailure(_get.execute);
    emit(
      result.fold(
        (failure) => quiet
            ? state.copyWith(message: failure.message)
            : state.copyWith(
                state: RequestState.error,
                message: failure.message,
              ),
        (rows) => state.copyWith(
          state: RequestState.loaded,
          message: '',
          transactions: rows,
        ),
      ),
    );
  }
}
