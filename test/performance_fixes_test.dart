import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
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
import 'package:finskool/src/presentation/pages/dashboard/performance/performance_format.dart';
import 'package:finskool/src/presentation/pages/dashboard/performance/performance_screen.dart';
import 'package:finskool/src/presentation/pages/dashboard/performance/widgets/trade_list.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'support/ticket_fakes.dart';

SwingTrade _trade(int i, {double? ret = 1.234}) => SwingTrade(
  id: 't$i',
  tradeDate: DateTime(2026, 10, 30).subtract(Duration(days: i)),
  name: 'Trade $i',
  symbol: 'T$i',
  entryPrice: 100,
  cmp: 101,
  returnPct: ret,
  targetMet: false,
  targetPct: 5,
  targetPrice: 105,
  analysis: null,
  exitDate: null,
  holdingDays: null,
);

class _Repo implements PerformanceRepository {
  _Repo(this.board);
  final PerformanceBoard board;

  @override
  Future<Either<Failure, List<PerformanceBoardEntry>>> getBoards() async =>
      const Right([]);

  @override
  Future<Either<Failure, PerformanceBoard>> getBoard({
    required String communityId,
    PerformanceSegment? segment,
    PerformanceMonthFilter? filter,
    String? cursor,
  }) async => Right(board);
}

PerformanceBoard _board({required int shown, required int total}) =>
    PerformanceBoard(
      communityId: 'c1',
      communityName: 'Swing Alpha',
      kind: PerformanceKind.swing,
      isPaid: true,
      segment: PerformanceSegment.main,
      segments: const [PerformanceSegment.main],
      filter: null,
      months: const ['2026-10'],
      summary: SwingSummary(
        averageHoldingDays: 46.3,
        totalTrades: total,
        periods: const [],
      ),
      noteText: null,
      hiddenCount: null,
      items: [for (var i = 0; i < shown; i++) _trade(i)],
      nextCursor: null,
    );

