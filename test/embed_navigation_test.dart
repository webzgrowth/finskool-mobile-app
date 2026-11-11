import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/presentation/pages/feed/widgets/embed_navigation.dart';

void main() {
  guardTests();
  group('shouldOpenOutside', () {
    test('the first load of the embed stays in the WebView', () {
      expect(
        shouldOpenOutside(
          url: 'https://www.instagram.com/p/ABC/embed',
          isMainFrame: true,
          pageLoaded: false,
        ),
        isFalse,
      );
    });

    test('a tapped link after the embed loaded opens outside', () {
      for (final url in const [
        'https://www.instagram.com/some_profile/',
        'https://www.instagram.com/p/ABC/',
        'https://www.instagram.com/accounts/login/?next=/p/ABC/',
      ]) {
        expect(
          shouldOpenOutside(url: url, isMainFrame: true, pageLoaded: true),
          isTrue,
          reason: url,
        );
      }
    });

    test('frames inside the embed are left alone', () {
      expect(
        shouldOpenOutside(
          url: 'https://scontent.cdninstagram.com/v/video.mp4',
          isMainFrame: false,
          pageLoaded: true,
        ),
        isFalse,
      );
    });

    test('about:blank is never taken out of the page', () {
      expect(
        shouldOpenOutside(
          url: 'about:blank',
          isMainFrame: true,
          pageLoaded: true,
        ),
        isFalse,
      );
    });
  });
}

void guardTests() {
  group('OutsideLaunchGuard', () {
    late DateTime t;
    late OutsideLaunchGuard g;
    setUp(() {
      t = DateTime(2026, 11, 11, 12);
      g = OutsideLaunchGuard(clock: () => t);
    });
    void wait(int ms) => t = t.add(Duration(milliseconds: ms));

    test('a navigation with no touch is refused', () {
      expect(g.allow(), isFalse);
    });

    test('a touch lets one launch through, a double tap opens once', () {
      g.touched();
      expect(g.allow(), isTrue);
      wait(300);
      g.touched();
      expect(g.allow(), isFalse);
    });

    test('a stale touch no longer counts', () {
      g.touched();
      wait(2000);
      expect(g.allow(), isFalse);
    });

    test('returning to the app does not bounce out again', () {
      g.touched();
      expect(g.allow(), isTrue);
      g.lifecycle(foreground: false);
      wait(5000);
      g.lifecycle(foreground: true);
      // The page re-asks on regaining focus, right after resume.
      g.touched();
      expect(g.allow(), isFalse);
      wait(2000);
      g.touched();
      expect(g.allow(), isTrue);
    });
  });
}
