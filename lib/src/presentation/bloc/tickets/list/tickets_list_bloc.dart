import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/data/socket/socket_frames.dart';
import 'package:finskool/src/data/socket/tickets_socket.dart';
import 'package:finskool/src/domain/model/ticket/ticket_enums.dart';
import 'package:finskool/src/domain/model/ticket/ticket_model.dart';
import 'package:finskool/src/domain/model/ticket/ticket_summary_model.dart';
import 'package:finskool/src/domain/usecases/tickets/get_tickets.dart';

import 'ticket_list_patch.dart';

part 'tickets_list_event.dart';
part 'tickets_list_state.dart';
part 'tickets_list_bloc.freezed.dart';

/// The My Tickets list, kept current by the socket.
///
/// **Filtering is client-side, deliberately.** The API can filter by status,
/// but it has no counts endpoint, and Figma's chips read "All 4 · Open 1 ·
/// In progress 1 · Resolved 2". Loading everything once is what makes those
/// numbers — and instant chip switching — possible. For a member's ticket
/// volume that is a page or two.
///
/// `@injectable`, not `@singleton`: it belongs to its route, and a fresh
/// instance is what makes returning to the screen refetch.
@injectable
class TicketsListBloc extends Bloc<TicketsListEvent, TicketsListState> {
  TicketsListBloc(this._getTickets, this._socket)
    : super(TicketsListState.initial()) {
    on<TicketsListEvent>((event, emit) async {
      await event.map(
        load: (_) => _loadFirst(emit, blank: true),
        refresh: (_) => _loadFirst(emit, blank: false),
        loadMore: (_) => _loadMore(emit),
        filterChanged: (e) async => emit(state.copyWith(filter: e.status)),
        summaryPushed: (e) async => emit(
          state.copyWith(tickets: state.tickets.applySummary(e.summary)),
        ),
        readElsewhere: (e) async =>
            emit(state.copyWith(tickets: state.tickets.withRead(e.ticketId))),
      );
    });

    _events = _socket.events.listen(_onSocketEvent);
    // Nothing is replayed after a disconnect, so coming back online is the
    // cue to refetch rather than trust what was on screen.
    _statusSub = _socket.status.listen((s) {
      if (s == SocketStatus.live && _wasOffline) {
        add(const TicketsListEvent.refresh());
      }
      _wasOffline = s != SocketStatus.live;
    });
  }

  final GetTickets _getTickets;
  final TicketsSocket _socket;
  StreamSubscription<SocketEvent>? _events;
  StreamSubscription<SocketStatus>? _statusSub;
  bool _wasOffline = false;

  void _onSocketEvent(SocketEvent e) {
    switch (e.event) {
      case 'ticket.created' || 'ticket.message' || 'ticket.updated':
        final raw = e.data['ticket'];
        if (raw is Map<String, dynamic>) {
          add(TicketsListEvent.summaryPushed(TicketSummaryModel.fromJson(raw)));
        }
      case 'ticket.read':
        final id = e.ticketId;
        if (id != null) add(TicketsListEvent.readElsewhere(id));
    }
  }

  Future<void> _loadFirst(
    Emitter<TicketsListState> emit, {
    required bool blank,
  }) async {
    if (blank) emit(state.copyWith(state: RequestState.loading, message: ''));
    final result = await _getTickets.execute();
    result.fold(
      (failure) => emit(
        state.copyWith(
          // A failed *refresh* keeps the rows and just raises the message.
          state: state.tickets.isEmpty
              ? RequestState.error
              : RequestState.loaded,
          message: failure.message,
        ),
      ),
      (page) => emit(
        state.copyWith(
          state: RequestState.loaded,
          message: '',
          tickets: page.items.sortedByActivity(),
          nextCursor: page.nextCursor,
          isLoadingMore: false,
        ),
      ),
    );
  }

  Future<void> _loadMore(Emitter<TicketsListState> emit) async {
    if (!state.hasMore || state.isLoadingMore || !state.state.isLoaded) return;
    emit(state.copyWith(isLoadingMore: true));
    final result = await _getTickets.execute(cursor: state.nextCursor);
    result.fold(
      // Keep the list and the cursor, so scrolling again retries.
      (failure) =>
          emit(state.copyWith(isLoadingMore: false, message: failure.message)),
      (page) => emit(
        state.copyWith(
          tickets: state.tickets.appendPage(page.items),
          nextCursor: page.nextCursor,
          isLoadingMore: false,
          message: '',
        ),
      ),
    );
  }

  @override
  Future<void> close() {
    _events?.cancel();
    _statusSub?.cancel();
    return super.close();
  }
}
