@Tags(['golden'])
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/injections/injection.dart';
import 'package:finskool/src/domain/model/ticket/ticket_attachment_model.dart';
import 'package:finskool/src/domain/model/ticket/ticket_enums.dart';
import 'package:finskool/src/domain/model/ticket/ticket_message_model.dart';
import 'package:finskool/src/domain/model/ticket/ticket_model.dart';
import 'package:finskool/src/domain/model/ticket/ticket_page_model.dart';
import 'package:finskool/src/domain/usecases/tickets/create_ticket.dart';
import 'package:finskool/src/domain/usecases/tickets/get_ticket.dart';
import 'package:finskool/src/domain/usecases/tickets/get_ticket_communities.dart';
import 'package:finskool/src/domain/usecases/tickets/get_ticket_history.dart';
import 'package:finskool/src/domain/usecases/tickets/get_tickets.dart';
import 'package:finskool/src/domain/usecases/tickets/mark_ticket_read.dart';
import 'package:finskool/src/domain/usecases/tickets/rate_ticket.dart';
import 'package:finskool/src/domain/usecases/tickets/refresh_attachment_url.dart';
import 'package:finskool/src/domain/usecases/tickets/send_ticket_message.dart';
import 'package:finskool/src/domain/usecases/tickets/upload_ticket_attachment.dart';
import 'package:finskool/src/presentation/bloc/tickets/chat/ticket_chat_bloc.dart';
import 'package:finskool/src/presentation/bloc/tickets/form/ticket_form_bloc.dart';
import 'package:finskool/src/presentation/bloc/tickets/list/tickets_list_bloc.dart';
import 'package:finskool/src/presentation/pages/tickets/detail/ticket_detail_screen.dart';
import 'package:finskool/src/presentation/pages/tickets/detail/widgets/rating_popup.dart';
import 'package:finskool/src/presentation/pages/tickets/form/raise_ticket_screen.dart';
import 'package:finskool/src/presentation/pages/tickets/list/widgets/tickets_empty_view.dart';
import 'package:finskool/src/presentation/pages/tickets/list/widgets/tickets_list_body.dart';
import 'package:finskool/src/presentation/pages/tickets/submitted/ticket_submitted_screen.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_header.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_sheet_page.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'support/ticket_fakes.dart';

/// Renders each ticket screen with Figma's own sample data into
/// `build/ticket_goldens/`, so the output can be laid next to Figma's export
/// and compared by eye and by pixel. Not committed: `build/` is gitignored.
///
/// Run: `flutter test --update-goldens test/ticket_goldens_test.dart`
const _out = '../build/ticket_goldens';

Widget _app(Widget child) => MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: AppTheme.light,
  home: MediaQuery(
    data: const MediaQueryData(
      size: Size(375, 812),
      // Figma's frames assume a 44pt status bar and 34pt home indicator.
      padding: EdgeInsets.only(top: 44, bottom: 34),
    ),
    child: child,
  ),
);

class _StubAvatar extends StatelessWidget {
  const _StubAvatar();

  @override
  Widget build(BuildContext context) =>
      const CircleAvatar(radius: 14, backgroundColor: Color(0xFFE8590C));
}

TicketModel _t(
  String label,
  String subject,
  TicketStatus status,
  TicketCategory category, {
  required DateTime created,
  DateTime? activity,
  DateTime? resolved,
  int unread = 0,
}) => TicketModel(
  id: label,
  number: 0,
  label: label,
  communityId: 'c1',
  communityName: 'Intraday Community',
  category: category,
  type: TicketType.issue,
  subject: subject,
  description: '',
  status: status,
  unreadCount: unread,
  createdAt: created,
  lastMessageAt: activity ?? created,
  resolvedAt: resolved,
);

