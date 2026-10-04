import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:finskool/src/comman/ist_time.dart';
import 'package:finskool/src/domain/model/feed_post_model.dart';

void main() {
  test('a UTC instant from the API reads as IST', () {
    // The exact timestamp from the live feed payload. It showed as
    // "8:27 AM" before this fix; 08:27 UTC is 13:57 IST.
    final posted = DateTime.parse('2026-10-04T08:27:11.567Z');
    expect(DateFormat('h:mm a').format(posted), '8:27 AM',
        reason: 'formatting the raw parse prints UTC — this was the bug');
    expect(formatIst(posted, 'h:mm a'), '1:57 PM');
  });

  test('the +5:30 shift can roll the date forward', () {
    // 22:00 UTC on the 3rd is 03:30 IST on the 4th.
    final posted = DateTime.parse('2026-10-03T22:00:00.000Z');
    expect(formatIst(posted, 'MMM d, h:mm a'), 'Oct 4, 3:30 AM');
  });

  test('a post model timestamp converts the same way', () {
    final post = FeedPostModel.fromJson({
      'id': 'p1',
      'title': 'test',
      'content': '<p>test</p>',
      'publishedAt': '2026-10-04T08:27:11.567Z',
    });
    expect(formatIst(post.postedAt, 'h:mm a'), '1:57 PM');
  });

  // There is deliberately no DateTime-to-DateTime converter to double-apply:
  // formatting and comparing are the only things this file exposes.
  test('"Today" is decided in IST on both sides', () {
    expect(isTodayIst(DateTime.now()), isTrue);
    expect(isTodayIst(DateTime.now().add(const Duration(days: 2))), isFalse);
    // A UTC instant late enough to be tomorrow in IST is not "today".
    final nowUtc = DateTime.now().toUtc();
    expect(isTodayIst(nowUtc.add(const Duration(days: 1))), isFalse);
  });

  test('istNow agrees with the fixed offset', () {
    final delta = istNow().difference(DateTime.now().toUtc());
    expect((delta - istOffset).inSeconds.abs(), lessThan(2));
  });
}
