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

/// The member's payment history, a page at a time.
///
/// **`@injectable`, route-scoped** on the Transactions screen, like
/// `TicketsListBloc`: it holds one member's payments, so it must not outlive
/// the screen (or the session) the way a singleton would.
@injectable
class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  TransactionsBloc(this._get) : super(TransactionsState.initial()) {
    on<TransactionsEvent>((event, emit) async {
      await event.map(
        load: (_) => _first(emit, quiet: false),
        refresh: (_) => _first(emit, quiet: true),
        loadMore: (_) => _more(emit),
      );
    });
  }

  final GetTransactions _get;

  /// Bumped by every load/refresh so a slow "next page" for a list the member
  /// has since reloaded can't be appended to the new one.
  int _generation = 0;

  /// Page 1. [quiet] re-reads without the skeleton (pull-to-refresh), and a
  /// failure then keeps the rows already on screen.
  Future<void> _first(
    Emitter<TransactionsState> emit, {
    required bool quiet,
  }) async {
    final generation = ++_generation;
    emit(
      quiet
          ? state.copyWith(
              isRefreshing: true,
              isLoadingMore: false,
              message: '',
            )
          : state.copyWith(state: RequestState.loading, message: ''),
    );
    final result = quiet
        ? await _get.execute()
        : await holdSkeletonOnFailure(_get.execute);
    if (generation != _generation) return;
    emit(
      result.fold(
        (failure) => quiet
            ? state.copyWith(isRefreshing: false, message: failure.message)
            : state.copyWith(
                state: RequestState.error,
                message: failure.message,
              ),
        (page) => state.copyWith(
          state: RequestState.loaded,
          message: '',
          transactions: page.items,
          page: page.page,
          hasMore: page.hasMore,
          isRefreshing: false,
          isLoadingMore: false,
        ),
      ),
    );
  }

  Future<void> _more(Emitter<TransactionsState> emit) async {
    if (!state.state.isLoaded ||
        !state.hasMore ||
        state.isLoadingMore ||
        state.isRefreshing) {
      return;
    }
    final generation = _generation;
    emit(state.copyWith(isLoadingMore: true, message: ''));
    final result = await _get.execute(page: state.page + 1);
    if (generation != _generation) return;
    emit(
      result.fold(
        // The rows already read stay; the failure is raised as a message.
        (failure) =>
            state.copyWith(isLoadingMore: false, message: failure.message),
        (next) {
          // A payment made meanwhile pushes the rest down a row, so the next
          // page can repeat one the member already has.
          final seen = {for (final t in state.transactions) t.id};
          return state.copyWith(
            transactions: [
              ...state.transactions,
              ...next.items.where((t) => !seen.contains(t.id)),
            ],
            page: next.page,
            hasMore: next.hasMore,
            isLoadingMore: false,
          );
        },
      ),
    );
  }
}
