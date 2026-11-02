import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';
import 'package:finskool/src/domain/model/community/community_plan_model.dart';
import 'package:finskool/src/domain/model/community/payment_outcome.dart';
import 'package:finskool/src/domain/usecases/community/get_compliance_status.dart';
import 'package:finskool/src/domain/usecases/community/get_subscription_expiry.dart';
import 'package:finskool/src/domain/usecases/community/start_checkout.dart';
import 'package:finskool/src/presentation/bloc/communities/purchase/community_purchase_bloc.dart';
import 'package:finskool/src/presentation/pages/communities/payment_success/payment_success_screen.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'support/purchase_fakes.dart';
import 'support/ticket_fakes.dart';

void main() {
  setUpAll(loadAppFonts);

  const community = CommunityModel(
    id: 'c1',
    name: 'Swing',
    slug: 'swing',
    tags: [],
    memberCount: 0,
  );
  const plan = CommunityPlanModel(id: 'p1', label: '3 months', price: 999);

  Future<CommunityPurchaseBloc> pump(
    WidgetTester tester,
    FakeCommunitiesRepository repo,
    PurchaseStatus until,
  ) async {
    CommunityPurchaseBloc.retryDelay = Duration.zero;
    // Created inside the test: a bloc built in setUp lives outside the
    // fake-async zone and its streams never flush.
    final bloc = CommunityPurchaseBloc(
      GetComplianceStatus(repo),
      StartCheckout(repo),
      GetSubscriptionExpiry(repo),
    );
    addTearDown(bloc.close);
    // The bloc lives in the test's fake-async zone, so its events and the
    // zero-length retry delays only advance when the clock is pumped.
    Future<void> reach(PurchaseStatus status) async {
      for (var i = 0; i < 100 && bloc.state.status != status; i++) {
        await tester.pump(const Duration(milliseconds: 10));
      }
      expect(bloc.state.status, status);
    }

    bloc.add(
      const CommunityPurchaseEvent.started(community: community, plan: plan),
    );
    await reach(PurchaseStatus.checkout);
    bloc.add(const CommunityPurchaseEvent.paymentReported(PaymentOutcome.paid));
    await reach(until);
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: BlocProvider.value(
          value: bloc,
          child: const PaymentSuccessScreen(),
        ),
      ),
    );
    await tester.pump();
    return bloc;
  }

  testWidgets(
    'pending says money may have moved and offers no second payment',
    (tester) async {
      await pump(tester, FakeCommunitiesRepository(), PurchaseStatus.pending);
      expect(find.text("We're confirming your payment"), findsOneWidget);
      expect(find.textContaining('do not need to pay again'), findsOneWidget);
      expect(find.text('Check again'), findsOneWidget);
      expect(find.textContaining('Buy'), findsNothing);
    },
  );

  testWidgets('confirmed shows the server\'s date and the plan price', (
    tester,
  ) async {
    final repo = FakeCommunitiesRepository()
      ..expiries = [Right(DateTime(2027, 2, 1))];
    await pump(tester, repo, PurchaseStatus.confirmed);
    expect(find.text('₹999'), findsOneWidget);
    expect(find.textContaining('active until 1 February 2027'), findsOneWidget);
    expect(find.textContaining('transaction ID'), findsNothing);
  });

  testWidgets('with nothing bought it says so instead of crashing', (
    tester,
  ) async {
    final repo = FakeCommunitiesRepository();
    final bloc = CommunityPurchaseBloc(
      GetComplianceStatus(repo),
      StartCheckout(repo),
      GetSubscriptionExpiry(repo),
    );
    addTearDown(bloc.close);
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: BlocProvider.value(
          value: bloc,
          child: const PaymentSuccessScreen(),
        ),
      ),
    );
    expect(find.text('No payment in progress.'), findsOneWidget);
  });
}
