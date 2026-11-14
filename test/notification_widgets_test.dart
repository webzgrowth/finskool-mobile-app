import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/comman/widgets/notification_card.dart';
import 'package:finskool/src/domain/usecases/notifications/get_notifications.dart';
import 'package:finskool/src/domain/usecases/notifications/get_notifications_unread_count.dart';
import 'package:finskool/src/domain/usecases/notifications/mark_all_notifications_read.dart';
import 'package:finskool/src/domain/usecases/notifications/mark_notification_read.dart';
import 'package:finskool/src/presentation/bloc/notifications/inbox/notifications_inbox_bloc.dart';
import 'package:finskool/src/presentation/bloc/notifications/unread/notifications_unread_bloc.dart';
import 'package:finskool/src/presentation/pages/notifications/widgets/notification_list.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'support/notification_fakes.dart';
import 'support/ticket_fakes.dart';

void main() {
  setUpAll(loadAppFonts);

  testWidgets(
    'a long title wraps (up to three lines) instead of cutting the name',
    (tester) async {
      tester.view.physicalSize = const Size(360, 640);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      const title = 'New announcement in Investor Community Premium Plus';
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: const Scaffold(
            body: NotificationCard(title: title, body: 'b', time: '1m'),
          ),
        ),
      );
      final text = tester.widget<Text>(find.text(title));
      expect(text.maxLines, 3);
      // It really takes more than one line (so was being cut before).
      expect(tester.getSize(find.text(title)).height, greaterThan(20));
    },
  );

  testWidgets('the card shows the Figma anatomy and reports taps', (
    tester,
  ) async {
    var taps = 0;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(
          body: NotificationCard(
            title: 'Payment successful',
            body: '₹7,000 received for Swing Alpha · 6 months.',
            time: '5m ago',
            unread: true,
            onTap: () => taps++,
          ),
        ),
      ),
    );
    expect(find.text('FINSKOOL21'), findsOneWidget);
    expect(find.text('Payment successful'), findsOneWidget);
    expect(find.text('5m ago'), findsOneWidget);
    await tester.tap(find.text('Payment successful'));
    expect(taps, 1);
  });

  testWidgets('a long body is held to two lines instead of overflowing', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(
          body: NotificationCard(
            title: 'Title',
            body: 'word ' * 80,
            time: 'now',
          ),
        ),
      ),
    );
    expect(tester.takeException(), isNull);
  });

  /// Renders the inbox body for [state] with real blocs on fake data.
  Future<void> pumpList(
    WidgetTester tester,
    NotificationsInboxState state,
  ) async {
    final repo = FakeNotificationsRepository();
    final socket = FakeNotificationsSocket();
    final inbox = NotificationsInboxBloc(
      GetNotifications(repo),
      MarkNotificationRead(repo),
      MarkAllNotificationsRead(repo),
      socket,
    );
    final unread = NotificationsUnreadBloc(
      GetNotificationsUnreadCount(repo),
      socket,
    );
    addTearDown(inbox.close);
    addTearDown(unread.close);
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: inbox),
            BlocProvider.value(value: unread),
          ],
          child: Scaffold(
            body: Builder(
              builder: (context) =>
                  ListView(children: notificationListChildren(context, state)),
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('empty inbox says so', (tester) async {
    await pumpList(
      tester,
      NotificationsInboxState.initial().copyWith(state: RequestState.loaded),
    );
    expect(find.textContaining('No notifications yet'), findsOneWidget);
  });

  testWidgets('a failed first load offers a retry with the server message', (
    tester,
  ) async {
    await pumpList(
      tester,
      NotificationsInboxState.initial().copyWith(
        state: RequestState.error,
        message: 'No internet connection.',
      ),
    );
    expect(find.text('No internet connection.'), findsOneWidget);
    expect(find.text('Try again'), findsOneWidget);
  });

  testWidgets('read and unread rows render side by side', (tester) async {
    await pumpList(
      tester,
      NotificationsInboxState.initial().copyWith(
        state: RequestState.loaded,
        items: [note('a'), note('b', read: true)],
      ),
    );
    expect(find.text('Title a'), findsOneWidget);
    expect(find.text('Title b'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
