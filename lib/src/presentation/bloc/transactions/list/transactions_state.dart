part of 'transactions_bloc.dart';

@freezed
sealed class TransactionsState with _$TransactionsState {
  const factory TransactionsState({
    @Default(RequestState.empty) RequestState state,

    /// The server's own words for a failure.
    @Default('') String message,
    @Default(<TransactionModel>[]) List<TransactionModel> transactions,

    /// The last page held (1-based) and whether the server has another.
    @Default(0) int page,
    @Default(false) bool hasMore,
    @Default(false) bool isLoadingMore,
    @Default(false) bool isRefreshing,
  }) = _TransactionsState;

  factory TransactionsState.initial() => const TransactionsState();
}
