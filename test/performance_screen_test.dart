import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/performance/performance_board.dart';
import 'package:finskool/src/domain/model/performance/performance_board_entry.dart';
import 'package:finskool/src/domain/model/performance/performance_filter.dart';
import 'package:finskool/src/domain/model/performance/performance_kind.dart';
import 'package:finskool/src/domain/model/performance/performance_summary.dart';
import 'package:finskool/src/domain/model/performance/performance_trade.dart';
import 'package:finskool/src/domain/repository/performance_repository.dart';
import 'package:finskool/src/domain/usecases/performance/get_performance_board.dart';
import 'package:finskool/src/presentation/bloc/performance/board/performance_bloc.dart';
import 'package:finskool/src/presentation/pages/dashboard/performance/performance_screen.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'support/ticket_fakes.dart';

class _Repo implements PerformanceRepository {
  Future<Either<Failure, PerformanceBoard>> Function(
    String?,
    PerformanceMonthFilter?,
  )
  answer = (_, _) async => Right(_board());
  final calls = <String>[];

  @override
  Future<Either<Failure, List<PerformanceBoardEntry>>> getBoards() async =>
      const Right([]);

  @override
  Future<Either<Failure, PerformanceBoard>> getBoard({
    required String communityId,
    PerformanceSegment? segment,
    PerformanceMonthFilter? filter,
    String? cursor,
  }) {
    final f = filter == null ? null : '${filter.from}..${filter.to}';
    calls.add('${segment?.wire}|$f');
    return answer(segment?.wire, filter);
  }
}

const _months = ['2026-10', '2026-09', '2026-08'];

PerformanceBoard _board({
  bool paid = false,
  int? hidden = 41,
  PerformanceKind kind = PerformanceKind.swing,
  List<PerformanceSegment> segments = const [PerformanceSegment.main],
  PerformanceSegment segment = PerformanceSegment.main,
  PerformanceMonthFilter? filter,
  HitRatePeriod? range,
}) {
  final intraday = kind == PerformanceKind.intraday;
  return PerformanceBoard(
    communityId: 'c1',
    communityName: intraday ? 'Intraday Edge' : 'Swing Alpha',
    kind: kind,
    isPaid: paid,
    segment: segment,
    segments: segments,
    filter: filter,
    months: _months,
    summary: intraday
        ? const IntradaySummary(
            capitalDeployed: 50000,
            grossPnl: 2744,
            totalCharges: 3920,
            overallPnl: -1176,
            totalTrades: 28,
            profitMakingTrades: 14,
            lossMakingTrades: 12,
            profitMakingPct: 50,
            lossMakingPct: 42.86,
          )
        : SwingSummary(
            averageHoldingDays: 46.3,
            totalTrades: 48,
            range: range,
            periods: const [
              HitRatePeriod(
                id: 'p',
                label: 'Oct25 to Aug26',
                given: 44,
                met: 34,
                metPct: 77.27,
              ),
            ],
          ),
    noteText: null,
    hiddenCount: paid ? null : hidden,
    items: [
      if (intraday)
        IntradayTrade(
          id: 'i1',
          tradeDate: DateTime(2026, 10, 1),
          name: 'Ambuja Cement',
          side: TradeSide.buy,
          entryPrice: 368.2,
          exitPrice: 365.7,
          plPerShare: -2.5,
          plPct: -3.39,
          grossPnl: -1697,
          charges: 140,
          netPnl: -1837,
        )
      else
        SwingTrade(
          id: 's1',
          tradeDate: DateTime(2026, 8, 12),
          name: 'BLS International',
          symbol: 'BLS',
          entryPrice: 262,
          cmp: 209.98,
          returnPct: null,
          targetMet: true,
          targetPct: 5,
          targetPrice: 275.1,
          analysis: null,
          exitDate: DateTime(2026, 8, 14),
          holdingDays: 2,
        ),
    ],
    nextCursor: null,
  );
}

