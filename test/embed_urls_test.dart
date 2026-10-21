import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/comman/embed_urls.dart';

void main() {
  group('youtube', () {
    const id = 'THaYrj9YiQM';

    test('every URL shape resolves to the same inline embed', () {
      for (final url in [
        // The shape the live API actually sent.
        'https://www.youtube-nocookie.com/embed/$id',
        'https://www.youtube.com/watch?v=$id',
        'https://youtube.com/watch?v=$id&t=42s',
        'https://youtu.be/$id',
        'https://www.youtube.com/embed/$id',
        'https://www.youtube.com/shorts/$id',
        'https://www.youtube.com/live/$id',
      ]) {
        final target = embedTargetFor(url);
        expect(
          target.src,
          startsWith('https://www.youtube.com/embed/$id?'),
          reason: url,
        );
        expect(target.origin, 'https://www.youtube.com', reason: url);
      }
    });

    test('playsinline is set, which is what keeps playback in the card', () {
      expect(
        embedTargetFor('https://youtu.be/$id').src,
        contains('playsinline=1'),
      );
    });
  });

  group('instagram', () {
    test('posts, reels and tv all become the framable /embed route', () {
      expect(
        embedTargetFor('https://www.instagram.com/p/ABC123/').src,
        'https://www.instagram.com/p/ABC123/embed',
      );
      expect(
        embedTargetFor('https://instagram.com/reel/XYZ789/?igshid=1').src,
        'https://www.instagram.com/reel/XYZ789/embed',
      );
      expect(
        embedTargetFor('https://www.instagram.com/tv/QQQ/').src,
        'https://www.instagram.com/tv/QQQ/embed',
      );
    });

    test('an already-embed URL is left alone', () {
      const url = 'https://www.instagram.com/p/ABC123/embed';
      expect(embedTargetFor(url).src, url);
    });

    test('the origin is instagram, not youtube', () {
      expect(
        embedTargetFor('https://www.instagram.com/p/A/').origin,
        'https://www.instagram.com',
      );
    });
  });

  test('an unknown host is framed as-is rather than mangled', () {
    const url = 'https://cdn.finskool.in/clips/intro.mp4';
    expect(embedTargetFor(url).src, url);
  });
}