void main() {
  setUpAll(loadAppFonts);

  group('the same period is shown once', () {
    HitRatePeriod p(String label, int given) => HitRatePeriod(
      id: label,
      label: label,
      given: given,
      met: 1,
      metPct: 50,
    );

    test('a period added twice by the admin comes through once', () {
      final out = uniquePeriods([
        p('Jun26 to Nov26', 10),
        p('Jun26 to Nov26', 10),
      ]);
      expect(out.map((e) => e.label), ['Jun26 to Nov26']);
    });

    test('other periods stay, in order, and the first duplicate wins', () {
      final out = uniquePeriods([
        p('Oct25 to Aug26', 44),
        p('Jun26 to Nov26', 10),
        p(' jun26 to nov26 ', 99),
        p('Sep26 to Nov26', 3),
      ]);
      expect(out.map((e) => e.label), [
        'Oct25 to Aug26',
        'Jun26 to Nov26',
        'Sep26 to Nov26',
      ]);
      expect(out[1].given, 10);
    });

    test('SwingSummary.fromJson applies it to the API payload', () {
      final dup = {
        'id': 'a',
        'label': 'Jun26 to Nov26',
        'given': 10,
        'met': 5,
        'metPct': 50,
      };
      final s = SwingSummary.fromJson({
        'totalTrades': 48,
        'periods': [dup, dup],
      });
      expect(s.periods, hasLength(1));
    });
  });

  test('US prices carry a dollar sign and thousands grouping', () {
    expect(formatUsd(1147), '\$1,147.00');
    expect(formatUsd(1410.99), '\$1,410.99');
    expect(formatUsd(99.5), '\$99.50');
    expect(formatUsd(1234567.891), '\$1,234,567.89');
    expect(formatUsd(-2500), '-\$2,500.00');
  });

  test('each investor tab has the sheet\'s own heading', () {
    const name = 'Investor Community';
    expect(
      PerformanceSegment.investor.dashboardTitle(name),
      'Investor Community Dashboard',
    );
    expect(
      PerformanceSegment.longTerm.dashboardTitle(name),
      'Long Term Dashboard',
    );
    expect(
      PerformanceSegment.usInvestment.dashboardTitle(name),
      'US Stocks Dashboard',
    );
    expect(PerformanceSegment.main.dashboardTitle(''), 'Trades');
  });

  testWidgets('the count badge is the real total, not the page size', (
    tester,
  ) async {
    Future<void> show({int? total, bool more = false, int rows = 3}) =>
        tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.light,
            home: Scaffold(
              body: SingleChildScrollView(
                child: TradeList(
                  title: 'T',
                  trades: [for (var i = 0; i < rows; i++) _trade(i)],
                  hasMore: more,
                  totalTrades: total,
                ),
              ),
            ),
          ),
        );
    await show(total: 57, more: true);
    expect(find.text('57 trades'), findsOneWidget);
    await show(total: 2, rows: 2);
    expect(find.text('2 trades'), findsOneWidget);
    await show(total: 1, rows: 1);
    expect(find.text('1 trade'), findsOneWidget);
    // No total known: the loaded rows, with a plus while more pages remain.
    await show(more: true);
    expect(find.text('3+ trades'), findsOneWidget);
  });

  group('profit and loss percentages', () {
    test('a profit has a plus, a loss a minus', () {
      expect(formatSignedPct(1.23), '+1.23%');
      expect(formatSignedPct(-14.79), '-14.79%');
    });

    test('zero, and anything that rounds to it, has no sign', () {
      expect(formatSignedPct(0), '0.00%');
      expect(formatSignedPct(0.004), '0.00%');
      expect(formatSignedPct(-0.004), '0.00%');
    });

    test('a plain share is untouched', () {
      expect(formatPct(77.27), '77.27%');
    });
  });

  group('S.N. follows the admin (oldest is 1, so the newest is the total)', () {
    test('serialFor counts down from the total', () {
      expect(serialFor(0, 30, 48), 48);
      expect(serialFor(1, 30, 48), 47);
      expect(serialFor(29, 30, 48), 19);
    });

    test('no total, or a total below what is loaded, numbers nothing', () {
      expect(serialFor(0, 30, null), isNull);
      expect(serialFor(0, 30, 10), isNull);
    });

    testWidgets('a paid list reads #48, #47…; with no total there is no #', (
      tester,
    ) async {
      Future<void> show(int? total) => tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            body: SingleChildScrollView(
              child: TradeList(
                title: 'Swing Alpha Dashboard',
                trades: [_trade(0), _trade(1), _trade(2)],
                hasMore: false,
                totalTrades: total,
              ),
            ),
          ),
        ),
      );
      await show(48);
      expect(find.textContaining('#48'), findsOneWidget);
      expect(find.textContaining('#47'), findsOneWidget);
      expect(find.textContaining('#46'), findsOneWidget);
      expect(find.textContaining('#01'), findsNothing);

      await show(null);
      expect(find.textContaining('#'), findsNothing);
    });
  });

  group('the Long Term tab shows only the client sheet\'s columns', () {
    SwingTrade lt() => SwingTrade(
      id: 'x',
      tradeDate: DateTime(2026, 8, 1),
      name: 'Acme Ltd',
      symbol: 'ACME',
      entryPrice: 100,
      cmp: 120,
      returnPct: 20,
      targetMet: true,
      targetPct: 10,
      targetPrice: 110,
      analysis: 'HOLD',
      exitDate: DateTime(2026, 9, 1),
      holdingDays: 31,
      theme: 'EV',
      sector: 'Auto',
      stockType: 'Large',
    );

    testWidgets('no target, exit date, holding days or Target Met badge', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            body: SingleChildScrollView(
              child: TradeList(
                title: 'Investor Dashboard',
                trades: [lt()],
                hasMore: false,
                segment: PerformanceSegment.longTerm,
              ),
            ),
          ),
        ),
      );
      for (final gone in [
        'Target',
        'Target Price',
        'Exit Date',
        'Holding Days',
        'Target Met',
      ]) {
        expect(find.text(gone), findsNothing, reason: gone);
      }
      expect(find.text('+20.00%'), findsOneWidget);
      expect(find.text('Theme / Sector / Type'), findsOneWidget);
      expect(find.text('EV / Auto / Large'), findsOneWidget);
      expect(find.text('HOLD'), findsOneWidget);
    });

    testWidgets('US Investment is the same, with a "Theme" cell', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            body: SingleChildScrollView(
              child: TradeList(
                title: 'Investor Dashboard',
                trades: [lt()],
                hasMore: false,
                segment: PerformanceSegment.usInvestment,
              ),
            ),
          ),
        ),
      );
      expect(find.text('\$100.00'), findsOneWidget);
      expect(find.text('\$120.00'), findsOneWidget);
      expect(find.text('Theme'), findsOneWidget);
      expect(find.text('Target Price'), findsNothing);
      expect(find.text('Exit Date'), findsNothing);
      expect(find.text('Holding Days'), findsNothing);
    });

    test('the classification is read from theme, sector and type', () {
      final t = SwingTrade.fromJson(
        {
          'id': 'a',
          'tradeDate': '2026-08-01',
          'name': 'A',
          'theme': 'EV',
          'sector': ' ',
          'type': 'Large',
        },
        'a',
        DateTime(2026, 8, 1),
      );
      expect(t.classification, 'EV / Large');
    });
  });

  testWidgets('the whole Performance screen scrolls to the last trade', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final bloc = PerformanceBloc(
      GetPerformanceBoard(_Repo(_board(shown: 30, total: 48))),
    )..add(const PerformanceEvent.load(communityId: 'c1'));
    addTearDown(bloc.close);
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: BlocProvider.value(
          value: bloc,
          child: const PerformanceView(communityId: 'c1'),
        ),
      ),
    );
    for (var i = 0; i < 6; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }

    expect(find.text('Trade 0'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Trade 29'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Trade 29'), findsOneWidget);
    // …and it carries the admin's number: 48 - 29 = 19.
    expect(find.textContaining('#19'), findsOneWidget);
  });
}
