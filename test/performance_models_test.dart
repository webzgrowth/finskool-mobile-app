import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/comman/exception.dart';
import 'package:finskool/src/domain/model/performance/performance_board.dart';
import 'package:finskool/src/domain/model/performance/performance_board_entry.dart';
import 'package:finskool/src/domain/model/performance/performance_filter.dart';
import 'package:finskool/src/domain/model/performance/performance_kind.dart';
import 'package:finskool/src/domain/model/performance/performance_summary.dart';
import 'package:finskool/src/domain/model/performance/performance_trade.dart';
import 'package:finskool/src/presentation/pages/dashboard/performance/performance_format.dart';

/// The shapes are those in `mobile-performance-integration.md` §3–4.
Map<String, dynamic> _intraday({bool paid = true}) => {
  'communityId': 'c1',
  'communityName': 'Intraday Edge',
  'kind': 'intraday',
  'access': paid ? 'paid' : 'free',
  'segment': 'main',
  'segments': ['main'],
  'summary': {
    'kind': 'intraday',
    'capitalDeployed': 50000,
    'grossPnl': 2744,
    'totalCharges': 3920,
    'overallPnl': -1176,
    'totalTrades': 28,
    'profitMakingTrades': 14,
    'lossMakingTrades': 12,
    'profitMakingPct': 50,
    'lossMakingPct': 42.86,
  },
  'noteText': 'All calculations are done assuming INR 50,000 capital.',
  'hiddenCount': paid ? null : 21,
  'items': [
    {
      'id': 't1',
      'tradeDate': '2026-10-01',
      'name': 'Ambuja Cement',
      'side': 'buy',
      'entryPrice': 368.2,
      'exitPrice': 365.7,
      'plPerShare': -2.5,
      'plPct': -3.39,
      'grossPnl': -1697,
      'charges': 140,
      'netPnl': -1837,
    },
  ],
  'nextCursor': 'abc',
};

Map<String, dynamic> _swing() => {
  'communityId': 'c2',
  'communityName': 'Swing Alpha',
  'kind': 'swing',
  'access': 'free',
  'segment': 'main',
  'segments': ['main'],
  'summary': {
    'kind': 'swing',
    'averageHoldingDays': 46.3,
    'totalTrades': 48,
    'periods': [
      {
        'id': 'p1',
        'segment': 'main',
        'fromMonth': '2025-10',
        'toMonth': '2026-08',
        'label': 'Oct25 to Aug26',
        'given': 44,
        'met': 34,
        'metPct': 77.27,
      },
    ],
  },
  'noteText': null,
  'hiddenCount': 41,
  'items': [
    {
      'id': 's1',
      'tradeDate': '2026-08-12',
      'name': 'BLS International',
      'symbol': 'BLS',
      'entryPrice': 262,
      'cmp': 209.98,
      'returnPct': -19.85,
      'status': 'target_met',
      'targetPct': 5,
      'targetPrice': 275.1,
      'analysis': '5% booked',
      'exitDate': '2026-08-14',
      'holdingDays': 2,
    },
    {
      'id': 's2',
      'tradeDate': '2026-09-01',
      'name': 'Open Trade Ltd',
      'symbol': 'OPN',
      'entryPrice': 100,
      'cmp': null,
      'returnPct': null,
      'status': 'open',
      'targetPct': 8,
      'targetPrice': 108,
      'analysis': null,
      'exitDate': null,
      'holdingDays': null,
    },
  ],
  'nextCursor': null,
};

