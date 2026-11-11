import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/domain/model/feed_post_model.dart';
import 'package:finskool/src/presentation/pages/feed/widgets/feed_list_view.dart';

FeedPostModel post(String id) => FeedPostModel(
  id: id,
  communityId: 'c',
  communityName: 'C',
  authorName: 'Admin',
  postedAt: DateTime(2026, 11, 1),
  title: id,
  body: '',
  media: const [],
  hashtags: const [],
);

void main() {
  test(
    'focusFirst moves one post to the front and keeps the rest in order',
    () {
      final posts = [
        for (final id in ['a', 'b', 'c', 'd']) post(id),
      ];
      expect(focusFirst(posts, 'c').map((p) => p.id), ['c', 'a', 'b', 'd']);
      expect(focusFirst(posts, 'a').map((p) => p.id), ['a', 'b', 'c', 'd']);
      expect(focusFirst(posts, 'zz'), same(posts));
    },
  );
}
