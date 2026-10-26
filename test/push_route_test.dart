import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/data/push/push_route.dart';

void main() {
  test('ticket and service pushes open their chat', () {
    expect(
      routeForPush({'type': 'ticket', 'id': 't1', 'event': 'reply'}),
      '/profile/support-tickets/t1',
    );
    expect(
      routeForPush({'type': 'service', 'id': 'r9', 'event': 'quote'}),
      '/services/requests/r9',
    );
  });

  test('post and subscription open the community, preferring communityId', () {
    expect(
      routeForPush({'type': 'post', 'id': 'p1', 'communityId': 'c1'}),
      '/community/c1',
    );
    expect(routeForPush({'type': 'subscription', 'id': 'c2'}), '/community/c2');
  });

  test('unknown or incomplete data falls back to the dashboard', () {
    expect(routeForPush({'type': 'something-new'}), '/dashboard');
    expect(routeForPush({'type': 'ticket'}), '/dashboard');
    expect(routeForPush({}), '/dashboard');
  });
}
