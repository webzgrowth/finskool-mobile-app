import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/comman/placeholder_images.dart';
import 'package:finskool/src/domain/model/community/community_access.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';

void main() {
  Map<String, dynamic> catalogRow({List<Map<String, dynamic>>? plans}) => {
        'id': 'c1',
        'name': 'Swing Alpha',
        'slug': 'swing-alpha',
        'description': 'Trade **swings**',
        'tags': ['Equity'],
        'type': 'Short Term Investment',
        'coverImageUrl': null,
        'badgeUrl': null,
        'whatsIncluded': ['Daily calls', 'Weekly review'],
        'subscribedMemberCount': 1240,
        'plans': plans ??
            [
              {'id': 'p1', 'name': '1 Month', 'durationMonths': 1, 'price': 1500},
              {'id': 'p3', 'name': '3 Month', 'durationMonths': 3, 'price': 3900},
            ],
      };

  test('catalog fields map onto the model despite different names', () {
    final c = CommunityModel.fromCatalogJson(catalogRow());
    expect(c.category, 'Short Term Investment');
    expect(c.benefits, hasLength(2));
    expect(c.memberCount, 1240);
    expect(c.access, CommunityAccess.locked);
    expect(c.plans, hasLength(2));
  });

  test('no plans means the price is not public', () {
    final c = CommunityModel.fromCatalogJson(catalogRow(plans: []));
    expect(c.access, CommunityAccess.pricingOnRequest);
    expect(c.ctaLabel, 'Request Pricing');
  });

  test('per-month and savings labels are derived from the plan list', () {
    final c = CommunityModel.fromCatalogJson(catalogRow());
    final monthly = c.plans.firstWhere((p) => p.months == 1);
    final quarterly = c.plans.firstWhere((p) => p.months == 3);
    // The dearest per-month rate is the baseline, so it saves nothing.
    expect(monthly.saveLabel, isNull);
    expect(monthly.perMonthLabel, '≈ ₹1500/month');
    // 3 x 1500 = 4500 against 3900 paid, so 600 — left uncompacted, since
    // only four-figure savings read better as "1k".
    expect(quarterly.saveLabel, 'Save ₹ 600');
    expect(quarterly.perMonthLabel, '≈ ₹1300/month');
  });

  test('a four-figure saving is compacted to Figma\'s "₹ 1k" form', () {
    final c = CommunityModel.fromCatalogJson(catalogRow(plans: [
      {'id': 'p1', 'name': '1 Month', 'durationMonths': 1, 'price': 1000},
      {'id': 'p12', 'name': '12 Month', 'durationMonths': 12, 'price': 11000},
    ]));
    expect(c.plans.last.saveLabel, 'Save ₹ 1k');
  });

  test('headlinePlan falls back to the cheapest, since nothing is featured', () {
    final c = CommunityModel.fromCatalogJson(catalogRow());
    expect(c.plans.every((p) => !p.featured), isTrue);
    expect(c.headlinePlan?.id, 'p1');
  });

  test('membership rows carry expiry, which drives the status label', () {
    final c = CommunityModel.fromMembershipJson({
      'id': 'c1',
      'name': 'Free',
      'slug': 'free',
      'expiresAt': '2030-12-31',
    });
    expect(c.access, CommunityAccess.subscribed);
    expect(c.subscribedUntil, DateTime(2030, 12, 31));
    expect(c.subscriptionStatusLabel, 'Active till 31 Dec 2030');
    expect(c.needsRenewal, isFalse);
  });

  test('a missing expiresAt leaves the status label off rather than guessing', () {
    final c = CommunityModel.fromMembershipJson(
        {'id': 'c1', 'name': 'Free', 'slug': 'free'});
    expect(c.subscribedUntil, isNull);
    expect(c.subscriptionStatusLabel, isNull);
  });

  test('the cover placeholder is stable per community and varies between', () {
    expect(communityCoverFallback('c1'), communityCoverFallback('c1'));
    final covers = ['a', 'b', 'c', 'd', 'e', 'f'].map(communityCoverFallback);
    expect(covers.toSet().length, greaterThan(1));
  });
}
