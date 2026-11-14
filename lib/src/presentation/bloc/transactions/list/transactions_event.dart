part of 'transactions_bloc.dart';

@freezed
class TransactionsEvent with _$TransactionsEvent {
  /// First load: shows the skeleton.
  const factory TransactionsEvent.load() = _Load;

  /// Pull-to-refresh: keeps the rows on screen while it runs.
  const factory TransactionsEvent.refresh() = _Refresh;

  /// The next page, when the member scrolls near the end.
  const factory TransactionsEvent.loadMore() = _LoadMore;
}
