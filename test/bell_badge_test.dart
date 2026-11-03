import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/comman/widgets/search_top_bar.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'support/ticket_fakes.dart';

void main() {
  setUpAll(loadAppFonts);

  Future<void> pumpBar(WidgetTester tester, int? count) => tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.light,
      home: Scaffold(
        backgroundColor: AppPalette.primary,
        body: SearchTopBar(
          hintText: 'Search',
          notificationCount: count,
          onNotificationsTap: () {},
          onQueryChanged: (_) {},
        ),
      ),
    ),
  );

  testWidgets('the count is legible, not Figma\'s 4.46px speck', (
    tester,
  ) async {
    await pumpBar(tester, 7);
    final text = tester.widget<Text>(find.text('7'));
    expect(text.style!.fontSize, greaterThanOrEqualTo(10));
    // The badge itself is big enough to read and to tap near.
    final box = tester.getSize(
      find.ancestor(of: find.text('7'), matching: find.byType(Container)).first,
    );
    expect(box.height, greaterThanOrEqualTo(19));
    expect(box.width, greaterThanOrEqualTo(19));
  });

  testWidgets('two digits widen the badge, 100+ caps at 99+', (tester) async {
    await pumpBar(tester, 42);
    expect(find.text('42'), findsOneWidget);
    await pumpBar(tester, 250);
    expect(find.text('99+'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('no count, no badge', (tester) async {
    await pumpBar(tester, 0);
    expect(find.text('0'), findsNothing);
    await pumpBar(tester, null);
    expect(tester.takeException(), isNull);
  });

  testWidgets('the badge hangs off the disc and is not clipped', (
    tester,
  ) async {
    await pumpBar(tester, 5);
    final badge = tester.getRect(
      find.ancestor(of: find.text('5'), matching: find.byType(Container)).first,
    );
    final screen = tester.view.physicalSize / tester.view.devicePixelRatio;
    expect(badge.right, lessThanOrEqualTo(screen.width));
    expect(badge.top, greaterThanOrEqualTo(0));
  });
}
