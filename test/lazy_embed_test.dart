import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:finskool/src/domain/model/post_media_model.dart';
import 'package:finskool/src/presentation/pages/feed/widgets/lazy_embed.dart';

/// Stands in for the real player, which is a platform view and cannot be
/// built in a widget test. Its presence means "a WebView would be live here".
class _FakePlayer extends StatelessWidget {
  const _FakePlayer();
  @override
  Widget build(BuildContext context) => const ColoredBox(color: Colors.red);
}

const _item = PostMediaModel(
  type: PostMediaType.youtubeEmbed,
  imageUrl: 'https://www.youtube.com/embed/abc',
  embedUrl: 'https://www.youtube.com/embed/abc',
  thumbnailUrl: 'https://i.ytimg.com/vi/abc/hqdefault.jpg',
  videoId: 'abc',
);

Widget _buildPlayer(BuildContext _) => const _FakePlayer();

Widget _harness({required double offsetFromTop}) => MaterialApp(
  home: Scaffold(
    body: ListView(
      children: [
        SizedBox(height: offsetFromTop),
        const SizedBox(
          height: 200,
          child: LazyEmbed(item: _item, player: _buildPlayer),
        ),
        const SizedBox(height: 2000),
      ],
    ),
  ),
);

void main() {
  setUp(() {
    // Otherwise the detector debounces past the end of the test.
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
  });

  testWidgets('a post on screen mounts its player', (tester) async {
    await tester.pumpWidget(_harness(offsetFromTop: 0));
    await tester.pumpAndSettle();
    expect(find.byType(_FakePlayer), findsOneWidget);
  });

  testWidgets('a post far below the fold holds no player', (tester) async {
    await tester.pumpWidget(_harness(offsetFromTop: 2000));
    await tester.pumpAndSettle();
    expect(find.byType(_FakePlayer), findsNothing);
  });

  // The whole point: no platform view survives offscreen, which is what
  // keeps video off the bottom nav bar.
  testWidgets('scrolling away tears the player down again', (tester) async {
    await tester.pumpWidget(_harness(offsetFromTop: 0));
    await tester.pumpAndSettle();
    expect(find.byType(_FakePlayer), findsOneWidget);

    await tester.drag(find.byType(ListView), const Offset(0, -900));
    await tester.pumpAndSettle();
    expect(find.byType(_FakePlayer), findsNothing);
  });

  testWidgets('an Instagram item with no poster shows a plate, not black', (
    tester,
  ) async {
    const insta = PostMediaModel(
      type: PostMediaType.instagramEmbed,
      imageUrl: 'https://www.instagram.com/p/ABC/',
      embedUrl: 'https://www.instagram.com/p/ABC/embed',
    );
    expect(insta.posterUrl, isNull, reason: 'the API gives Instagram none');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ListView(
            children: const [
              // Half on screen: built, but under the 0.7 mount threshold, so the
              // placeholder is what renders.
              SizedBox(height: 500),
              SizedBox(
                height: 200,
                child: LazyEmbed(item: insta, player: _buildPlayer),
              ),
              SizedBox(height: 2000),
            ],
          ),
        ),
      ),
    );
    // Not pumpAndSettle: the placeholder's progress indicator spins forever,
    // so it never settles.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    expect(find.byType(_FakePlayer), findsNothing);
    // The gradient plate that replaced the flat black rectangle.
    final plate = tester.widget<DecoratedBox>(
      find
          .descendant(
            of: find.byType(LazyEmbed),
            matching: find.byType(DecoratedBox),
          )
          .first,
    );
    expect((plate.decoration as BoxDecoration).gradient, isNotNull);
  });
}
