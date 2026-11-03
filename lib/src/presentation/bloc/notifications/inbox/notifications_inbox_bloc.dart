import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/min_skeleton.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/data/socket/notifications_socket.dart';
import 'package:finskool/src/data/socket/socket_frames.dart';
import 'package:finskool/src/domain/model/notification/app_notification.dart';
import 'package:finskool/src/domain/usecases/notifications/get_notifications.dart';
import 'package:finskool/src/domain/usecases/notifications/mark_all_notifications_read.dart';
import 'package:finskool/src/domain/usecases/notifications/mark_notification_read.dart';

part 'notifications_inbox_event.dart';
part 'notifications_inbox_state.dart';
part 'notifications_inbox_bloc.freezed.dart';

/// The inbox list. Route-scoped (`@injectable`), like the ticket list: it must
/// not outlive the screen. The badge is [NotificationsUnreadBloc]'s job — the
/// screen combines the two in the widget layer.
///
/// **The inbox is the source of truth; the socket and pushes are nudges.**
/// Rows are merged by `id`: a live row that already exists is *replaced* (a
/// reaction row is re-sent as unread when someone changes their reaction), a
/// new one goes on top. After every reconnect the first page is re-read,
/// because events are not replayed.
@injectable
class NotificationsInboxBloc
    extends Bloc<NotificationsInboxEvent, NotificationsInboxState> {
  NotificationsInboxBloc(
    this._getPage,
    this._markRead,
    this._markAllRead,
    this._socket,
  ) : super(NotificationsInboxState.initial()) {
    on<NotificationsInboxEvent>((event, emit) async {
      await event.map(
        load: (_) => _loadFirst(emit),
        loadMore: (_) => _loadNext(emit),
        markRead: (v) => _read(v.id, emit),
        markAllRead: (_) => _readAll(emit),
        received: (v) async => emit(state.copyWith(items: _merge(v.item))),
      );
    });
    _events = _socket.events.listen((e) {
      if (!isClosed) add(NotificationsInboxEvent.received(e.notification));
    });
    _statusSub = _socket.status.listen((s) {
      if (s == SocketStatus.live && _wasOffline && !isClosed) {
        add(const NotificationsInboxEvent.load());
      }
      _wasOffline = s != SocketStatus.live;
    });
  }

  final GetNotifications _getPage;
  final MarkNotificationRead _markRead;
  final MarkAllNotificationsRead _markAllRead;
  final NotificationsSocket _socket;

  StreamSubscription<NotificationEvent>? _events;
  StreamSubscription<SocketStatus>? _statusSub;
  bool _wasOffline = false;

  List<AppNotification> _merge(AppNotification item) {
    final i = state.items.indexWhere((n) => n.id == item.id);
    if (i == -1) return [item, ...state.items];
    return [...state.items]..[i] = item;
  }

  Future<void> _loadFirst(Emitter<NotificationsInboxState> emit) async {
    // Keep what is on screen while refreshing: only the first load spins.
    if (state.items.isEmpty) {
      emit(state.copyWith(state: RequestState.loading, message: ''));
    }
    final result = state.items.isEmpty
        ? await holdSkeletonOnFailure(() => _getPage.execute(1))
        : await _getPage.execute(1);
    emit(
      result.fold(
        (f) => state.items.isEmpty
            ? state.copyWith(state: RequestState.error, message: f.message)
            : state.copyWith(state: RequestState.loaded),
        (page) => state.copyWith(
          state: RequestState.loaded,
          items: page.items,
          page: page.page,
          hasMore: page.hasMore,
          loadMoreFailed: false,
          message: '',
        ),
      ),
    );
  }

  Future<void> _loadNext(Emitter<NotificationsInboxState> emit) async {
    if (!state.hasMore || state.isLoadingMore || state.loadMoreFailed) return;
    emit(state.copyWith(isLoadingMore: true));
    final result = await _getPage.execute(state.page + 1);
    emit(
      result.fold(
        (f) => state.copyWith(
          isLoadingMore: false,
          loadMoreFailed: true,
          message: f.message,
        ),
        (page) {
          // A live row may already be in the list: de-dupe by id.
          final seen = state.items.map((n) => n.id).toSet();
          return state.copyWith(
            isLoadingMore: false,
            items: [
              ...state.items,
              ...page.items.where((n) => !seen.contains(n.id)),
            ],
            page: page.page,
            hasMore: page.hasMore,
          );
        },
      ),
    );
  }

  Future<void> _read(String id, Emitter<NotificationsInboxState> emit) async {
    final before = state.items;
    final row = before.where((n) => n.id == id).firstOrNull;
    if (row == null || row.isRead) return;
    emit(
      state.copyWith(
        items: [
          for (final n in before) n.id == id ? n.copyWith(isRead: true) : n,
        ],
      ),
    );
    final result = await _markRead.execute(id);
    result.fold(
      (f) => emit(state.copyWith(items: before, message: f.message)),
      (_) {},
    );
  }

  Future<void> _readAll(Emitter<NotificationsInboxState> emit) async {
    final before = state.items;
    if (state.unread == 0) return;
    emit(
      state.copyWith(items: [for (final n in before) n.copyWith(isRead: true)]),
    );
    final result = await _markAllRead.execute();
    result.fold(
      (f) => emit(state.copyWith(items: before, message: f.message)),
      (_) {},
    );
  }

  @override
  Future<void> close() {
    _events?.cancel();
    _statusSub?.cancel();
    return super.close();
  }
}
