@Tags(['golden'])
library;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:dartz/dartz.dart' show Either, Right;
import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/repository/communities_repository.dart';
import 'package:finskool/src/comman/placeholder_images.dart';
import 'package:finskool/src/data/datasource/demo_subscription_datasource.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';
import 'package:finskool/src/domain/model/community/community_plan_model.dart';
import 'package:finskool/src/domain/model/community/welcome_kit.dart';
import 'package:finskool/src/domain/usecases/community/get_welcome_kit.dart';
import 'package:finskool/src/presentation/bloc/communities/welcome_kit/welcome_kit_bloc.dart';
import 'package:finskool/src/presentation/pages/communities/subscription_detail/subscription_detail_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'support/ticket_fakes.dart';

/// A kit as `GET /mobile/communities/{id}/welcome-kit` sends it.
final _kit = WelcomeKit.fromJson({
  'watchBeforeYouStart': {
    'introMarkdown':
        '**Welcome to the Intraday Community!** Both videos cover the full '
        'trading process, capital allocation, and how to follow the '
        'recommendations.',
    'videos': [
      {
        'url': 'https://youtu.be/aaaaaaaaaaa',
        'title': 'Launching Finskool21 Intraday Community',
        'thumbnailUrl': 'https://img.test/a.jpg',
      },
      {'url': 'https://youtu.be/bbbbbbbbbbb', 'thumbnailUrl': null},
    ],
  },
  'capitalAllocation': {
    'heroStat': '₹50,000',
    'description':
        'Minimum recommended capital\nDeploy the **full amount** on each '
        'recommended trade rather than splitting it across positions.',
    'strategyTitle': 'Strategy at a glance',
    'strategies': [
      {'priority': 1, 'value': '3', 'label': 'Recommendations per week'},
      {'priority': 2, 'value': '12', 'label': 'Trades per month'},
      {'priority': 3, 'value': '~3%', 'label': 'Target per trade'},
      {'priority': 4, 'value': '1 : 1', 'label': 'Risk-reward ratio'},
    ],
  },
  'strategyNotices': [
    {
      'priority': 1,
      'type': 'warning',
      'heading': 'This is a high-risk strategy',
      'description':
          'Intraday trading involves a **high level of market risk** and is '
          'not suitable for investors uncomfortable with short-term '
          '**fluctuations or potential losses.**',
    },
  ],
  'whatYouGet': [
    {'priority': 1, 'text': 'Min 3 trades per week – **12 trades per month**'},
    {'priority': 2, 'text': '**Watchlist stocks** – every morning'},
  ],
});

final _urls = [communityCoverFallback('c1'), 'https://img.test/a.jpg'];

class _FakeRepo implements CommunitiesRepository {
  @override
  Future<Either<Failure, WelcomeKit?>> getWelcomeKit(String id) async =>
      Right(_kit);

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

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
            child: BlocProvider(
              create: (_) =>
                  WelcomeKitBloc(GetWelcomeKit(_FakeRepo()))
                    ..add(WelcomeKitEvent.load(community.id)),
              child: SubscriptionDetailView(community: community),
            ),
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
