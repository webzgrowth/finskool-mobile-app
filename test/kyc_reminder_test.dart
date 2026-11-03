import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/comman/routes.dart';
import 'package:finskool/src/domain/model/community/community_access.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';
import 'package:finskool/src/domain/model/community/community_plan_model.dart';
import 'package:finskool/src/domain/model/kyc/kyc_status.dart';
import 'package:finskool/src/domain/usecases/community/get_communities.dart';
import 'package:finskool/src/domain/usecases/community/get_subscription_expiry.dart';
import 'package:finskool/src/domain/usecases/community/request_pricing.dart';
import 'package:finskool/src/domain/usecases/community/start_checkout.dart';
import 'package:finskool/src/domain/usecases/kyc/get_kyc_status.dart';
import 'package:finskool/src/presentation/bloc/communities/list/communities_bloc.dart';
import 'package:finskool/src/presentation/bloc/communities/compliance/compliance_bloc.dart';
import 'package:finskool/src/presentation/bloc/communities/purchase/community_purchase_bloc.dart';
import 'package:finskool/src/presentation/bloc/kyc/status/kyc_bloc.dart';
import 'package:finskool/src/domain/usecases/kyc/submit_kyc.dart';
import 'package:finskool/src/presentation/pages/dashboard/widgets/kyc_reminder.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'support/purchase_fakes.dart';
import 'support/ticket_fakes.dart';

class _Repo extends FakeCommunitiesRepository {
  _Repo(this.communities);
  final List<CommunityModel> communities;

  @override
  Future<Either<Failure, List<CommunityModel>>> getCommunities() async =>
      Right(communities);
}

CommunityModel _community(String id, {required bool paid}) => CommunityModel(
  id: id,
  name: id,
  slug: id,
  tags: const [],
  memberCount: 0,
  access: CommunityAccess.subscribed,
  plans: paid
      ? const [CommunityPlanModel(id: 'p', label: '3 months', price: 999)]
      : const [],
);

void main() {
  setUpAll(loadAppFonts);

  Future<(KycBloc, CommunitiesBloc, CommunityPurchaseBloc)> pump(
    WidgetTester tester, {
    required List<CommunityModel> communities,
    required bool kycCompleted,
  }) async {
    final repo = _Repo(communities);
    final kycRepo = FakeKycRepository()
      ..status = Right(KycStatus(completed: kycCompleted));
    final kyc = KycBloc(GetKycStatus(kycRepo));
    final comms = CommunitiesBloc(GetCommunities(repo), RequestPricing(repo));
    final purchase = CommunityPurchaseBloc(
      GetKycStatus(kycRepo),
      StartCheckout(repo),
      GetSubscriptionExpiry(repo),
    );
    final compliance = ComplianceBloc(SubmitKyc(kycRepo));
    addTearDown(() async {
      await kyc.close();
      await comms.close();
      await purchase.close();
      await compliance.close();
    });
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) => const Scaffold(
            body: KycReminder(child: Center(child: Text('dashboard'))),
          ),
        ),
        GoRoute(
          path: AppRoutes.COMMUNITY_COMPLIANCE_ROUTE_PATH,
          builder: (_, _) => const Scaffold(body: Text('compliance form')),
        ),
      ],
    );
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider.value(value: kyc),
          BlocProvider.value(value: comms),
          BlocProvider.value(value: purchase),
          BlocProvider.value(value: compliance),
        ],
        child: MaterialApp.router(theme: AppTheme.light, routerConfig: router),
      ),
    );
    return (kyc, comms, purchase);
  }

  Future<void> load(WidgetTester tester, KycBloc kyc, CommunitiesBloc c) async {
    kyc.add(const KycEvent.load());
    c.add(const CommunitiesEvent.loadCommunities());
    for (var i = 0; i < 6; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
  }

  testWidgets('paid community + KYC not completed: asks to complete it', (
    tester,
  ) async {
    final (kyc, c, _) = await pump(
      tester,
      communities: [_community('a', paid: true)],
      kycCompleted: false,
    );
    await load(tester, kyc, c);
    expect(find.text('Complete your KYC'), findsOneWidget);
  });

  testWidgets('KYC already completed: no prompt', (tester) async {
    final (kyc, c, _) = await pump(
      tester,
      communities: [_community('a', paid: true)],
      kycCompleted: true,
    );
    await load(tester, kyc, c);
    expect(find.text('Complete your KYC'), findsNothing);
  });

  testWidgets('only the free community: nothing was paid for, no prompt', (
    tester,
  ) async {
    final (kyc, c, _) = await pump(
      tester,
      communities: [_community('free', paid: false)],
      kycCompleted: false,
    );
    await load(tester, kyc, c);
    expect(find.text('Complete your KYC'), findsNothing);
  });

  testWidgets('Later closes it, and it does not come back this visit', (
    tester,
  ) async {
    final (kyc, c, _) = await pump(
      tester,
      communities: [_community('a', paid: true)],
      kycCompleted: false,
    );
    await load(tester, kyc, c);
    await tester.tap(find.text('Later'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('Complete your KYC'), findsNothing);
    // Another state change (a refresh) must not ask again.
    c.add(const CommunitiesEvent.refresh());
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('Complete your KYC'), findsNothing);
  });

  testWidgets('Complete KYC opens the form', (tester) async {
    final (kyc, c, _) = await pump(
      tester,
      communities: [_community('a', paid: true)],
      kycCompleted: false,
    );
    await load(tester, kyc, c);
    await tester.tap(find.text('Complete KYC'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text('compliance form'), findsOneWidget);
  });

  testWidgets('a purchase in flight is left to the success screen', (
    tester,
  ) async {
    final (kyc, c, purchase) = await pump(
      tester,
      communities: [_community('a', paid: true)],
      kycCompleted: false,
    );
    purchase.add(
      CommunityPurchaseEvent.started(
        community: _community('b', paid: true),
        plan: const CommunityPlanModel(id: 'p', label: '3 months', price: 999),
      ),
    );
    await tester.pump(const Duration(milliseconds: 50));
    await load(tester, kyc, c);
    expect(find.text('Complete your KYC'), findsNothing);
  });
}
