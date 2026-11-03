import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/data/socket/notifications_socket.dart';
import 'package:finskool/src/data/socket/socket_frames.dart';
import 'package:finskool/src/domain/usecases/notifications/get_notifications_unread_count.dart';

part 'notifications_unread_event.dart';
part 'notifications_unread_state.dart';
part 'notifications_unread_bloc.freezed.dart';

/// The bell's badge and the live socket behind it — alive **outside** the
/// inbox screen, hence a `@singleton` (same shape as `TicketsUnreadBloc`).
///
/// The socket gives the count with every event (`unreadCount`), so a live
/// event needs no round-trip. Events are **not replayed**, so every return to
/// `live` — a reconnect, or the app coming back to the foreground — re-reads
/// the count.
@singleton
class NotificationsUnreadBloc
    extends Bloc<NotificationsUnreadEvent, NotificationsUnreadState> {
  NotificationsUnreadBloc(this._getCount, this._socket)
    : super(NotificationsUnreadState.initial()) {
    on<NotificationsUnreadEvent>((event, emit) async {
      await event.map(
        started: (_) async {
          _socket.connect();
          await _load(emit);
        },
        refresh: (_) => _load(emit),
        decremented: (v) async =>
            emit(state.copyWith(count: (state.count - v.by).clamp(0, 1 << 30))),
        allRead: (_) async => emit(state.copyWith(count: 0)),
        received: (v) async => emit(
          state.copyWith(
            // The server's total when it sends one; otherwise count it.
            count: v.event.unreadCount ?? state.count + 1,
          ),
        ),
        stopped: (_) async {
          await _socket.disconnect();
          emit(NotificationsUnreadState.initial());
        },
      );
    });

    _events = _socket.events.listen((e) {
      if (!isClosed) add(NotificationsUnreadEvent.received(e));
    });
    _statusSub = _socket.status.listen((s) {
      if (s == SocketStatus.live && _wasOffline && !isClosed) {
        add(const NotificationsUnreadEvent.refresh());
      }
      _wasOffline = s != SocketStatus.live;
    });
  }

  final GetNotificationsUnreadCount _getCount;
  final NotificationsSocket _socket;

  StreamSubscription<NotificationEvent>? _events;
  StreamSubscription<SocketStatus>? _statusSub;
  bool _wasOffline = false;

  Future<void> _load(Emitter<NotificationsUnreadState> emit) async {
    final result = await _getCount.execute();
    // A failed read keeps the last good number rather than flickering to 0.
    result.fold((_) {}, (count) => emit(state.copyWith(count: count)));
  }

  @override
  Future<void> close() {
    _events?.cancel();
    _statusSub?.cancel();
    return super.close();
  }
}
