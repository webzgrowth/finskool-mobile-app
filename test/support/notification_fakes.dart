import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/data/socket/notifications_socket.dart';
import 'package:finskool/src/data/socket/socket_frames.dart';
import 'package:finskool/src/domain/model/notification/app_notification.dart';
import 'package:finskool/src/domain/repository/notifications_repository.dart';

AppNotification note(
  String id, {
  bool read = false,
  Map<String, dynamic>? data,
  DateTime? at,
}) => AppNotification(
  id: id,
  type: 'ticket-update',
  title: 'Title $id',
  message: 'Message $id',
  data: data,
  isRead: read,
  createdAt: at ?? DateTime(2026, 10, 30, 9),
);

/// A scripted inbox. `pages[i]` is page `i + 1`.
class FakeNotificationsRepository implements NotificationsRepository {
  List<List<AppNotification>> pages = [[]];
  int unread = 0;
  bool pushEnabled = true;
  Failure? fail;
  final readIds = <String>[];
  int markAllCalls = 0;
  int pageCalls = 0;

  @override
  Future<Either<Failure, NotificationsPage>> getPage(int page) async {
    pageCalls++;
    if (fail != null) return Left(fail!);
    return Right(
      NotificationsPage(
        items: pages[page - 1],
        page: page,
        totalPages: pages.length,
      ),
    );
  }

  @override
  Future<Either<Failure, int>> getUnreadCount() async =>
      fail != null ? Left(fail!) : Right(unread);

  @override
  Future<Either<Failure, Unit>> markRead(String id) async {
    if (fail != null) return Left(fail!);
    readIds.add(id);
    return const Right(unit);
  }

  @override
  Future<Either<Failure, Unit>> markAllRead() async {
    if (fail != null) return Left(fail!);
    markAllCalls++;
    return const Right(unit);
  }

  @override
  Future<Either<Failure, bool>> getPushEnabled() async =>
      fail != null ? Left(fail!) : Right(pushEnabled);

  @override
  Future<Either<Failure, bool>> setPushEnabled(bool enabled) async {
    if (fail != null) return Left(fail!);
    pushEnabled = enabled;
    return Right(enabled);
  }
}

/// A socket with no network: the test pushes events and statuses itself.
class FakeNotificationsSocket extends NotificationsSocket {
  final _e = StreamController<NotificationEvent>.broadcast();
  final _s = StreamController<SocketStatus>.broadcast();
  int connects = 0;
  int disconnects = 0;
  bool live = false;

  @override
  Stream<NotificationEvent> get events => _e.stream;
  @override
  Stream<SocketStatus> get status => _s.stream;
  @override
  bool get isLive => live;
  @override
  void connect() => connects++;
  @override
  Future<void> disconnect() async => disconnects++;

  void emit(AppNotification n, {int? unread}) =>
      _e.add(NotificationEvent(n, unread));
  void setStatus(SocketStatus s) {
    live = s == SocketStatus.live;
    _s.add(s);
  }
}
