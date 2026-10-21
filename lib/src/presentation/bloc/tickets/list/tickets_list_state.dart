part of 'tickets_list_bloc.dart';

@freezed
sealed class TicketsListState with _$TicketsListState {
  const factory TicketsListState({
    required RequestState state,

    /// The last failure's copy. A failed *extra page* raises it as a
    /// snackbar without blanking the list already on screen.
    required String message,
    required List<TicketModel> tickets,
    required bool isLoadingMore,
    String? nextCursor,
    TicketStatus? filter,
  }) = _TicketsListState;

  const TicketsListState._();

  factory TicketsListState.initial() => const TicketsListState(
    state: RequestState.empty,
    message: '',
    tickets: [],
    isLoadingMore: false,
  );

  bool get hasMore => nextCursor != null;

  /// What the list shows under the selected chip.
  List<TicketModel> get visible => filter == null
      ? tickets
      : tickets.where((t) => t.status == filter).toList();

  /// Loaded fine, and the member genuinely has none — the "No tickets yet"
  /// screen. Distinct from a filter that happens to match nothing.
  bool get isEmptyForReal => state.isLoaded && tickets.isEmpty;

  /// Chip counts are exact only once every page is in: the API has no counts
  /// endpoint, so with more pages to come a count would silently undercount.
  /// The chips drop their numbers until then rather than show a wrong one.
  bool get countsAreExact => state.isLoaded && !hasMore;

  int countFor(TicketStatus? status) => status == null
      ? tickets.length
      : tickets.countWhere((t) => t.status == status);
}
