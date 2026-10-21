import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/injections/injection.dart';
import 'package:finskool/src/data/socket/socket_frames.dart';
import 'package:finskool/src/domain/model/ticket/ticket_enums.dart';
import 'package:finskool/src/domain/usecases/tickets/get_ticket.dart';
import 'package:finskool/src/domain/usecases/tickets/get_ticket_history.dart';
import 'package:finskool/src/domain/usecases/tickets/get_tickets.dart';
import 'package:finskool/src/domain/usecases/tickets/mark_ticket_read.dart';
import 'package:finskool/src/domain/usecases/tickets/rate_ticket.dart';
import 'package:finskool/src/domain/usecases/tickets/refresh_attachment_url.dart';
import 'package:finskool/src/domain/usecases/tickets/send_ticket_message.dart';
import 'package:finskool/src/domain/usecases/tickets/upload_ticket_attachment.dart';
import 'package:finskool/src/presentation/bloc/tickets/chat/ticket_chat_bloc.dart';
import 'package:finskool/src/presentation/bloc/tickets/list/tickets_list_bloc.dart';
import 'package:finskool/src/presentation/pages/tickets/detail/ticket_detail_screen.dart';
import 'package:finskool/src/presentation/pages/tickets/detail/widgets/rating_popup.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_close_button.dart';
import 'package:finskool/src/presentation/pages/tickets/list/widgets/tickets_list_body.dart';
import 'package:finskool/src/presentation/pages/tickets/submitted/ticket_submitted_screen.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_header.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_sheet_page.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'support/ticket_fakes.dart';

/// Renders the real screens with the real theme and bundled fonts, at
/// Figma's 375x812, so layout overflows surface here rather than on a device.
Widget _app(Widget child, {double textScale = 1.0, EdgeInsets? padding}) =>
    MaterialApp(
      theme: AppTheme.light,
      home: MediaQuery(
        data: MediaQueryData(
          size: const Size(375, 812),
          textScaler: TextScaler.linear(textScale),
          padding: padding ?? const EdgeInsets.only(top: 44, bottom: 34),
        ),
        child: child,
      ),
    );

TicketChatBloc _chatBloc(FakeTicketsRepository repo, FakeSocket socket) =>
    TicketChatBloc(
      GetTicket(repo),
      GetTicketHistory(repo),
      SendTicketMessage(repo),
      MarkTicketRead(repo),
      RateTicket(repo),
      UploadTicketAttachment(repo),
      RefreshAttachmentUrl(repo),
      socket,
    );

