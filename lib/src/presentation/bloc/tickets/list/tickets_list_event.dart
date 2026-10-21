part of 'tickets_list_bloc.dart';

@freezed
class TicketsListEvent with _$TicketsListEvent {
  /// First page. Also the retry after a failure.
  const factory TicketsListEvent.load() = _Load;

  /// Re-reads page 1 without blanking the list, so `RefreshIndicator` can
  /// spin over rows already on screen.
  const factory TicketsListEvent.refresh() = _Refresh;

  const factory TicketsListEvent.loadMore() = _LoadMore;

  /// `null` is the "All" chip. Filtering is **client-side** — see
  /// [TicketsListBloc] for why.
  const factory TicketsListEvent.filterChanged(TicketStatus? status) =
      _FilterChanged;

  /// Internal. A `ticket.created` / `.message` / `.updated` summary arrived.
  /// Dispatched by the bloc to itself so the emit happens inside a handler.
  const factory TicketsListEvent.summaryPushed(TicketSummaryModel summary) =
      _SummaryPushed;

  /// Internal. `ticket.read` — read on another device.
  const factory TicketsListEvent.readElsewhere(String ticketId) =
      _ReadElsewhere;
}
