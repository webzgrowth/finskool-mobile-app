import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/presentation/pages/feed/widgets/embed_navigation.dart';

void main() {
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
