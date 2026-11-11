import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/domain/model/notification/app_notification.dart';

AppNotification _n(String title, Map<String, dynamic>? data) => AppNotification(
  id: '1',
  type: 'post',
  title: title,
  message: 'm',
  isRead: false,
  createdAt: DateTime(2026, 11, 1),
  data: data,
);

void main() {
  test('a free-community post reads "in the Feed"', () {
    expect(
      _n('New announcement in Free', {'type': 'feed', 'id': 'p'}).displayTitle,
      'New announcement in the Feed',
    );
  });

  test('a paid community keeps its name, and other titles are untouched', () {
    expect(
      _n('New announcement in Investor Community', {
        'type': 'post',
        'communityId': 'c',
      }).displayTitle,
      'New announcement in Investor Community',
    );
    expect(
      _n('Support replied to your ticket', {'type': 'ticket'}).displayTitle,
      'Support replied to your ticket',
    );
    expect(
      _n('New announcement in Free', null).displayTitle,
      'New announcement in Free',
    );
  });
}