void main() {
  setUpAll(loadAppFonts);

  late _Repo repo;

  Future<void> pumpScreen(WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 3000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    // Inside the test: a bloc built in `setUp` lives outside the fake-async
    // zone and its streams never flush.
    final bloc = PerformanceBloc(GetPerformanceBoard(repo))
      ..add(const PerformanceEvent.load(communityId: 'c1'));
    addTearDown(bloc.close);
    final router = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (_, _) => const Text('plans list')),
        GoRoute(
          path: '/perf',
          builder: (_, _) => BlocProvider.value(
            value: bloc,
            child: const PerformanceView(
              communityId: 'c1',
              communityName: 'Swing Alpha',
            ),
          ),
        ),
      ],
      initialLocation: '/',
    );
    await tester.pumpWidget(
      MaterialApp.router(theme: AppTheme.light, routerConfig: router),
    );
    router.push('/perf');
    for (var i = 0; i < 6; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
  }

  Future<void> settle(WidgetTester tester) async {
    for (var i = 0; i < 6; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
  }

  Future<void> pick(WidgetTester tester, String pill, String month) async {
    await tester.tap(find.textContaining(pill));
    await settle(tester);
    await tester.tap(find.text(month).last);
    await settle(tester);
  }

  setUp(() => repo = _Repo());

  testWidgets('a free member sees the preview, the summary and the banner', (
    tester,
  ) async {
    await pumpScreen(tester);
    expect(find.text('BLS International'), findsOneWidget);
    expect(find.text('Target Met'), findsOneWidget);
    expect(find.text('Oct25 to Aug26'), findsOneWidget);
    expect(find.text('Members only'), findsOneWidget);
    expect(find.text('Unlock live trades'), findsOneWidget);
    expect(find.text('Past trades'), findsOneWidget);
  });

  testWidgets('View plans goes back to the list the screen came from', (
    tester,
  ) async {
    await pumpScreen(tester);
    await tester.tap(find.text('View plans  →'));
    await settle(tester);
    expect(find.text('plans list'), findsOneWidget);
  });

  testWidgets('a paid member has no banner', (tester) async {
    repo.answer = (_, _) async => Right(_board(paid: true));
    await pumpScreen(tester);
    expect(find.text('Members only'), findsNothing);
    expect(find.text('BLS International'), findsOneWidget);
  });

  testWidgets(
    'an investor board has three tabs, and a tap asks for that segment',
    (tester) async {
      repo.answer = (segment, _) async => Right(
        _board(
          paid: true,
          kind: PerformanceKind.investor,
          segments: const [
            PerformanceSegment.investor,
            PerformanceSegment.longTerm,
            PerformanceSegment.usInvestment,
          ],
          segment:
              PerformanceSegmentX.fromWire(segment) ??
              PerformanceSegment.investor,
        ),
      );
      await pumpScreen(tester);
      expect(find.text('Investor'), findsOneWidget);
      expect(find.text('US Investment'), findsOneWidget);
      await tester.tap(find.text('Long Term'));
      await settle(tester);
      expect(repo.calls.last, 'long_term|null');
    },
  );

  group('month filter', () {
    testWidgets('intraday has one picker; a month narrows the whole screen', (
      tester,
    ) async {
      repo.answer = (_, filter) async => Right(
        _board(paid: true, kind: PerformanceKind.intraday, filter: filter),
      );
      await pumpScreen(tester);
      expect(find.text('Month: All months'), findsOneWidget);
      expect(find.textContaining('From:'), findsNothing);

      await pick(tester, 'Month:', 'August 2026');
      // A single month goes out as the range 08..08 (sent as `month=`).
      expect(repo.calls.last, 'main|2026-08..2026-08');
      expect(find.text('Month: August 2026'), findsOneWidget);
    });

    testWidgets('swing needs both ends: From alone asks for nothing', (
      tester,
    ) async {
      await pumpScreen(tester);
      expect(find.text('From: Select'), findsOneWidget);
      expect(find.text('To: Select'), findsOneWidget);
      final before = repo.calls.length;
      await pick(tester, 'From:', 'August 2026');
      expect(repo.calls.length, before);
    });

    testWidgets('swing asks once both ends are set, then ✕ clears it', (
      tester,
    ) async {
      repo.answer = (_, filter) async => Right(
        _board(
          filter: filter,
          range: filter == null
              ? null
              : const HitRatePeriod(
                  id: '',
                  label: 'Aug26 to Sep26',
                  given: 11,
                  met: 8,
                  metPct: 72.73,
                ),
        ),
      );
      await pumpScreen(tester);
      await pick(tester, 'From:', 'August 2026');
      await pick(tester, 'To:', 'September 2026');
      expect(repo.calls.last, 'main|2026-08..2026-09');
      // The range card replaces the admin's period card while a filter is on.
      expect(find.text('Aug26 to Sep26'), findsOneWidget);
      expect(find.text('Oct25 to Aug26'), findsNothing);

      await tester.tap(find.byTooltip('Clear filter'));
      await settle(tester);
      expect(repo.calls.last, 'main|null');
      expect(find.text('Oct25 to Aug26'), findsOneWidget);
      expect(find.text('Aug26 to Sep26'), findsNothing);
    });

    testWidgets('To cannot be earlier than From', (tester) async {
      await pumpScreen(tester);
      await pick(tester, 'From:', 'September 2026');
      await tester.tap(find.textContaining('To:'));
      await settle(tester);
      final august = tester.widget<PopupMenuItem<String>>(
        find.widgetWithText(PopupMenuItem<String>, 'August 2026'),
      );
      final october = tester.widget<PopupMenuItem<String>>(
        find.widgetWithText(PopupMenuItem<String>, 'October 2026'),
      );
      expect(august.enabled, isFalse);
      expect(october.enabled, isTrue);
    });

    testWidgets('moving From past To pulls To up with it', (tester) async {
      await pumpScreen(tester);
      await pick(tester, 'From:', 'August 2026');
      await pick(tester, 'To:', 'September 2026');
      await pick(tester, 'From:', 'October 2026');
      expect(repo.calls.last, 'main|2026-10..2026-10');
      expect(find.text('To: October 2026'), findsOneWidget);
    });

    testWidgets('a free member who picks a quiet month still sees the banner', (
      tester,
    ) async {
      repo.answer = (_, filter) async => Right(
        filter == null
            ? _board()
            : PerformanceBoard(
                communityId: 'c1',
                communityName: 'Swing Alpha',
                kind: PerformanceKind.swing,
                isPaid: false,
                segment: PerformanceSegment.main,
                segments: const [PerformanceSegment.main],
                filter: filter,
                months: _months,
                summary: const SwingSummary(
                  averageHoldingDays: null,
                  totalTrades: 0,
                  periods: [],
                ),
                noteText: null,
                hiddenCount: 7,
                items: const [],
                nextCursor: null,
              ),
      );
      await pumpScreen(tester);
      await pick(tester, 'From:', 'August 2026');
      await pick(tester, 'To:', 'August 2026');
      expect(find.text('No trades to preview yet'), findsOneWidget);
      expect(find.text('Unlock live trades'), findsOneWidget);
    });
  });

  testWidgets('a community with no board says so instead of offering a retry', (
    tester,
  ) async {
    repo.answer = (_, _) async => const Left(
      ServerFailure('Not found.', code: 'PERFORMANCE_BOARD_NOT_FOUND'),
    );
    await pumpScreen(tester);
    expect(find.text('No performance to show yet'), findsOneWidget);
    expect(find.text('Try again'), findsNothing);
  });

  testWidgets('a failed load shows the server\'s words and retries', (
    tester,
  ) async {
    repo.answer = (_, _) async => const Left(ServerFailure('Server is down.'));
    await pumpScreen(tester);
    expect(find.text("Couldn't load performance"), findsOneWidget);
    expect(find.text('Server is down.'), findsOneWidget);
    final before = repo.calls.length;
    await tester.tap(find.text('Try again'));
    await tester.pump(const Duration(milliseconds: 100));
    expect(repo.calls.length, before + 1);
  });
}
