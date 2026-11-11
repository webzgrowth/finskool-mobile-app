import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/data/push/push_route.dart';

void main() {
  test('ticket and service open their chat', () {
    expect(
      routeForPush({'type': 'ticket', 'id': 't1', 'event': 'reply'}),
      '/profile/support-tickets/t1',
    );
    expect(
      routeForPush({'type': 'service', 'id': 'r9', 'event': 'quote'}),
      '/services/requests/r9',
    );
  });

  test('a community post opens that community with the post to show', () {
    expect(
      routeForPush({'type': 'post', 'id': 'p1', 'communityId': 'c1'}),
      '/community/c1?post=p1',
    );
  });

  test('a post with no communityId uses the row\'s, never the post id', () {
    expect(
      routeForPush({'type': 'post', 'id': 'p1'}, rowCommunityId: 'c9'),
      '/community/c9?post=p1',
    );
    // The post's id is not a community: nothing to open but the inbox.
    expect(routeForPush({'type': 'post', 'id': 'p1'}), '/notifications');
  });

  test('subscription events open My subscription by community id', () {
    expect(
      routeForPush({
        'type': 'subscription',
        'id': 'c2',
        'communityId': 'c2',
        'event': 'expiring-7',
      }),
      '/subscription-detail?id=c2',
    );
    expect(
      routeForPush({'type': 'subscription', 'id': 'c3'}),
      '/subscription-detail?id=c3',
    );
  });

  test('feed and recommendation land on the dashboard', () {
    expect(routeForPush({'type': 'feed', 'id': 'p'}), '/dashboard');
    expect(routeForPush({'type': 'recommendation', 'id': 'r'}), '/dashboard');
  });

  test('unknown or unusable data opens the inbox, never breaks', () {
    expect(routeForPush({'type': 'brand-new'}), '/notifications');
    expect(routeForPush({'type': 'ticket'}), '/notifications');
    expect(routeForPush({'type': 'subscription'}), '/notifications');
    expect(routeForPush({}), '/notifications');
    expect(routeForPush(null), '/notifications');
  });
}
