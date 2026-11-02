import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/data/socket/socket_frames.dart';
import 'package:finskool/src/domain/usecases/notifications/get_notifications.dart';
import 'package:finskool/src/domain/usecases/notifications/get_notifications_unread_count.dart';
import 'package:finskool/src/domain/usecases/notifications/get_push_enabled.dart';
import 'package:finskool/src/domain/usecases/notifications/mark_all_notifications_read.dart';
import 'package:finskool/src/domain/usecases/notifications/mark_notification_read.dart';
import 'package:finskool/src/domain/usecases/notifications/set_push_enabled.dart';
import 'package:finskool/src/presentation/bloc/notifications/inbox/notifications_inbox_bloc.dart';
import 'package:finskool/src/presentation/bloc/notifications/settings/push_settings_bloc.dart';
import 'package:finskool/src/presentation/bloc/notifications/unread/notifications_unread_bloc.dart';

import 'support/notification_fakes.dart';

void main() {
  late FakeNotificationsRepository repo;
  late FakeNotificationsSocket socket;

  setUp(() {
    repo = FakeNotificationsRepository();
    socket = FakeNotificationsSocket();
  });

  Future<void> pump() => Future<void>.delayed(const Duration(milliseconds: 20));

  group('NotificationsInboxBloc', () {
    NotificationsInboxBloc make() => NotificationsInboxBloc(
      GetNotifications(repo),
      MarkNotificationRead(repo),
      MarkAllNotificationsRead(repo),
      socket,
    );

    test('loads the first page', () async {
      repo.pages = [
        [note('a'), note('b', read: true)],
      ];
      final bloc = make()..add(const NotificationsInboxEvent.load());
      await pump();
      expect(bloc.state.state, RequestState.loaded);
      expect(bloc.state.items.map((n) => n.id), ['a', 'b']);
      expect(bloc.state.unread, 1);
      await bloc.close();
    });

    test('pages in the next page and de-dupes against live rows', () async {
      repo.pages = [
        [note('a')],
        [note('a'), note('b')],
      ];
      final bloc = make()..add(const NotificationsInboxEvent.load());
      await pump();
      expect(bloc.state.hasMore, isTrue);
      bloc.add(const NotificationsInboxEvent.loadMore());
      await pump();
      expect(bloc.state.items.map((n) => n.id), ['a', 'b']);
      expect(bloc.state.hasMore, isFalse);
      await bloc.close();
    });

    test(
      'a live row goes on top; a repeat REPLACES, never duplicates',
      () async {
        repo.pages = [
          [note('a', read: true), note('b')],
        ];
        final bloc = make()..add(const NotificationsInboxEvent.load());
        await pump();
        socket.emit(note('c'));
        await pump();
        expect(bloc.state.items.map((n) => n.id), ['c', 'a', 'b']);
        // A reaction row re-sent as unread after the member changed it.
        socket.emit(note('a'));
        await pump();
        expect(bloc.state.items.map((n) => n.id), ['c', 'a', 'b']);
        expect(bloc.state.items[1].isRead, isFalse);
        await bloc.close();
      },
    );

    test(
      'reconnecting re-reads the first page (nothing is replayed)',
      () async {
        final bloc = make()..add(const NotificationsInboxEvent.load());
        await pump();
        final before = repo.pageCalls;
        socket.setStatus(SocketStatus.offline);
        socket.setStatus(SocketStatus.live);
        await pump();
        expect(repo.pageCalls, before + 1);
        await bloc.close();
      },
    );

    test('marking read is optimistic and rolls back if refused', () async {
      repo.pages = [
        [note('a')],
      ];
      final bloc = make()..add(const NotificationsInboxEvent.load());
      await pump();
      bloc.add(const NotificationsInboxEvent.markRead('a'));
      await pump();
      expect(bloc.state.items.single.isRead, isTrue);
      expect(repo.readIds, ['a']);

      repo.pages = [
        [note('z')],
      ];
      bloc.add(const NotificationsInboxEvent.load());
      await pump();
      repo.fail = const ServerFailure('nope');
      bloc.add(const NotificationsInboxEvent.markRead('z'));
      await pump();
      expect(bloc.state.items.single.isRead, isFalse);
      expect(bloc.state.message, 'nope');
      await bloc.close();
    });

    test('mark all read clears every row', () async {
      repo.pages = [
        [note('a'), note('b')],
      ];
      final bloc = make()..add(const NotificationsInboxEvent.load());
      await pump();
      bloc.add(const NotificationsInboxEvent.markAllRead());
      await pump();
      expect(bloc.state.unread, 0);
      expect(repo.markAllCalls, 1);
      await bloc.close();
    });

    test(
      'a failed first load is an error, but a refresh keeps the list',
      () async {
        repo.fail = const ServerFailure('offline');
        final bloc = make()..add(const NotificationsInboxEvent.load());
        await pump();
        expect(bloc.state.state, RequestState.error);

        repo.fail = null;
        repo.pages = [
          [note('a')],
        ];
        bloc.add(const NotificationsInboxEvent.load());
        await pump();
        repo.fail = const ServerFailure('offline');
        bloc.add(const NotificationsInboxEvent.load());
        await pump();
        expect(bloc.state.items, hasLength(1));
        expect(bloc.state.state, RequestState.loaded);
        await bloc.close();
      },
    );
  });

  group('NotificationsUnreadBloc', () {
    NotificationsUnreadBloc make() =>
        NotificationsUnreadBloc(GetNotificationsUnreadCount(repo), socket);

    test('started opens the socket and reads the count', () async {
      repo.unread = 4;
      final bloc = make()..add(const NotificationsUnreadEvent.started());
      await pump();
      expect(socket.connects, 1);
      expect(bloc.state.count, 4);
      await bloc.close();
    });

    test('a live event takes the server total and raises the banner', () async {
      final bloc = make();
      socket.emit(note('n'), unread: 9);
      await pump();
      expect(bloc.state.count, 9);
      expect(bloc.state.incoming?.id, 'n');
      await bloc.close();
    });

    test('with no total it counts the event itself', () async {
      repo.unread = 2;
      final bloc = make()..add(const NotificationsUnreadEvent.started());
      await pump();
      socket.emit(note('n'));
      await pump();
      expect(bloc.state.count, 3);
      await bloc.close();
    });

    test('reading rows lowers the badge, never below zero', () async {
      repo.unread = 1;
      final bloc = make()..add(const NotificationsUnreadEvent.started());
      await pump();
      bloc.add(const NotificationsUnreadEvent.decremented(5));
      await pump();
      expect(bloc.state.count, 0);
      await bloc.close();
    });

    test('a failed refresh keeps the last good number', () async {
      repo.unread = 6;
      final bloc = make()..add(const NotificationsUnreadEvent.started());
      await pump();
      repo.fail = const ServerFailure('x');
      bloc.add(const NotificationsUnreadEvent.refresh());
      await pump();
      expect(bloc.state.count, 6);
      await bloc.close();
    });

    test('coming back online re-reads the count', () async {
      final bloc = make();
      repo.unread = 8;
      socket.setStatus(SocketStatus.offline);
      socket.setStatus(SocketStatus.live);
      await pump();
      expect(bloc.state.count, 8);
      await bloc.close();
    });

    test('stopped (logout) closes the socket and clears the badge', () async {
      repo.unread = 3;
      final bloc = make()..add(const NotificationsUnreadEvent.started());
      await pump();
      bloc.add(const NotificationsUnreadEvent.stopped());
      await pump();
      expect(socket.disconnects, 1);
      expect(bloc.state.count, 0);
      await bloc.close();
    });
  });

  group('PushSettingsBloc', () {
    PushSettingsBloc make() =>
        PushSettingsBloc(GetPushEnabled(repo), SetPushEnabled(repo));

    test('loads the server value', () async {
      repo.pushEnabled = false;
      final bloc = make()..add(const PushSettingsEvent.load());
      await pump();
      expect(bloc.state.enabled, isFalse);
      await bloc.close();
    });

    test('toggling is optimistic and sticks on success', () async {
      final bloc = make();
      bloc.add(const PushSettingsEvent.toggled(false));
      await pump();
      expect(bloc.state.enabled, isFalse);
      expect(repo.pushEnabled, isFalse);
      await bloc.close();
    });

    test('a refused toggle snaps back with the server message', () async {
      final bloc = make();
      repo.fail = const ServerFailure('Not allowed');
      bloc.add(const PushSettingsEvent.toggled(false));
      await pump();
      expect(bloc.state.enabled, isTrue);
      expect(bloc.state.message, 'Not allowed');
      await bloc.close();
    });

    test('reset forgets the previous account', () async {
      final bloc = make()..add(const PushSettingsEvent.toggled(false));
      await pump();
      bloc.add(const PushSettingsEvent.reset());
      await pump();
      expect(bloc.state.enabled, isTrue);
      await bloc.close();
    });
  });
}