void main() {
  late FakeTicketsRepository repo;

  setUpAll(() async {
    await loadAppFonts();
  });

  /// flutter_test strips the blur from every `BoxShadow` by default
  /// (`debugDisableShadows`), turning Figma's soft halo into a hard offset
  /// band. Real devices blur, so a golden has to as well — but the test
  /// binding insists the flag is back to its default when a test ends.
  void golden(String name, Future<void> Function(WidgetTester) body) =>
      testWidgets(name, (tester) async {
        debugDisableShadows = false;
        try {
          await body(tester);
        } finally {
          debugDisableShadows = true;
        }
      });
  setUp(() => repo = FakeTicketsRepository());

  void phone(WidgetTester t) {
    t.view.physicalSize = const Size(750, 1624); // 2x of 375x812
    t.view.devicePixelRatio = 2;
    addTearDown(t.view.reset);
  }

  golden('01 list', (tester) async {
    phone(tester);
    repo.pageItems = [
      _t(
        'FS-2041',
        'Payment deducted but subscription not active',
        TicketStatus.open,
        TicketCategory.payments,
        created: DateTime.utc(2026, 10, 5, 12),
      ),
      _t(
        'FS-2032',
        'Unable to change registered phone number',
        TicketStatus.inProgress,
        TicketCategory.account,
        created: DateTime.utc(2026, 10, 1, 12),
        activity: DateTime.utc(2026, 10, 3, 12),
        unread: 1,
      ),
      _t(
        'FS-1987',
        'Invoice not received for Intraday Community',
        TicketStatus.resolved,
        TicketCategory.payments,
        created: DateTime.utc(2026, 9, 18, 12),
        resolved: DateTime.utc(2026, 9, 21, 12),
      ),
      _t(
        'FS-1954',
        'Welcome kit videos not loading',
        TicketStatus.resolved,
        TicketCategory.appBug,
        created: DateTime.utc(2026, 9, 10, 12),
        resolved: DateTime.utc(2026, 9, 12, 12),
      ),
    ];
    final bloc = TicketsListBloc(GetTickets(repo), FakeSocket());
    bloc.add(const TicketsListEvent.load());
    await tester.pump(const Duration(milliseconds: 50));

    await tester.pumpWidget(
      _app(
        BlocProvider.value(
          value: bloc,
          child: BlocBuilder<TicketsListBloc, TicketsListState>(
            builder: (context, state) => TicketSheetPage(
              header: TicketHeader(
                spec: TicketHeaderSpec.list,
                title: 'My Tickets',
                subtitle: 'Track your queries and their status',
                onBack: () {},
              ),
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
    await tester.pump(const Duration(milliseconds: 100));
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('$_out/01_list.png'),
    );
    await tester.pumpWidget(const SizedBox.shrink());
  });

  golden('02 empty', (tester) async {
    phone(tester);
    await tester.pumpWidget(
      _app(
        TicketSheetPage(
          header: TicketHeader(
            spec: TicketHeaderSpec.list,
            title: 'My Tickets',
            subtitle: 'Track your queries and their status',
            onBack: () {},
          ),
          body: TicketsEmptyView(onRaise: () {}, onNeedHelp: () {}),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 100));
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('$_out/02_empty.png'),
    );
  });

  golden('03 raise', (tester) async {
    phone(tester);
    final form = TicketFormBloc(
      GetTicketCommunities(repo),
      UploadTicketAttachment(repo),
      CreateTicket(repo),
    );
    if (locator.isRegistered<TicketFormBloc>()) {
      locator.unregister<TicketFormBloc>();
    }
    locator.registerFactory<TicketFormBloc>(() => form);
    addTearDown(() => locator.unregister<TicketFormBloc>());

    await tester.pumpWidget(_app(const RaiseTicketScreen()));
    await tester.pump(const Duration(milliseconds: 100));
    form
      ..add(const TicketFormEvent.categoryChanged(TicketCategory.payments))
      ..add(const TicketFormEvent.typeChanged(TicketType.issue))
      ..add(
        const TicketFormEvent.communityChanged(
          TicketCommunityModel(id: 'c1', name: 'Intraday Community'),
        ),
      );
    await tester.pump(const Duration(milliseconds: 100));
    await tester.enterText(
      find.byType(TextField).at(0),
      'Payment deducted but subscription not active',
    );
    await tester.enterText(
      find.byType(TextField).at(1),
      '₹3,000 was deducted via UPI on 5 Oct but Intraday Community still shows as inactive. Receipt attached.',
    );
    await tester.pump(const Duration(milliseconds: 100));
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('$_out/03_raise.png'),
    );
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });

  golden('04 submitted', (tester) async {
    phone(tester);
    final t = TicketModel(
      id: 't1',
      number: 2041,
      label: 'FS-2041',
      communityId: 'c1',
      communityName: 'Intraday Community',
      category: TicketCategory.payments,
      type: TicketType.issue,
      subject: 'Payment deducted but subscription not active',
      description: '',
      status: TicketStatus.open,
      createdAt: DateTime.utc(2026, 10, 5, 10, 48),
      lastMessageAt: DateTime.utc(2026, 10, 5, 10, 48),
      attachments: const [
        TicketAttachmentModel(
          id: 'a',
          fileName: 'payment-receipt.png',
          mimeType: 'image/png',
          sizeBytes: 240000,
        ),
      ],
    );
    await tester.pumpWidget(_app(TicketSubmittedScreen(ticket: t)));
    // Asset images decode off the test's fake clock.
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 200)),
    );
    await tester.pump(const Duration(milliseconds: 100));
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('$_out/04_submitted.png'),
    );
  });

  Future<void> detail(
    WidgetTester tester,
    String name, {
    required TicketModel ticket,
    required List<TicketMessageModel> history,
    Future<void> Function(WidgetTester)? before,
  }) async {
    phone(tester);
    repo
      ..ticket = ticket
      ..history = history;
    final socket = FakeSocket();
    final chat = TicketChatBloc(
      GetTicket(repo),
      GetTicketHistory(repo),
      SendTicketMessage(repo),
      MarkTicketRead(repo),
      RateTicket(repo),
      UploadTicketAttachment(repo),
      RefreshAttachmentUrl(repo),
      socket,
    );
    if (locator.isRegistered<TicketChatBloc>()) {
      locator.unregister<TicketChatBloc>();
    }
    locator.registerFactory<TicketChatBloc>(() => chat);
    addTearDown(() => locator.unregister<TicketChatBloc>());
    await tester.pumpWidget(
      _app(
        const TicketDetailScreen(ticketId: 't1', memberAvatar: _StubAvatar()),
      ),
    );
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(milliseconds: 100));
    await before?.call(tester);
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('$_out/$name.png'),
    );
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  }

  TicketMessageModel msg(
    String id,
    String role,
    String body,
    DateTime at, {
    String? client,
  }) => TicketMessageModel(
    id: id,
    ticketId: 't1',
    senderRole: role,
    senderName: role == 'user' ? 'You' : 'Support',
    body: body,
    clientMessageId: client,
    createdAt: at,
  );

  TicketModel base(TicketStatus status) => TicketModel(
    id: 't1',
    number: 2041,
    label: 'FS-2041',
    communityId: 'c1',
    communityName: 'Intraday Community',
    category: TicketCategory.payments,
    type: TicketType.issue,
    subject: 'Payment deducted but subscription not active',
    description: '₹3,000 was deducted via UPI on 5 Oct but Intraday Community still shows as inactive. Receipt attached.',
    status: status,
    createdAt: DateTime.utc(2026, 10, 5, 10, 48),
    lastMessageAt: DateTime.utc(2026, 10, 5, 11, 40),
    resolvedAt: status.isResolved ? DateTime.utc(2026, 10, 6, 5, 50) : null,
    attachments: const [
      TicketAttachmentModel(
        id: 'a',
        fileName: 'payment-receipt.png',
        mimeType: 'image/png',
        sizeBytes: 1,
      ),
    ],
  );

  final inProgress = [
    msg(
      'm2',
      'user',
      'Thank you. Please confirm once it is done.',
      DateTime.utc(2026, 10, 5, 11, 40),
    ),
    msg(
      'm1',
      'admin',
      'Hi Ritesh, thanks for sharing the receipt. We have raised this with the payments team and will update you here once it is confirmed.',
      DateTime.utc(2026, 10, 5, 11, 32),
    ),
  ];

  Future<void> openStatus(WidgetTester tester) async {
    await tester.tap(find.text('Status'));
    await tester.pump(const Duration(milliseconds: 100));
  }

  golden('05 chat', (tester) async {
    await detail(
      tester,
      '05_chat',
      ticket: base(TicketStatus.inProgress),
      history: inProgress,
    );
  });

  golden('06 status popover, in progress', (tester) async {
    await detail(
      tester,
      '06_status_progress',
      ticket: base(TicketStatus.inProgress),
      history: inProgress,
      before: openStatus,
    );
  });

  golden('07 status popover, resolved', (tester) async {
    await detail(
      tester,
      '07_status_resolved',
      ticket: base(TicketStatus.resolved),
      history: inProgress,
      before: (t) async {
        await t.tap(find.text('Status'));
        await t.pump(const Duration(milliseconds: 100));
      },
    );
  });

  golden('08 rating popup', (tester) async {
    await detail(
      tester,
      '08_rating',
      ticket: base(TicketStatus.resolved),
      history: inProgress,
      before: (t) async {
        final stars = find.byType(SvgPicture);
        await t.tap(
          find.descendant(of: find.byType(RatingPopup), matching: stars).at(3),
        );
        await t.pump(const Duration(milliseconds: 100));
      },
    );
  });
}