void main() {
  group('intraday board', () {
    final board = PerformanceBoard.fromJson(_intraday());

    test(
      'summary carries the server\'s figures, charges as a positive cost',
      () {
        final s = board.summary as IntradaySummary;
        expect(s.overallPnl, -1176);
        expect(s.totalCharges, 3920);
        expect(s.totalTrades, 28);
        expect(s.profitMakingPct, 50);
        // 50 + 42.86 < 100: a flat trade is neither.
        expect(s.lossMakingPct, 42.86);
      },
    );

    test('bars scale to the larger magnitude', () {
      final s = board.summary as IntradaySummary;
      expect(s.chargesFraction, 1);
      expect(s.grossFraction, closeTo(2744 / 3920, 1e-9));
    });

    test('a trade row reads every column', () {
      final t = board.items.single as IntradayTrade;
      expect(t.side, TradeSide.buy);
      expect([t.entryPrice, t.exitPrice, t.plPerShare], [368.2, 365.7, -2.5]);
      expect([t.grossPnl, t.charges, t.netPnl], [-1697, 140, -1837]);
      // A calendar date, not an instant.
      expect(t.tradeDate, DateTime(2026, 10, 1));
      expect(t.initials, 'AC');
    });

    test('paid has no hiddenCount; free has one; the note is the banner', () {
      expect(board.isPaid, isTrue);
      expect(board.hiddenCount, isNull);
      expect(board.noteText, contains('INR 50,000'));
      final free = PerformanceBoard.fromJson(_intraday(paid: false));
      expect(free.isPaid, isFalse);
      expect(free.hiddenCount, 21);
    });
  });

  group('swing board', () {
    final board = PerformanceBoard.fromJson(_swing());

    test('summary has the hit-rate cards and an average', () {
      final s = board.summary as SwingSummary;
      expect(s.averageHoldingDays, 46.3);
      expect(s.periods.single.label, 'Oct25 to Aug26');
      expect([s.periods.single.given, s.periods.single.met], [44, 34]);
      expect(s.periods.single.metPct, 77.27);
      expect(board.noteText, isNull);
    });

    test('target met is the exit date, never the CMP', () {
      final t = board.items.first as SwingTrade;
      expect(t.targetMet, isTrue);
      expect(t.cmp, lessThan(t.entryPrice));
      expect(t.exitDate, DateTime(2026, 8, 14));
      expect(t.holdingDays, 2);
      expect(t.analysis, '5% booked');
    });

    test('an open trade keeps every unknown as null', () {
      final t = board.items.last as SwingTrade;
      expect(t.isOpen, isTrue);
      expect(
        [t.cmp, t.returnPct, t.exitDate, t.holdingDays],
        [null, null, null, null],
      );
      expect(t.analysis, isNull);
      expect(t.targetMet, isFalse);
    });

    test('average holding days is null until a trade closes', () {
      final json = _swing();
      json['summary'] = <String, dynamic>{
        ...(json['summary'] as Map<String, dynamic>),
        'averageHoldingDays': null,
      };
      final s = PerformanceBoard.fromJson(json).summary as SwingSummary;
      expect(s.averageHoldingDays, isNull);
    });
  });

  test('investor segments parse, including long_term and us_investment', () {
    final json = _swing()
      ..['kind'] = 'investor'
      ..['segment'] = 'long_term'
      ..['segments'] = ['investor', 'long_term', 'us_investment'];
    (json['summary'] as Map<String, dynamic>)['kind'] = 'investor';
    final board = PerformanceBoard.fromJson(json);
    expect(board.kind, PerformanceKind.investor);
    expect(board.segment, PerformanceSegment.longTerm);
    expect(board.segments, [
      PerformanceSegment.investor,
      PerformanceSegment.longTerm,
      PerformanceSegment.usInvestment,
    ]);
    expect(PerformanceSegment.usInvestment.wire, 'us_investment');
    expect(PerformanceSegment.longTerm.label, 'Long Term');
  });

  test('boards list: an unknown kind drops that board only', () {
    final ok = PerformanceBoardEntry.fromJson({
      'communityId': 'c1',
      'name': 'A',
      'slug': 'a',
      'kind': 'swing',
      'segments': ['main'],
      'access': 'free',
    });
    expect(ok!.kind, PerformanceKind.swing);
    expect(ok.isPaid, isFalse);
    expect(
      PerformanceBoardEntry.fromJson({'communityId': 'x', 'kind': 'futures'}),
      isNull,
    );
  });

  test(
    'a summary of a kind this build cannot show is an error, not a guess',
    () {
      expect(
        () => PerformanceSummary.fromJson({'kind': 'options'}),
        throwsA(isA<ApiException>()),
      );
    },
  );

  test('a row with no id or date is skipped, not drawn half-empty', () {
    final json = _swing();
    (json['items'] as List).add({'name': 'No id'});
    expect(PerformanceBoard.fromJson(json).items, hasLength(2));
  });

  group('month filter (summary and trades narrowed together)', () {
    test('filter and months are read; no filter is null', () {
      final plain = PerformanceBoard.fromJson(_swing());
      expect(plain.filter, isNull);
      expect(plain.months, isEmpty);

      final json = _swing()
        ..['filter'] = {'fromMonth': '2026-08', 'toMonth': '2026-09'}
        ..['months'] = ['2026-10', '2026-09', '2026-08', '2026-07'];
      final board = PerformanceBoard.fromJson(json);
      expect(
        board.filter,
        const PerformanceMonthFilter(from: '2026-08', to: '2026-09'),
      );
      expect(board.months.first, '2026-10');
      expect(board.months, hasLength(4));
    });

    test('a swing range card is read; the admin periods stay as they were', () {
      final json = _swing();
      json['summary'] = <String, dynamic>{
        ...(json['summary'] as Map<String, dynamic>),
        'range': {
          'fromMonth': '2026-08',
          'toMonth': '2026-09',
          'label': 'Aug26 to Sep26',
          'given': 11,
          'met': 8,
          'metPct': 72.73,
        },
      };
      final s = PerformanceBoard.fromJson(json).summary as SwingSummary;
      expect(s.range!.label, 'Aug26 to Sep26');
      expect([s.range!.given, s.range!.met, s.range!.metPct], [11, 8, 72.73]);
      expect(s.periods, hasLength(1));
    });

    test('with no filter the range is null', () {
      final s = PerformanceBoard.fromJson(_swing()).summary as SwingSummary;
      expect(s.range, isNull);
    });

    test('a single month and a run compare, order and report themselves', () {
      const one = PerformanceMonthFilter.single('2026-08');
      expect(one.isSingleMonth, isTrue);
      expect(one, const PerformanceMonthFilter(from: '2026-08', to: '2026-08'));
      expect(
        const PerformanceMonthFilter(from: '2026-09', to: '2026-08').isValid,
        isFalse,
      );
      // A run may span a year end.
      expect(
        const PerformanceMonthFilter(from: '2025-11', to: '2026-02').isValid,
        isTrue,
      );
    });

    test('an intraday month with no trades is zeroed, not an error', () {
      final json = _intraday();
      json['summary'] = <String, dynamic>{
        'kind': 'intraday',
        'capitalDeployed': 50000,
        'grossPnl': 0,
        'totalCharges': 0,
        'overallPnl': 0,
        'totalTrades': 0,
        'profitMakingTrades': 0,
        'lossMakingTrades': 0,
        'profitMakingPct': 0,
        'lossMakingPct': 0,
      };
      json['items'] = <Object>[];
      json['nextCursor'] = null;
      final board = PerformanceBoard.fromJson(json);
      final s = board.summary as IntradaySummary;
      expect(s.totalTrades, 0);
      expect(s.capitalDeployed, 50000);
      // No division by zero in the bar widths.
      expect(s.grossFraction, 0);
      expect(board.items, isEmpty);
    });
  });

  group('stock logo', () {
    test('logoUrl is read on intraday and swing rows', () {
      final intraday = _intraday();
      ((intraday['items'] as List).first as Map<String, dynamic>)['logoUrl'] =
          'https://x.test/ambuja.png';
      final i = PerformanceBoard.fromJson(intraday).items.single;
      expect(i.logoUrl, 'https://x.test/ambuja.png');

      final swing = _swing();
      ((swing['items'] as List).first as Map<String, dynamic>)['logoUrl'] =
          'https://x.test/bls.png';
      expect(
        PerformanceBoard.fromJson(swing).items.first.logoUrl,
        'https://x.test/bls.png',
      );
    });

    test('null or empty means initials, which is normal', () {
      final json = _swing();
      ((json['items'] as List).first as Map<String, dynamic>)['logoUrl'] = '';
      final items = PerformanceBoard.fromJson(json).items;
      expect(items.first.logoUrl, isNull);
      expect(items.last.logoUrl, isNull);
    });
  });

  group('formatting', () {
    test('months read the way the pickers show them', () {
      expect(formatMonth('2026-10'), 'Oct 26');
      expect(formatMonthLong('2026-08'), 'August 2026');
      expect(formatMonthLong('nonsense'), 'nonsense');
    });

    test('formatAmount groups thousands and keeps the sign', () {
      expect(formatAmount(-3780), '-3,780');
      expect(formatAmount(50000), '50,000');
      expect(formatAmount(562), '562');
    });
  });
}
