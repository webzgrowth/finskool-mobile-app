import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/performance/performance_board.dart';
import 'package:finskool/src/domain/model/performance/performance_board_entry.dart';
import 'package:finskool/src/domain/model/performance/performance_filter.dart';
import 'package:finskool/src/domain/model/performance/performance_kind.dart';
import 'package:finskool/src/domain/model/performance/performance_summary.dart';
import 'package:finskool/src/domain/model/performance/performance_trade.dart';
import 'package:finskool/src/domain/repository/performance_repository.dart';
import 'package:finskool/src/domain/usecases/performance/get_performance_board.dart';
import 'package:finskool/src/domain/usecases/performance/get_performance_boards.dart';
import 'package:finskool/src/presentation/bloc/performance/board/performance_bloc.dart';
import 'package:finskool/src/presentation/bloc/performance/boards/performance_boards_bloc.dart';

class _Call {
  _Call(this.segment, this.filter, this.cursor);
  final PerformanceSegment? segment;
  final PerformanceMonthFilter? filter;
  final String? cursor;

  @override
  String toString() {
    final f = filter == null ? null : '${filter!.from}..${filter!.to}';
    return '${segment?.wire}|$f|$cursor';
  }
}

class _Repo implements PerformanceRepository {
  /// Answers a board request; tests script it.
  Future<Either<Failure, PerformanceBoard>> Function(_Call) onBoard = (
    _,
  ) async => Right(_board(items: [_trade('a')]));
  Either<Failure, List<PerformanceBoardEntry>> boards = const Right([]);
  final calls = <String>[];

  @override
  Future<Either<Failure, List<PerformanceBoardEntry>>> getBoards() async =>
      boards;

  @override
  Future<Either<Failure, PerformanceBoard>> getBoard({
    required String communityId,
    PerformanceSegment? segment,
    PerformanceMonthFilter? filter,
    String? cursor,
  }) {
    final call = _Call(segment, filter, cursor);
    calls.add('$call');
    return onBoard(call);
  }
}

SwingTrade _trade(String id) => SwingTrade(
  id: id,
  tradeDate: DateTime(2026, 10, 1),
  name: 'Trade $id',
  symbol: null,
  entryPrice: 100,
  cmp: null,
  returnPct: null,
  targetMet: false,
  targetPct: null,
  targetPrice: null,
  analysis: null,
  exitDate: null,
  holdingDays: null,
);

PerformanceBoard _board({
  List<PerformanceTrade> items = const [],
  String? nextCursor,
  PerformanceSegment segment = PerformanceSegment.main,
  int total = 10,
  int? hidden,
  bool paid = true,
  PerformanceMonthFilter? filter,
}) => PerformanceBoard(
  communityId: 'c1',
  communityName: 'Swing Alpha',
  kind: PerformanceKind.swing,
  isPaid: paid,
  segment: segment,
  segments: const [PerformanceSegment.main],
  filter: filter,
  months: const ['2026-10', '2026-09', '2026-08'],
  summary: SwingSummary(
    averageHoldingDays: 12.5,
    totalTrades: total,
    periods: const [],
  ),
  noteText: null,
  hiddenCount: hidden,
  items: items,
  nextCursor: nextCursor,
);

Future<void> pump() => Future<void>.delayed(const Duration(milliseconds: 20));

const _aug = PerformanceMonthFilter.single('2026-08');
const _augSep = PerformanceMonthFilter(from: '2026-08', to: '2026-09');

