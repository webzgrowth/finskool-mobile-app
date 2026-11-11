import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/utilities/page_transitions.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/community/community_access.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';
import 'package:finskool/src/domain/model/community/community_plan_model.dart';
import 'package:finskool/src/domain/model/performance/performance_board.dart';
import 'package:finskool/src/domain/model/performance/performance_board_entry.dart';
import 'package:finskool/src/domain/model/performance/performance_filter.dart';
import 'package:finskool/src/domain/model/performance/performance_kind.dart';
import 'package:finskool/src/domain/repository/performance_repository.dart';
import 'package:finskool/src/domain/usecases/community/get_communities.dart';
import 'package:finskool/src/domain/usecases/community/request_pricing.dart';
import 'package:finskool/src/domain/usecases/notifications/get_notifications_unread_count.dart';
import 'package:finskool/src/domain/usecases/performance/get_performance_boards.dart';
import 'package:finskool/src/presentation/bloc/communities/filter/community_filter_bloc.dart';
import 'package:finskool/src/presentation/bloc/communities/list/communities_bloc.dart';
import 'package:finskool/src/presentation/bloc/communities/purchase/community_purchase_bloc.dart';
import 'package:finskool/src/domain/usecases/community/get_subscription_expiry.dart';
import 'package:finskool/src/domain/usecases/community/start_checkout.dart';
import 'package:finskool/src/domain/usecases/kyc/get_kyc_status.dart';
import 'package:finskool/src/presentation/bloc/notifications/unread/notifications_unread_bloc.dart';
import 'package:finskool/src/presentation/bloc/performance/boards/performance_boards_bloc.dart';
import 'package:finskool/src/presentation/pages/communities/communities_screen.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'support/notification_fakes.dart';
import 'support/purchase_fakes.dart';
import 'support/ticket_fakes.dart';

class _Repo extends FakeCommunitiesRepository {
  @override
  Future<Either<Failure, List<CommunityModel>>> getCommunities() async =>
      Right([
        for (var i = 0; i < 12; i++)
          CommunityModel(
            id: 'c$i',
            name: 'Community $i',
            slug: 'c$i',
            tags: const [],
            memberCount: 10,
            access: CommunityAccess.locked,
            plans: const [
              CommunityPlanModel(id: 'p', label: '3 months', price: 999),
            ],
          ),
      ]);
}

class _PerfRepo implements PerformanceRepository {
  @override
  Future<Either<Failure, List<PerformanceBoardEntry>>> getBoards() async =>
      const Right([]);

  @override
  Future<Either<Failure, PerformanceBoard>> getBoard({
    required String communityId,
    PerformanceSegment? segment,
    PerformanceMonthFilter? filter,
    String? cursor,
  }) => throw UnimplementedError();
}

void main() {
  setUpAll(loadAppFonts);

  testWidgets('coming back from a pushed screen keeps the list where it was', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final repo = _Repo();
    final comms = CommunitiesBloc(GetCommunities(repo), RequestPricing(repo));
    final filter = CommunityFilterBloc();
    final boards = PerformanceBoardsBloc(GetPerformanceBoards(_PerfRepo()));
    final nrepo = FakeNotificationsRepository();
    final unread = NotificationsUnreadBloc(
      GetNotificationsUnreadCount(nrepo),
      FakeNotificationsSocket(),
    );
    final kycRepo = FakeKycRepository();
    final purchase = CommunityPurchaseBloc(
      GetKycStatus(kycRepo),
      StartCheckout(repo),
      GetSubscriptionExpiry(repo),
    );
    for (final b in [comms, filter, boards, unread, purchase]) {
      addTearDown(b.close);
    }
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (c, st) => fadeThroughPage(
            st,
            Scaffold(
              body: IndexedStack(
                children: [
                  const CommunitiesScreen(),
                  ListView(children: const [Text('other')]),
                ],
              ),
            ),
          ),
        ),
        GoRoute(
          path: '/community/:id/performance',
          builder: (c, st) => const Scaffold(body: Text('perf')),
        ),
      ],
    );
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider.value(value: comms),
          BlocProvider.value(value: filter),
          BlocProvider.value(value: boards),
          BlocProvider.value(value: unread),
          BlocProvider.value(value: purchase),
        ],
        child: MaterialApp.router(routerConfig: router, theme: AppTheme.light),
      ),
    );
    await tester.pump(const Duration(milliseconds: 100));
    final scroll = find.byType(CustomScrollView);
    await tester.drag(scroll, const Offset(0, -1500));
    await tester.pumpAndSettle();
    double offset() => tester
        .state<ScrollableState>(find.byType(Scrollable).first)
        .position
        .pixels;
    final before = offset();
    expect(before, greaterThan(500));

    router.push('/community/c0/performance', extra: 'Community 0');
    await tester.pumpAndSettle();
    router.pop();
    await tester.pumpAndSettle();
    expect(offset(), before);

    // A reload swaps the list for its skeleton (the scroll view clamps to 0)
    // and back: the member must still be where they were.
    comms.add(const CommunitiesEvent.loadCommunities());
    await tester.pumpAndSettle();
    expect(offset(), before);

    // And a brand-new screen (the tab being rebuilt) starts there too.
    await tester.pumpWidget(const SizedBox());
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider.value(value: comms),
          BlocProvider.value(value: filter),
          BlocProvider.value(value: boards),
          BlocProvider.value(value: unread),
          BlocProvider.value(value: purchase),
        ],
        child: MaterialApp(
          theme: AppTheme.light,
          home: const Scaffold(body: CommunitiesScreen()),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(offset(), before);
  });
}
