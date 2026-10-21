@Tags(['golden'])
library;

import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/domain/model/feed_post_model.dart';
import 'package:finskool/src/domain/model/post_media_model.dart';
import 'package:finskool/src/domain/model/reaction_type.dart';
import 'package:finskool/src/presentation/pages/feed/widgets/feed_post_card.dart';
import 'package:finskool/src/presentation/pages/feed/widgets/post_reaction_bar.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'support/ticket_fakes.dart';

/// Renders a post card into `build/profile_goldens/feed_card.png` to lay beside
/// Figma's `iPhone 16 - 12` (`605:15302`).
void main() {
  setUpAll(loadAppFonts);

  testWidgets('post card', (tester) async {
    debugDisableShadows = false;
    try {
      tester.view.physicalSize = const Size(786, 940);
      tester.view.devicePixelRatio = 2;
      addTearDown(tester.view.reset);

      // Network images go through a cache that needs plugins the test host
      // lacks; pre-seeding the image cache keeps it untouched.
      final stand = await tester.runAsync(() async {
        final rec = ui.PictureRecorder();
        ui.Canvas(rec).drawRect(
          const Rect.fromLTWH(0, 0, 40, 40),
          Paint()..color = const Color(0xFF0B1F3A),
        );
        return rec.endRecording().toImage(40, 40);
      });
      final urls = [for (var i = 0; i < 4; i++) 'https://img.test/$i.png'];
      for (final u in urls) {
        PaintingBinding.instance.imageCache.putIfAbsent(
          CachedNetworkImageProvider(u),
          () => OneFrameImageStreamCompleter(
            SynchronousFuture(ImageInfo(image: stand!)),
          ),
        );
      }

      final post = FeedPostModel(
        id: 'p',
        communityId: 'c',
        communityName: 'Intraday',
        authorName: 'Ritesh Kumar',
        postedAt: DateTime.now(),
        title: 'Reliance Industries Breakout Above ₹1,480',
        body:
            'Strong buying momentum above the ₹1,480 resistance zone. Entry '
            'zone ₹1,475–1,485, SL below ₹1,445, Target ₹1,525–1,550.',
        media: [
          for (final u in urls)
            PostMediaModel(type: PostMediaType.image, imageUrl: u),
        ],
        hashtags: const ['#Nifty', '#NSE', '#Stocks'],
        reactionCounts: const {
          ReactionType.like: 300,
          ReactionType.love: 100,
          ReactionType.haha: 80,
          ReactionType.wow: 40,
          ReactionType.angry: 24,
        },
      );

      await tester.pumpWidget(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          home: MediaQuery(
            data: const MediaQueryData(size: Size(393, 470)),
            child: Scaffold(
              backgroundColor: const Color(0xFFE7F3F3),
              body: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: FeedPostCard(post: post),
              ),
            ),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 300));
      debugPrint(
        'bar=${tester.getSize(find.byType(PostReactionBar))} card=${tester.getSize(find.byType(FeedPostCard))}',
      );
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('../build/profile_goldens/feed_card.png'),
      );
    } finally {
      debugDisableShadows = true;
    }
  });
}
