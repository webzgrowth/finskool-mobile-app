import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/domain/model/feed_post_model.dart';
import 'package:finskool/src/domain/model/post_media_model.dart';
import 'package:finskool/src/domain/model/reaction_type.dart';

/// The exact payload the live backend returned for the Free community.
const _raw = '''
{
  "id": "2113afb9-ac33-41e3-b77b-1b4995a40403",
  "communityId": "a4e9f8dd-6c76-4ecb-aedd-2edf642e7de6",
  "communityName": "Free",
  "communitySlug": "free",
  "communityBadgeUrl": null,
  "authorName": "Finskool Admin",
  "authorAvatarUrl": null,
  "title": "test",
  "content": "<p>test</p>",
  "imageUrls": [],
  "videos": [
    {
      "id": "074fe39b-8a9e-4bd1-94ec-a929ee658137",
      "kind": "youtube",
      "url": "https://www.youtube.com/watch?v=THaYrj9YiQM",
      "embedUrl": "https://www.youtube-nocookie.com/embed/THaYrj9YiQM",
      "externalId": "THaYrj9YiQM",
      "title": "I Proved Why Water City is my HOME",
      "thumbnailUrl": "https://i.ytimg.com/vi/THaYrj9YiQM/hqdefault.jpg"
    }
  ],
  "tags": ["#test"],
  "pinOrder": null,
  "publishedAt": "2026-10-04T08:27:11.567Z",
  "createdAt": "2026-10-04T08:27:11.477Z",
  "commentCount": 0,
  "reactionCounts": { "like": 1 },
  "myReaction": "like"
}
''';

FeedPostModel _parse([Map<String, dynamic>? overrides]) =>
    FeedPostModel.fromJson({
      ...jsonDecode(_raw) as Map<String, dynamic>,
      ...?overrides,
    });

void main() {
  test('the videos array becomes a playable embed with its poster', () {
    final media = _parse().media;
    expect(media, hasLength(1));
    expect(media.single.type, PostMediaType.youtubeEmbed);
    expect(media.single.isEmbed, isTrue);
    expect(
      media.single.embedUrl,
      'https://www.youtube-nocookie.com/embed/THaYrj9YiQM',
    );
    expect(
      media.single.posterUrl,
      'https://i.ytimg.com/vi/THaYrj9YiQM/hqdefault.jpg',
    );
    expect(media.single.title, startsWith('I Proved Why'));
  });

  test('reaction counts and myReaction come off the post list', () {
    final post = _parse();
    expect(post.reactionCounts, {ReactionType.like: 1});
    expect(post.currentUserReaction, ReactionType.like);
    expect(post.totalReactions, 1);
  });

  test('sad is dropped rather than throwing', () {
    final post = _parse({
      'reactionCounts': {'like': 2, 'sad': 5},
      'myReaction': 'sad',
    });
    expect(post.reactionCounts, {ReactionType.like: 2});
    expect(post.currentUserReaction, isNull);
  });

  test('images, inline body pictures and videos all land, images first', () {
    final post = _parse({
      'imageUrls': ['https://cdn.test/a.png'],
      'content': '<p>hi</p><img src="https://cdn.test/b.png">',
    });
    expect(post.media.map((m) => m.type).toList(), [
      PostMediaType.image,
      PostMediaType.image,
      PostMediaType.youtubeEmbed,
    ]);
    expect(post.media.first.imageUrl, 'https://cdn.test/a.png');
  });

  test('a duplicate across imageUrls and the body renders once', () {
    final post = _parse({
      'imageUrls': ['https://cdn.test/a.png'],
      'content': '<img src="https://cdn.test/a.png">',
      'videos': [],
    });
    expect(post.media, hasLength(1));
  });

  test('an unknown video kind still plays, a urlless one is skipped', () {
    final post = _parse({
      'videos': [
        {'kind': 'vimeo', 'url': 'https://vimeo.com/1', 'embedUrl': null},
        {'kind': 'youtube', 'title': 'no url at all'},
      ],
    });
    expect(post.media, hasLength(1));
    expect(post.media.single.type, PostMediaType.videoEmbed);
    expect(post.media.single.embedUrl, 'https://vimeo.com/1');
  });

  test('externalId is carried through as the player videoId', () {
    expect(_parse().media.single.videoId, 'THaYrj9YiQM');
  });

  test('a youtube link without externalId falls back to parsing the URL', () {
    final post = _parse({
      'videos': [
        {'kind': 'youtube', 'url': 'https://youtu.be/abcdefghijk'},
      ],
    });
    expect(post.media.single.videoId, 'abcdefghijk');
  });

  test('a youtube link in imageUrls also resolves a videoId', () {
    final post = _parse({
      'imageUrls': ['https://www.youtube.com/watch?v=zzzzzzzzzzz'],
      'videos': [],
    });
    expect(post.media.single.type, PostMediaType.youtubeEmbed);
    expect(post.media.single.videoId, 'zzzzzzzzzzz');
  });

  test(
    'instagram and unknown kinds carry no videoId, so they stay WebView',
    () {
      final post = _parse({
        'videos': [
          {'kind': 'instagram', 'url': 'https://www.instagram.com/p/ABC/'},
          {'kind': 'vimeo', 'url': 'https://vimeo.com/1'},
        ],
      });
      expect(post.media.map((m) => m.videoId), everyElement(isNull));
    },
  );

  test('a post with no videos key at all still parses', () {
    final json = jsonDecode(_raw) as Map<String, dynamic>..remove('videos');
    expect(FeedPostModel.fromJson(json).media, isEmpty);
  });
}
