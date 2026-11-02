import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/comman/relative_time.dart';
import 'package:finskool/src/domain/model/notification/app_notification.dart';

void main() {
  // 14:00 IST on 26 Oct 2026.
  final now = DateTime.utc(2026, 10, 26, 8, 30);

  test('matches the Figma labels', () {
    expect(
      relativeTime(now.subtract(const Duration(seconds: 20)), now: now),
      'now',
    );
    expect(
      relativeTime(now.subtract(const Duration(minutes: 5)), now: now),
      '5m ago',
    );
    expect(
      relativeTime(now.subtract(const Duration(hours: 1)), now: now),
      '1h ago',
    );
  });

  test(
    'under 24h is hours even across midnight; then Yesterday is an IST day',
    () {
      // 00:30 IST today vs 23:30 IST yesterday: one hour apart, different days.
      final justAfterMidnight = DateTime.utc(2026, 10, 25, 19);
      final lateYesterday = DateTime.utc(2026, 10, 25, 18);
      expect(relativeTime(lateYesterday, now: justAfterMidnight), '1h ago');
      final yesterday = DateTime.utc(2026, 10, 25, 8);
      expect(relativeTime(yesterday, now: now), 'Yesterday');
    },
  );

  test('older than yesterday is a date', () {
    expect(relativeTime(DateTime.utc(2026, 10, 20, 8), now: now), '20 Oct');
  });

  test('AppNotification tolerates missing and odd fields', () {
    final n = AppNotification.fromJson({
      'id': 'x',
      'type': 'a-new-kind',
      'title': 'T',
      'message': 'M',
      'data': null,
      'isRead': false,
      'createdAt': '2026-10-30T09:00:00.000Z',
    });
    expect(n.data, isNull);
    expect(n.communityId, isNull);
    final page = NotificationsPage.fromJson({
      'notifications': [
        {'id': '1', 'title': 'a', 'message': 'b', 'createdAt': 'junk'},
      ],
      'page': 2,
      'totalPages': 3,
    });
    expect(page.items.single.id, '1');
    expect(page.hasMore, isTrue);
  });
}
