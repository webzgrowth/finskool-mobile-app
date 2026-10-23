import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/data/socket/socket_frames.dart';
import 'package:finskool/src/data/socket/tickets_socket.dart';
import 'package:finskool/src/domain/usecases/services/get_service_unread_count.dart';

part 'services_unread_event.dart';
part 'services_unread_state.dart';
part 'services_unread_bloc.freezed.dart';

/// The Services bell's badge: unread replies across every request.
///
/// A `@singleton`, because it must hear pushes while no Services screen is
/// open. It does **not** open or close the socket — `TicketsUnreadBloc` owns
/// that, and there is one connection for tickets and services together.
///
/// Refreshes are debounced: one admin reply is a `service.message`, and the
/// member's own `service.read` can follow within milliseconds.
@singleton
class ServicesUnreadBloc
    extends Bloc<ServicesUnreadEvent, ServicesUnreadState> {
  ServicesUnreadBloc(this._getUnread, this._socket)
    : super(ServicesUnreadState.initial()) {
    on<ServicesUnreadEvent>((event, emit) async {
      await event.map(
        started: (_) => _load(emit),
        refresh: (_) => _load(emit),
        stopped: (_) async {
          _debounce?.cancel();
          emit(ServicesUnreadState.initial());
        },
      );
    });

    _events = _socket.events.listen((e) {
      if (e.event.startsWith('service.')) _scheduleRefresh();
    });
    // Nothing is replayed after a disconnect, so a reconnect is the cue to
    // re-read.
    _statusSub = _socket.status.listen((s) {
      if (s == SocketStatus.live && _wasOffline) _scheduleRefresh();
      _wasOffline = s != SocketStatus.live;
    });
  }

  final GetServiceUnreadCount _getUnread;
  final TicketsSocket _socket;
  StreamSubscription<SocketEvent>? _events;
  StreamSubscription<SocketStatus>? _statusSub;
  Timer? _debounce;
  bool _wasOffline = false;

  void _scheduleRefresh() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (!isClosed) add(const ServicesUnreadEvent.refresh());
    });
  }

  Future<void> _load(Emitter<ServicesUnreadState> emit) async {
    final result = await _getUnread.execute();
    // A failed read keeps the last good number rather than flickering to 0.
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
