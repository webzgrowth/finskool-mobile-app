import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/domain/model/post_media_model.dart';

void main() {
  group('looksLikeVideoFile', () {
    test('recognises raw video containers', () {
      expect(looksLikeVideoFile('https://cdn.example.com/clip.mp4'), isTrue);
      expect(looksLikeVideoFile('https://cdn.example.com/clip.MOV'), isTrue);
      expect(
        looksLikeVideoFile('https://cdn.example.com/clip.webm?token=abc'),
        isTrue,
      );
    });

    test('rejects embed pages and images', () {
      expect(looksLikeVideoFile('https://vimeo.com/123456'), isFalse);
      expect(looksLikeVideoFile('https://cdn.example.com/pic.jpg'), isFalse);
    });
  });

  group('PostMediaModel.fromUrl', () {
    test('a raw video link not on youtube/instagram is nativeVideo', () {
      final m = PostMediaModel.fromUrl('https://cdn.example.com/clip.mp4');
      expect(m.type, PostMediaType.nativeVideo);
      expect(m.embedUrl, 'https://cdn.example.com/clip.mp4');
    });

    test('a plain image link is still image', () {
      final m = PostMediaModel.fromUrl('https://cdn.example.com/pic.jpg');
      expect(m.type, PostMediaType.image);
    });

    test('youtube still wins over the extension check', () {
      final m = PostMediaModel.fromUrl('https://youtu.be/dQw4w9WgXcQ');
      expect(m.type, PostMediaType.youtubeEmbed);
    });
  });

  group('PostMediaModel.fromVideoJson', () {
    test('an unrecognised kind with a raw file URL is nativeVideo', () {
      final m = PostMediaModel.fromVideoJson({
        'kind': 'upload',
        'url': 'https://cdn.example.com/clip.mp4',
      });
      expect(m?.type, PostMediaType.nativeVideo);
    });

    test('an unrecognised kind with an embed page stays videoEmbed', () {
      final m = PostMediaModel.fromVideoJson({
        'kind': 'vimeo',
        'embedUrl': 'https://player.vimeo.com/video/123456',
      });
      expect(m?.type, PostMediaType.videoEmbed);
    });

    test('an "upload" kind is native even when the URL has no extension', () {
      final m = PostMediaModel.fromVideoJson({
        'kind': 'upload',
        'url': 'https://cdn.example.com/stream/abc123',
      });
      expect(m?.type, PostMediaType.nativeVideo);
    });

    test(
      'a native video keeps the raw file URL over a player-page embedUrl',
      () {
        final m = PostMediaModel.fromVideoJson({
          'kind': 'upload',
          'url': 'https://cdn.example.com/clip.mp4',
          'embedUrl': 'https://cdn.example.com/player?id=1',
        });
        expect(m?.type, PostMediaType.nativeVideo);
        expect(m?.embedUrl, 'https://cdn.example.com/clip.mp4');
      },
    );
  });
}