void main() {
  late _Repo repo;
  late PerformanceBloc bloc;

  setUp(() {
    repo = _Repo();
    bloc = PerformanceBloc(GetPerformanceBoard(repo));
    addTearDown(bloc.close);
  });

  Future<void> load() async {
    bloc.add(const PerformanceEvent.load(communityId: 'c1'));
    await pump();
  }

  group('PerformanceBloc', () {
    test('loads the first page: board, trades and the next cursor', () async {
      repo.onBoard = (_) async =>
          Right(_board(items: [_trade('a'), _trade('b')], nextCursor: 'n1'));
      await load();
      expect(bloc.state.state, RequestState.loaded);
      expect(bloc.state.items.map((t) => t.id), ['a', 'b']);
      expect(bloc.state.nextCursor, 'n1');
      expect(bloc.state.board!.communityName, 'Swing Alpha');
      expect(bloc.state.board!.months, ['2026-10', '2026-09', '2026-08']);
    });

    test(
      'a community with no board is "nothing to show", not a retry',
      () async {
        repo.onBoard = (_) async => const Left(
          ServerFailure('No board.', code: 'PERFORMANCE_BOARD_NOT_FOUND'),
        );
        await load();
        expect(bloc.state.state, RequestState.error);
        expect(bloc.state.notFound, isTrue);
      },
    );

    test(
      'a filter replaces the whole board: summary, trades and hidden count',
      () async {
        repo.onBoard = (c) async => c.filter == null
            ? Right(
                _board(
                  items: [_trade('a')],
                  total: 48,
                  hidden: 41,
                  paid: false,
                ),
              )
            : Right(
                _board(
                  items: [_trade('aug')],
                  total: 11,
                  hidden: 7,
                  paid: false,
                  filter: c.filter,
                ),
              );
        await load();
        bloc.add(const PerformanceEvent.filterChanged(_augSep));
        await pump();
        expect(bloc.state.filter, _augSep);
        expect(bloc.state.items.map((t) => t.id), ['aug']);
        // The cards follow the months, so they come from the filtered answer.
        expect((bloc.state.board!.summary as SwingSummary).totalTrades, 11);
        expect(bloc.state.board!.hiddenCount, 7);
        expect(bloc.state.isListLoading, isFalse);
        expect(repo.calls.last, 'main|2026-08..2026-09|null');
      },
    );

    test('clearing the filter reads the unfiltered first page again', () async {
      await load();
      bloc.add(const PerformanceEvent.filterChanged(_aug));
      await pump();
      bloc.add(const PerformanceEvent.filterChanged(null));
      await pump();
      expect(bloc.state.filter, isNull);
      expect(repo.calls.last, 'main|null|null');
    });

    test('the same filter again is not a request', () async {
      await load();
      bloc.add(const PerformanceEvent.filterChanged(_aug));
      await pump();
      final before = repo.calls.length;
      bloc.add(const PerformanceEvent.filterChanged(_aug));
      await pump();
      expect(repo.calls.length, before);
    });

    test('a failed filter keeps the old board and the old filter', () async {
      await load();
      repo.onBoard = (_) async => const Left(ServerFailure('Offline.'));
      bloc.add(const PerformanceEvent.filterChanged(_aug));
      await pump();
      expect(bloc.state.filter, isNull);
      expect(bloc.state.items, isNotEmpty);
      expect(bloc.state.message, 'Offline.');
      expect(bloc.state.isListLoading, isFalse);
    });

    test(
      'load more appends, skips repeats and stops at the last page',
      () async {
        repo.onBoard = (c) async => switch (c.cursor) {
          null => Right(
            _board(items: [_trade('a'), _trade('b')], nextCursor: 'n1'),
          ),
          _ => Right(_board(items: [_trade('b'), _trade('c')])),
        };
        await load();
        bloc.add(const PerformanceEvent.loadMore());
        await pump();
        expect(bloc.state.items.map((t) => t.id), ['a', 'b', 'c']);
        expect(bloc.state.hasMore, isFalse);
        final before = repo.calls.length;
        bloc.add(const PerformanceEvent.loadMore());
        await pump();
        expect(repo.calls.length, before, reason: 'no cursor, no call');
      },
    );

    test('load more keeps the board it was loaded under', () async {
      repo.onBoard = (c) async => Right(
        _board(
          items: [_trade(c.cursor ?? 'a')],
          nextCursor: c.cursor == null ? 'n1' : null,
          total: c.cursor == null ? 5 : 99,
          filter: c.filter,
        ),
      );
      await load();
      bloc.add(const PerformanceEvent.filterChanged(_augSep));
      await pump();
      bloc.add(const PerformanceEvent.loadMore());
      await pump();
      // Same segment and filter on every page.
      expect(repo.calls.last, 'main|2026-08..2026-09|n1');
      // A later page extends the list; it doesn't redraw the cards.
      expect((bloc.state.board!.summary as SwingSummary).totalTrades, 5);
    });

    test('INVALID_CURSOR starts the list over from page one', () async {
      repo.onBoard = (c) async {
        if (c.cursor == null) {
          return Right(_board(items: [_trade('a')], nextCursor: 'bad'));
        }
        return const Left(ServerFailure('Bad cursor.', code: 'INVALID_CURSOR'));
      };
      await load();
      bloc.add(const PerformanceEvent.loadMore());
      await pump();
      expect(repo.calls.last, 'main|null|null', reason: 'reloaded page one');
      expect(bloc.state.items.map((t) => t.id), ['a']);
    });

    test(
      'switching segment replaces everything and drops the filter',
      () async {
        repo.onBoard = (c) async => Right(
          _board(
            items: [_trade(c.segment?.wire ?? 'main')],
            segment: c.segment ?? PerformanceSegment.investor,
          ),
        );
        bloc.add(
          const PerformanceEvent.load(
            communityId: 'c1',
            segment: PerformanceSegment.investor,
          ),
        );
        await pump();
        bloc.add(const PerformanceEvent.filterChanged(_aug));
        await pump();
        bloc.add(
          const PerformanceEvent.segmentChanged(PerformanceSegment.longTerm),
        );
        await pump();
        expect(bloc.state.segment, PerformanceSegment.longTerm);
        // Each tab has its own months, so the filter starts again.
        expect(bloc.state.filter, isNull);
        expect(bloc.state.items.single.id, 'long_term');
      },
    );

    test('a slow answer for a filter the member left is dropped', () async {
      final slow = Completer<Either<Failure, PerformanceBoard>>();
      repo.onBoard = (c) => c.filter == _aug
          ? slow.future
          : Future.value(Right(_board(items: [_trade(c.filter?.from ?? 'a')])));
      await load();
      bloc.add(const PerformanceEvent.filterChanged(_aug));
      await pump();
      bloc.add(
        const PerformanceEvent.filterChanged(
          PerformanceMonthFilter.single('2026-09'),
        ),
      );
      await pump();
      slow.complete(Right(_board(items: [_trade('old')])));
      await pump();
      expect(bloc.state.filter, const PerformanceMonthFilter.single('2026-09'));
      expect(bloc.state.items.single.id, '2026-09');
    });
  });

  group('PerformanceBoardsBloc', () {
    PerformanceBoardEntry entry(String id) => PerformanceBoardEntry(
      communityId: id,
      name: id,
      slug: id,
      kind: PerformanceKind.swing,
      segments: const [PerformanceSegment.main],
      isPaid: false,
    );

    test('knows which communities have a board', () async {
      repo.boards = Right([entry('a'), entry('b')]);
      final boards = PerformanceBoardsBloc(GetPerformanceBoards(repo));
      addTearDown(boards.close);
      boards.add(const PerformanceBoardsEvent.load());
      await pump();
      expect(boards.state.hasBoard('a'), isTrue);
      expect(boards.state.hasBoard('zzz'), isFalse);
    });

    test('a failed refresh never blanks the list; sign-out does', () async {
      repo.boards = Right([entry('a')]);
      final boards = PerformanceBoardsBloc(GetPerformanceBoards(repo));
      addTearDown(boards.close);
      boards.add(const PerformanceBoardsEvent.load());
      await pump();
      repo.boards = const Left(ServerFailure('Offline.'));
      boards.add(const PerformanceBoardsEvent.load());
      await pump();
      expect(boards.state.hasBoard('a'), isTrue);
      boards.add(const PerformanceBoardsEvent.reset());
      await pump();
      expect(boards.state.boards, isEmpty);
    });
  });
}
