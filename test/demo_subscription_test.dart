import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/data/datasource/demo_subscription_datasource.dart';
import 'package:finskool/src/domain/model/community/community_access.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';

void main() {
  test('a receipt is derived from the real plan and expiry', () {
    final community = CommunityModel.fromCatalogJson({
      'id': 'c1',
      'name': 'Swing Alpha',
      'slug': 'swing-alpha',
      'plans': [
        {'id': 'p3', 'name': '3 Month', 'durationMonths': 3, 'price': 3900},
      ],
    }).copyWith(
      access: CommunityAccess.subscribed,
      subscribedUntil: DateTime(2026, 7, 1),
    );

    final info = DemoSubscriptionDatasource.forCommunity(community)!;
    expect(info.plan.price, 3900);
    // Counted back from the real expiry by the plan's own duration.
    expect(info.startedOn, DateTime(2026, 4, 1));
    expect(info.transactionId, startsWith('PAY-2026-'));
    expect(info.paymentMethod, 'UPI · PayU');
  });

  test('the free community gets a truthful zero-rupee card, not a price', () {
    final free = CommunityModel.fromMembershipJson({
      'id': 'free-1',
      'name': 'Free',
      'slug': 'free',
      'expiresAt': '2030-01-01',
    });
    final info = DemoSubscriptionDatasource.forCommunity(free)!;
    expect(info.plan.price, 0);
    expect(info.plan.label, 'Free membership');
    expect(info.paymentMethod, 'Included with your account');
    expect(info.transactionId, startsWith('INCLUDED-'));
  });

  test('nothing is invented for a community the user has not joined', () {
    final locked = CommunityModel.fromCatalogJson({
      'id': 'c2',
      'name': 'Locked',
      'slug': 'locked',
      'plans': [
        {'id': 'p1', 'name': '1 Month', 'durationMonths': 1, 'price': 500},
      ],
    });
    expect(DemoSubscriptionDatasource.forCommunity(locked), isNull);
  });

  test('transaction ids are stable, so they do not shuffle on navigation', () {
    final c = CommunityModel.fromMembershipJson({
      'id': 'abc', 'name': 'X', 'slug': 'x', 'expiresAt': '2030-01-01',
    });
    expect(DemoSubscriptionDatasource.forCommunity(c)!.transactionId,
        DemoSubscriptionDatasource.forCommunity(c)!.transactionId);
  });
}
