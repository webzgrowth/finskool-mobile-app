part of 'transactions_bloc.dart';

@freezed
sealed class TransactionsState with _$TransactionsState {
  const factory TransactionsState({
    @Default(RequestState.empty) RequestState state,

    /// The server's own words for a failure.
    @Default('') String message,
    @Default(<TransactionModel>[]) List<TransactionModel> transactions,
  }) = _TransactionsState;

  factory TransactionsState.initial() => const TransactionsState();
}
