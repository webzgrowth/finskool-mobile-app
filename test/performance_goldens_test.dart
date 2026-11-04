@Tags(['golden'])
library;

import 'dart:io';
import 'dart:ui' as ui;

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
import 'package:finskool/src/presentation/pages/dashboard/performance/performance_screen.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'support/ticket_fakes.dart';

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

IntradayTrade _intraday(String name, TradeSide side, double net) =>
    IntradayTrade(
      id: name,
      tradeDate: DateTime(2026, 10, 1),
      name: name,
      side: side,
      entryPrice: 368.2,
      exitPrice: 365.7,
      plPerShare: net > 0 ? 2.5 : -2.5,
      plPct: net > 0 ? 1.4 : -3.39,
      grossPnl: net + 140,
      charges: 140,
      netPnl: net,
    );

SwingTrade _swing(String name, {bool met = false}) => SwingTrade(
  id: name,
  tradeDate: DateTime(2026, 8, 12),
  name: name,
  symbol: 'SYM',
  entryPrice: 262,
  cmp: met ? 209.98 : null,
  returnPct: met ? null : -4.2,
  targetMet: met,
  targetPct: 5,
  targetPrice: 275.1,
  analysis: met ? '5% booked' : 'HOLD',
  exitDate: met ? DateTime(2026, 8, 14) : null,
  holdingDays: met ? 2 : null,
);

final _intradayBoard = PerformanceBoard(
  communityId: 'c1',
  communityName: 'Intraday Edge',
  kind: PerformanceKind.intraday,
  isPaid: true,
  segment: PerformanceSegment.main,
  segments: const [PerformanceSegment.main],
  filter: null,
  months: const ['2026-10', '2026-09', '2026-08'],
  summary: const IntradaySummary(
    capitalDeployed: 50000,
    grossPnl: 2744,
    totalCharges: 3920,
    overallPnl: -1176,
    totalTrades: 28,
    profitMakingTrades: 14,
    lossMakingTrades: 12,
    profitMakingPct: 50,
    lossMakingPct: 42.86,
  ),
  noteText:
      'Note: All calculations are done assuming INR 50,000 capital deployed '
      'and 5X margin used in each trade.',
  hiddenCount: null,
  items: [
    _intraday('Muthoot Finance', TradeSide.buy, 1231),
    _intraday('Ambuja Cement', TradeSide.sell, -1837),
    _intraday('Tata Steel', TradeSide.buy, 562),
  ],
  nextCursor: null,
);

final _swingBoard = PerformanceBoard(
  communityId: 'c2',
  communityName: 'Swing Alpha',
  kind: PerformanceKind.swing,
  isPaid: false,
  segment: PerformanceSegment.main,
  segments: const [PerformanceSegment.main],
  filter: const PerformanceMonthFilter(from: '2026-08', to: '2026-09'),
  months: const ['2026-10', '2026-09', '2026-08'],
  summary: const SwingSummary(
    averageHoldingDays: 12.4,
    totalTrades: 11,
    range: HitRatePeriod(
      id: '',
      label: 'Aug26 to Sep26',
      given: 11,
      met: 8,
      metPct: 72.73,
    ),
    periods: [
      HitRatePeriod(
        id: 'p1',
        label: 'Oct25 to Aug26',
        given: 44,
        met: 34,
        metPct: 77.27,
      ),
    ],
  ),
  noteText: null,
  hiddenCount: 7,
  items: [_swing('BLS International', met: true), _swing('Open Trade Ltd')],
  nextCursor: null,
);

/// Renders the Performance screen to `build/performance_goldens/` — the
/// intraday board beside Figma's export of `1554:6103`
/// (`build/figma_perf/full.png`); the swing board has no Figma frame.
void main() {
  setUpAll(loadAppFonts);

  Future<void> render(
    WidgetTester tester,
    String name,
    PerformanceBoard board,
  ) async {
    debugDisableShadows = false;
    try {
      tester.view.physicalSize = const Size(786, 2400);
      tester.view.devicePixelRatio = 2;
      addTearDown(tester.view.reset);
      // Created inside the test: a bloc built in `setUp` lives outside the
      // fake-async zone and its streams never flush.
      final bloc = PerformanceBloc(GetPerformanceBoard(_Repo(board)))
        ..add(PerformanceEvent.load(communityId: board.communityId));
      addTearDown(bloc.close);
      final key = GlobalKey();
      await tester.pumpWidget(
        RepaintBoundary(
          key: key,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            home: MediaQuery(
              data: const MediaQueryData(
                size: Size(393, 1200),
                padding: EdgeInsets.only(top: 44),
              ),
              child: BlocProvider.value(
                value: bloc,
                child: PerformanceView(
                  communityId: board.communityId,
                  communityName: board.communityName,
                ),
              ),
            ),
          ),
        ),
      );
      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(milliseconds: 50));
      }
      await tester.runAsync(
        () => precacheImage(
          const AssetImage('assets/images/performance_header_bg.png'),
          tester.element(find.byType(PerformanceView)),
        ),
      );
      await tester.pump();
      await tester.runAsync(() async {
        final boundary =
            key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
        final image = await boundary.toImage(pixelRatio: 2);
        final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
        Directory('build/performance_goldens').createSync(recursive: true);
        File('build/performance_goldens/$name.png')
            .writeAsBytesSync(bytes!.buffer.asUint8List());
      });
    } finally {
      debugDisableShadows = true;
    }
  }

  testWidgets('intraday', (t) => render(t, 'intraday', _intradayBoard));
  testWidgets(
    'swing, free member, Aug–Sep filter',
    (t) => render(t, 'swing', _swingBoard),
  );
}