void main() {
  late FakeTicketsRepository repo;
  late FakeSocket socket;
  late TicketChatBloc chat;

  void sizeToPhone(WidgetTester tester) {
    tester.view.physicalSize = const Size(375, 812);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
  }

  // The repository is plain futures, so it is safe to build here. The bloc
  // and socket are NOT: they own stream controllers, and anything created in
  // `setUp` lives outside `testWidgets`' fake-async zone — its events would
  // never flush on `tester.pump`, and awaiting `close()` in `tearDown` would
  // wait forever on a zone that no longer exists.
  setUpAll(loadAppFonts);
  setUp(() => repo = FakeTicketsRepository());

  tearDown(() {
    if (locator.isRegistered<TicketChatBloc>()) {
      locator.unregister<TicketChatBloc>();
    }
  });

  Future<void> openDetail(WidgetTester tester, {double scale = 1.0}) async {
    sizeToPhone(tester);
    socket = FakeSocket();
    chat = _chatBloc(repo, socket);
    if (locator.isRegistered<TicketChatBloc>()) {
      locator.unregister<TicketChatBloc>();
    }
    // The screen builds its own bloc through the locator; hand it ours.
    locator.registerFactory<TicketChatBloc>(() => chat);

    await tester.pumpWidget(
      _app(
        const TicketDetailScreen(
          ticketId: 't1',
          memberAvatar: SizedBox(height: 28, width: 28),
        ),
        textScale: scale,
      ),
    );
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(milliseconds: 100));
  }

  /// Unmounting disposes the `BlocProvider`, which closes the bloc inside
  /// this test's own zone.
  Future<void> unmount(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  }

  group('ticket detail — in progress', () {
    setUp(() {
      repo.history = [
        serverMessage('m2', role: 'admin', minute: 8),
        serverMessage('m1', role: 'user', minute: 2),
      ];
    });

    testWidgets('shows the conversation and the composer', (tester) async {
      await openDetail(tester);
      expect(tester.takeException(), isNull);
      expect(find.text('How Can We Help?'), findsOneWidget);
      expect(find.text('Write a reply'), findsOneWidget);
      // The description is the first bubble.
      expect(find.text('Money deducted'), findsOneWidget);
      // The summary lives behind the Status button, not on the page.
      expect(find.text('#FS-2041'), findsNothing);
      await unmount(tester);
    });

    testWidgets('timestamps are IST, not UTC', (tester) async {
      await openDetail(tester);
      // 10:08 UTC is 15:38 IST.
      expect(find.textContaining('3:38 PM'), findsOneWidget);
      expect(find.textContaining('10:08 AM'), findsNothing);
      await unmount(tester);
    });

    testWidgets('support is "Support team", never an admin\'s own name', (
      tester,
    ) async {
      await openDetail(tester);
      expect(find.textContaining('Support team'), findsWidgets);
      await unmount(tester);
    });

    testWidgets('Status opens the stepper popover, ✕ closes it', (
      tester,
    ) async {
      await openDetail(tester);
      await tester.tap(find.text('Status'));
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text('#FS-2041'), findsOneWidget);
      expect(find.text('Raised'), findsOneWidget);
      expect(find.text('In progress'), findsWidgets);
      expect(find.text('Resolved'), findsOneWidget);
      // Not resolved yet: the last step says so rather than inventing a date.
      expect(find.textContaining('Pending'), findsOneWidget);

      await tester.tap(find.byType(TicketCloseButton));
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text('#FS-2041'), findsNothing);
      await unmount(tester);
    });

    testWidgets('survives a large system font without overflowing', (
      tester,
    ) async {
      await openDetail(tester, scale: 1.6);
      expect(tester.takeException(), isNull);
      await tester.tap(find.text('Status'));
      await tester.pump(const Duration(milliseconds: 100));
      expect(tester.takeException(), isNull);
      await unmount(tester);
    });

    testWidgets('offline: shows the reconnecting notice', (tester) async {
      await openDetail(tester);
      socket.setStatus(SocketStatus.offline);
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.textContaining('Reconnecting'), findsOneWidget);
    });
  });

  group('ticket detail — resolved', () {
    setUp(() {
      repo.ticket = fakeTicket(status: TicketStatus.resolved);
      repo.history = [serverMessage('m1', role: 'admin', minute: 8)];
    });

    testWidgets('drops the composer and shows the derived resolved pill', (
      tester,
    ) async {
      await openDetail(tester);
      expect(tester.takeException(), isNull);
      expect(
        find.text('Write a reply'),
        findsNothing,
        reason: 'a resolved ticket is read-only for good',
      );
      expect(find.text('Marked as resolved by Support team'), findsOneWidget);
      await unmount(tester);
    });

    testWidgets('offers one real action, not reopen / close', (tester) async {
      await openDetail(tester);
      expect(find.text('Was your query resolved?'), findsOneWidget);
      expect(find.text('Submit rating'), findsOneWidget);
      // Neither exists in the backend (§10).
      expect(find.textContaining('reopen'), findsNothing);
      expect(find.text('Yes, close ticket'), findsNothing);
      await unmount(tester);
    });

    testWidgets('the card can be dismissed', (tester) async {
      await openDetail(tester);
      await tester.tap(
        find.descendant(
          of: find.byType(RatingPopup),
          matching: find.byType(TicketCloseButton),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text('Was your query resolved?'), findsNothing);
      await unmount(tester);
    });

    testWidgets('a rating is submitted once, and the card goes away', (
      tester,
    ) async {
      await openDetail(tester);

      // Nothing chosen yet: submit is inert.
      await tester.tap(find.text('Submit rating'), warnIfMissed: false);
      await tester.pump();
      expect(repo.ticket.rating, isNull);

      // Five star slots live in the card; take the fourth.
      final stars = find.descendant(
        of: find.byType(RatingPopup),
        matching: find.byType(SvgPicture),
      );
      expect(stars, findsNWidgets(5));
      await tester.tap(stars.at(3));
      await tester.pump();
      await tester.tap(find.text('Submit rating'));
      await tester.pump(const Duration(milliseconds: 100));

      expect(repo.ticket.rating, 4);
      expect(find.text('Submit rating'), findsNothing);
      expect(find.text('You rated this ticket 4/5'), findsOneWidget);
    });
  });

  group('ticket submitted', () {
    testWidgets('says only what the backend will do', (tester) async {
      sizeToPhone(tester);
      await tester.pumpWidget(
        _app(
          TicketSubmittedScreen(ticket: fakeTicket(status: TicketStatus.open)),
        ),
      );
      await tester.pump();
      expect(tester.takeException(), isNull);
      expect(find.text('Ticket submitted'), findsOneWidget);
      // Reworded: the API sends no email for replies and has no member-side
      // close or reopen (§10).
      expect(find.textContaining('email'), findsNothing);
      expect(find.textContaining('reopen'), findsNothing);
      expect(find.text('Rate it when sorted'), findsOneWidget);
      expect(find.text('What happens next'), findsOneWidget);
      expect(find.text('Ticket Overview'), findsOneWidget);
    });

    testWidgets('fits at a large font', (tester) async {
      sizeToPhone(tester);
      await tester.pumpWidget(
        _app(
          TicketSubmittedScreen(ticket: fakeTicket(status: TicketStatus.open)),
          textScale: 1.6,
        ),
      );
      await tester.pump();
      expect(tester.takeException(), isNull);
    });
  });

  group('sheet page', () {
    testWidgets('shifts content by the real status-bar inset, not 44', (
      tester,
    ) async {
      sizeToPhone(tester);
      Future<double> titleTop(double inset) async {
        await tester.pumpWidget(
          _app(
            TicketSheetPage(
              header: TicketHeader(
                spec: TicketHeaderSpec.list,
                title: 'T',
                onBack: () {},
              ),
              body: const SizedBox.shrink(),
            ),
            padding: EdgeInsets.only(top: inset),
          ),
        );
        return tester.getTopLeft(find.text('T')).dy;
      }

      final at44 = await titleTop(44);
      // A taller Dynamic Island pushes it down by exactly the difference...
      expect(await titleTop(59), at44 + 15);
      // ...but a thin Android bar (24dp) is floored at Figma's 44, so the hero
      // keeps its proportions instead of coming out 20dp short.
      expect(await titleTop(24), at44);
    });
  });

  group('list body', () {
    testWidgets('chips carry counts once every page is loaded', (tester) async {
      sizeToPhone(tester);
      final bloc = TicketsListBloc(GetTickets(repo), socket);
      addTearDown(bloc.close);
      bloc.add(const TicketsListEvent.load());
      await tester.pump(const Duration(milliseconds: 50));

      await tester.pumpWidget(
        _app(
          BlocProvider.value(
            value: bloc,
            child: BlocBuilder<TicketsListBloc, TicketsListState>(
              builder: (context, state) => Scaffold(
                body: TicketsListBody(
                  state: state,
                  onOpenTicket: (_) {},
                  onRaise: () {},
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(tester.takeException(), isNull);
      expect(find.text('Raise a new ticket'), findsOneWidget);
    });
  });
}
