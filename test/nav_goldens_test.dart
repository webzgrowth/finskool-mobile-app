@Tags(['golden'])
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/presentation/pages/dashboard/widgets/nav_bar_item.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'support/ticket_fakes.dart';

void main() {
  setUpAll(loadAppFonts);

  testWidgets('nav bar', (tester) async {
    tester.view.physicalSize = const Size(786, 134);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    const glyphs = [
      'assets/icons/nav_feed.svg',
      'assets/icons/nav_communities.svg',
      'assets/icons/nav_performance.svg',
    ];
    const labels = ['Feed', 'Communities', 'Performance', 'Profile'];
    await tester.pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: Material(
          color: AppPalette.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 42, right: 29),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (var i = 0; i < 4; i++)
                  NavBarItem(
                    glyph: i < 3 ? glyphs[i] : null,
                    customIcon: i == 3
                        ? const CircleAvatar(
                            radius: 10.5,
                            backgroundColor: Color(0xFFE8590C),
                          )
                        : null,
                    label: labels[i],
                    selected: i == 0,
                    onTap: () {},
                  ),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 200)),
    );
    await tester.pump(const Duration(seconds: 1));
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('../build/profile_goldens/nav.png'),
    );
  });
}
