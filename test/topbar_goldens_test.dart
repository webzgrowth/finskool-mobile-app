@Tags(['golden'])
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/comman/widgets/search_top_bar.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'support/ticket_fakes.dart';

/// Renders the shared top bar into `build/profile_goldens/topbar.png`.
void main() {
  setUpAll(loadAppFonts);

  testWidgets('top bar', (tester) async {
    debugDisableShadows = false;
    try {
      tester.view.physicalSize = const Size(786, 300);
      tester.view.devicePixelRatio = 2;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          home: MediaQuery(
            data: const MediaQueryData(
              size: Size(393, 170),
              padding: EdgeInsets.only(top: 44),
            ),
            child: Scaffold(
              backgroundColor: const Color(0xFFE7F3F3),
              body: Column(
                children: [
                  SearchTopBar(
                    hintText: 'Search posts, stocks or tags…',
                    onQueryChanged: (_) {},
                    onFilterTap: () {},
                    notificationCount: 3,
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
        matchesGoldenFile('../build/profile_goldens/topbar.png'),
      );
    } finally {
      debugDisableShadows = true;
    }
  });
}
