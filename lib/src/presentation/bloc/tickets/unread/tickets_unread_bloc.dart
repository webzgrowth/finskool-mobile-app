import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/data/socket/socket_frames.dart';
import 'package:finskool/src/data/socket/tickets_socket.dart';
import 'package:finskool/src/domain/usecases/tickets/get_ticket_unread_count.dart';

part 'tickets_unread_event.dart';
part 'tickets_unread_state.dart';
part 'tickets_unread_bloc.freezed.dart';

/// The Profile row's unread badge — the one thing about tickets that has to
/// be alive **outside** the tickets screens, hence a `@singleton`.
///
/// It also owns *starting* the socket. The badge is the reason the socket
/// must be open before the member reaches My tickets, and a singleton built
/// at DI time is the only thing positioned to hear the first push.
///
/// Every refresh is **debounced**: one admin reply produces a
/// `ticket.message` and the member's own `ticket.read` can follow within
/// milliseconds, and there is no value in three round-trips for one change.
@singleton
class TicketsUnreadBloc extends Bloc<TicketsUnreadEvent, TicketsUnreadState> {
  TicketsUnreadBloc(this._getUnread, this._socket)
    : super(TicketsUnreadState.initial()) {
    on<TicketsUnreadEvent>((event, emit) async {
      await event.map(
        started: (_) async {
          _socket.connect();
          await _load(emit);
        },
        refresh: (_) => _load(emit),
        stopped: (_) async {
          _debounce?.cancel();
          await _socket.disconnect();
          emit(TicketsUnreadState.initial());
        },
      );
    });

    _events = _socket.events.listen((e) {
      if (_affectsBadge(e.event)) _scheduleRefresh();
    });

    // **Nothing is replayed after a disconnect** (§6.3.3), so a reconnect
    // is the cue to re-read — anything that happened while offline is gone.
    _statusSub = _socket.status.listen((s) {
      if (s == SocketStatus.live && _wasOffline) _scheduleRefresh();
      _wasOffline = s != SocketStatus.live;
    });
  }

  final GetTicketUnreadCount _getUnread;
  final TicketsSocket _socket;

  StreamSubscription<SocketEvent>? _events;
  StreamSubscription<SocketStatus>? _statusSub;
  Timer? _debounce;
  bool _wasOffline = false;

  static bool _affectsBadge(String event) =>
      event == 'ticket.message' ||
      event == 'ticket.read' ||
      event == 'ticket.created' ||
      event == 'ticket.updated';

  /// The timer only *dispatches* — it never touches `emit`, so a late tick
  /// can't emit outside an event handler (the same rule `PasswordResetBloc`
  /// follows for its countdown).
  void _scheduleRefresh() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (!isClosed) add(const TicketsUnreadEvent.refresh());
    });
  }

  Future<void> _load(Emitter<TicketsUnreadState> emit) async {
    final result = await _getUnread.execute();
    // A failed read keeps the last good number. Blanking a badge because one
    // request timed out would make it flicker to nothing and back.
    result.fold((_) {}, (count) => emit(state.copyWith(count: count)));
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    _events?.cancel();
    _statusSub?.cancel();
    return super.close();
  }
}
