import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';
import 'package:finskool/src/domain/model/community/community_plan_model.dart';
import 'package:finskool/src/domain/model/community/payment_outcome.dart';
import 'package:finskool/src/domain/usecases/kyc/get_kyc_status.dart';
import 'package:finskool/src/domain/usecases/community/get_subscription_expiry.dart';
import 'package:finskool/src/domain/usecases/community/start_checkout.dart';
import 'package:finskool/src/presentation/bloc/communities/purchase/community_purchase_bloc.dart';

import 'support/purchase_fakes.dart';

void main() {
  const community = CommunityModel(
    id: 'c1',
    name: 'Swing',
    slug: 'swing',
    tags: [],
    memberCount: 0,
  );
  const plan = CommunityPlanModel(id: 'p1', label: '3 months', price: 999);
  final newExpiry = DateTime(2027, 2, 1);

  late FakeCommunitiesRepository repo;
  late FakeKycRepository kyc;
  late CommunityPurchaseBloc bloc;

  setUp(() {
    CommunityPurchaseBloc.retryDelay = Duration.zero;
    repo = FakeCommunitiesRepository();
    kyc = FakeKycRepository();
    bloc = CommunityPurchaseBloc(
      GetKycStatus(kyc),
      StartCheckout(repo),
      GetSubscriptionExpiry(repo),
    );
  });
  tearDown(() => bloc.close());

  /// Waits until [bloc] reaches [status] (events are handled asynchronously).
  Future<void> settle(PurchaseStatus status) => bloc.stream
      .firstWhere((s) => s.status == status)
      .timeout(const Duration(seconds: 2));

  Future<void> startAndOpen() async {
    bloc.add(
      const CommunityPurchaseEvent.started(community: community, plan: plan),
    );
    await settle(PurchaseStatus.checkout);
  }

  test('starting a purchase yields the checkout URL untouched', () async {
    await startAndOpen();
    expect(bloc.state.checkoutUrl, 'https://pay.example/checkout#t=secret');
    expect(bloc.state.plan, plan);
    expect(repo.checkoutCalls, 1);
  });

  test(
    'a failed start surfaces the server message and opens nothing',
    () async {
      repo.checkout = Left(ServerFailure('Too many attempts, try again later'));
      bloc.add(
        const CommunityPurchaseEvent.started(community: community, plan: plan),
      );
      await settle(PurchaseStatus.failed);
      expect(bloc.state.message, 'Too many attempts, try again later');
      expect(bloc.state.checkoutUrl, isNull);
    },
  );

  test('a second Buy while one is in flight is ignored', () async {
    await startAndOpen();
    bloc.add(
      const CommunityPurchaseEvent.started(community: community, plan: plan),
    );
    await Future<void>.delayed(Duration.zero);
    expect(repo.checkoutCalls, 1);
  });

  test('paid is confirmed only once /me shows the community', () async {
    repo.expiries = [const Right(null), const Right(null), Right(newExpiry)];
    await startAndOpen();
    bloc.add(const CommunityPurchaseEvent.paymentReported(PaymentOutcome.paid));
    await settle(PurchaseStatus.confirmed);
    expect(repo.expiryCalls, 3);
    expect(bloc.state.expiresAt, newExpiry);
    expect(bloc.state.checkoutUrl, isNull);
  });

  test('a renewal needs a LATER expiry than before, not just any', () async {
    final before = DateTime(2026, 12, 1);
    repo.expiries = [Right(before), Right(newExpiry)];
    bloc.add(
      CommunityPurchaseEvent.started(
        community: community.copyWith(subscribedUntil: before),
        plan: plan,
      ),
    );
    await settle(PurchaseStatus.checkout);
    bloc.add(const CommunityPurchaseEvent.paymentReported(PaymentOutcome.paid));
    await settle(PurchaseStatus.confirmed);
    expect(repo.expiryCalls, 2); // the unchanged date did not count
  });

  test('never seen after all tries is pending, not failed', () async {
    await startAndOpen();
    bloc.add(
      const CommunityPurchaseEvent.paymentReported(PaymentOutcome.error),
    );
    await settle(PurchaseStatus.pending);
    expect(repo.expiryCalls, CommunityPurchaseBloc.attempts);
  });

  test('"Check again" from pending can still confirm', () async {
    await startAndOpen();
    bloc.add(const CommunityPurchaseEvent.paymentReported(PaymentOutcome.paid));
    await settle(PurchaseStatus.pending);
    repo.expiries = [Right(newExpiry)];
    repo.expiryCalls = 0;
    bloc.add(const CommunityPurchaseEvent.recheck());
    await settle(PurchaseStatus.confirmed);
  });

  test('closed (popup dismissed) changes nothing', () async {
    await startAndOpen();
    bloc.add(
      const CommunityPurchaseEvent.paymentReported(PaymentOutcome.closed),
    );
    await Future<void>.delayed(Duration.zero);
    expect(bloc.state.status, PurchaseStatus.checkout);
    expect(repo.expiryCalls, 0);
  });

  test('leaving the page unpaid is one quiet check, then idle', () async {
    await startAndOpen();
    bloc.add(const CommunityPurchaseEvent.checkoutDismissed());
    await settle(PurchaseStatus.idle);
    expect(repo.expiryCalls, 1);
  });

  test('leaving the page after paying is noticed', () async {
    repo.expiries = [Right(newExpiry)];
    await startAndOpen();
    bloc.add(const CommunityPurchaseEvent.checkoutDismissed());
    await settle(PurchaseStatus.confirmed);
  });

  test('clearing mid-confirmation drops the stale result', () async {
    repo.expiries = [const Right(null)];
    await startAndOpen();
    bloc.add(const CommunityPurchaseEvent.paymentReported(PaymentOutcome.paid));
    await settle(PurchaseStatus.confirming);
    bloc.add(const CommunityPurchaseEvent.cleared());
    await settle(PurchaseStatus.idle);
    await Future<void>.delayed(const Duration(milliseconds: 50));
    expect(bloc.state.status, PurchaseStatus.idle);
    expect(bloc.state.hasPurchase, isFalse);
  });
}
