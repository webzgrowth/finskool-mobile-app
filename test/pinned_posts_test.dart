import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/domain/model/feed_post_model.dart';
import 'package:finskool/src/presentation/pages/feed/widgets/post_author_row.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'support/ticket_fakes.dart';

FeedPostModel _post(String id, {int? pin}) => FeedPostModel(
  id: id,
  communityId: 'c',
  communityName: 'C',
  authorName: 'Admin',
  postedAt: DateTime(2026, 11, 1),
  title: id,
  body: '',
  media: const [],
  hashtags: const [],
  pinOrder: pin,
);

List<String> _ids(List<FeedPostModel> p) => [for (final x in p) x.id];

void main() {
  setUpAll(loadAppFonts);

  group('pinnedFirst', () {
    test('pinned posts rise to the top, by pinOrder', () {
      final sorted = FeedPostModel.pinnedFirst([
        _post('a'),
        _post('b', pin: 2),
        _post('c'),
        _post('d', pin: 1),
      ]);
      expect(_ids(sorted), ['d', 'b', 'a', 'c']);
    });

    test('unpinned posts keep the server order (the sort is stable)', () {
      final posts = [for (var i = 0; i < 20; i++) _post('p$i')];
      expect(_ids(FeedPostModel.pinnedFirst(posts)), _ids(posts));
    });

    test('a pinned post that arrives on a later page still goes on top', () {
      final page1 = [_post('a'), _post('b')];
      final page2 = [_post('c', pin: 1), _post('d')];
      expect(_ids(FeedPostModel.pinnedFirst([...page1, ...page2])), [
        'c',
        'a',
        'b',
        'd',
      ]);
    });

    test('equal pin orders keep their given order', () {
      final sorted = FeedPostModel.pinnedFirst([
        _post('x', pin: 1),
        _post('y', pin: 1),
      ]);
      expect(_ids(sorted), ['x', 'y']);
    });
  });

  group('the Pinned tag', () {
    Future<void> pump(WidgetTester tester, {required bool pinned}) =>
        tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.light,
            home: Scaffold(
              body: PostAuthorRow(
                name: 'Admin',
                avatarUrl: null,
                postedAt: DateTime(2026, 11, 1),
                pinned: pinned,
              ),
            ),
          ),
        );

    testWidgets('shows on a pinned post', (tester) async {
      await pump(tester, pinned: true);
      expect(find.text('Pinned'), findsOneWidget);
    });

    testWidgets('is absent on an ordinary post', (tester) async {
      await pump(tester, pinned: false);
      expect(find.text('Pinned'), findsNothing);
    });
  });
}
