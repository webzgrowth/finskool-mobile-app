@Tags(['golden'])
library;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/comman/placeholder_images.dart';
import 'package:finskool/src/data/datasource/demo_subscription_datasource.dart';
import 'package:finskool/src/data/datasource/welcome_kit_demo_datasource.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';
import 'package:finskool/src/domain/model/community/community_plan_model.dart';
import 'package:finskool/src/presentation/pages/communities/subscription_detail/subscription_detail_screen.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'support/ticket_fakes.dart';

final _urls = [
  communityCoverFallback('c1'),
  ...WelcomeKitDemoDatasource.forSlug('intraday-community')!.videos
      .map((v) => v.thumbnailUrl ?? ''),
];

/// Renders Subscription Detail into `build/profile_goldens/subdetail.png`.
void main() {
  setUpAll(loadAppFonts);

  testWidgets('subscription detail', (tester) async {
    debugDisableShadows = false;
    try {
      tester.view.physicalSize = const Size(750, 3778);
      tester.view.devicePixelRatio = 2;
      addTearDown(tester.view.reset);

      // Network images go through `cached_network_image`, whose cache needs
      // sqflite and path_provider — absent in the test host. Pre-seeding the
      // image cache means the cache manager is never touched.
      final stand = await tester.runAsync(
        () => createTestImage(width: 40, height: 40),
      );
      Future<void> seed(String url) async {
        PaintingBinding.instance.imageCache.putIfAbsent(
          CachedNetworkImageProvider(url),
          () => OneFrameImageStreamCompleter(
            SynchronousFuture(ImageInfo(image: stand!)),
          ),
        );
      }

      for (final url in _urls) {
        await seed(url);
      }

      final base = CommunityModel(
        id: 'c1',
        name: 'Intraday Community',
        slug: 'intraday-community',
        tags: const [],
        memberCount: 0,
        category: 'Short Term Investment',
        subscribedUntil: DateTime(2026, 12, 31),
        plans: const [
          CommunityPlanModel(
            id: 'p',
            label: '3 months',
            price: 3000,
            months: 3,
          ),
        ],
        benefits: const [
          'Min 3 trades per week – **12 trades per month**',
          'Average target **3%–4% per trade**',
          '**Specific entry price**, stoploss and target for each trade',
          '**Watchlist stocks** – every morning',
        ],
      );
      final community = CommunityModel(
        id: base.id,
        name: base.name,
        slug: base.slug,
        tags: base.tags,
        memberCount: 0,
        category: base.category,
        subscribedUntil: base.subscribedUntil,
        plans: base.plans,
        benefits: base.benefits,
        subscriptionInfo: DemoSubscriptionDatasource.forCommunity(base),
        welcomeKit: WelcomeKitDemoDatasource.forSlug(base.slug),
      );

      await tester.pumpWidget(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          home: MediaQuery(
            data: const MediaQueryData(
              size: Size(375, 1889),
              padding: EdgeInsets.only(top: 44, bottom: 34),
            ),
            child: SubscriptionDetailScreen(community: community),
          ),
        ),
      );
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 300)),
      );
      await tester.pump(const Duration(seconds: 1));
      // The cover goes through the image cache, which needs plugins the test
      // host lacks; its failure draws the fallback and is not under test.
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('../build/profile_goldens/subdetail.png'),
      );
    } finally {
      debugDisableShadows = true;
    }
  });
}
