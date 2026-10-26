@Tags(['golden'])
library;

import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/injections/injection.dart';
import 'package:finskool/src/data/repository/performance_repository_impl.dart';
import 'package:finskool/src/domain/repository/performance_repository.dart';
import 'package:finskool/src/presentation/pages/dashboard/performance/performance_screen.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'support/ticket_fakes.dart';

/// Renders the Performance screen to `build/performance_goldens/` to lay
/// beside Figma's export of `1554:6103` (`build/figma_perf/full.png`).
void main() {
  setUpAll(loadAppFonts);

  testWidgets('performance', (tester) async {
    debugDisableShadows = false;
    if (!locator.isRegistered<PerformanceRepository>()) {
      locator.registerSingleton<PerformanceRepository>(
        PerformanceRepositoryImpl(),
      );
    }
    try {
      tester.view.physicalSize = const Size(786, 5322);
      tester.view.devicePixelRatio = 2;
      addTearDown(tester.view.reset);
      final key = GlobalKey();
      await tester.pumpWidget(
        RepaintBoundary(
          key: key,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            home: const MediaQuery(
              data: MediaQueryData(
                size: Size(393, 2661),
                padding: EdgeInsets.only(top: 44),
              ),
              child: PerformanceScreen(communityName: 'Intraday Community'),
            ),
          ),
        ),
      );
      await tester.pump();
      await tester.runAsync(
        () => precacheImage(
          const AssetImage('assets/images/performance_header_bg.png'),
          tester.element(find.byType(PerformanceScreen)),
        ),
      );
      await tester.pump();
      await tester.runAsync(() async {
        final boundary =
            key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
        final image = await boundary.toImage(pixelRatio: 2);
        final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
        File('build/performance_goldens/performance.png')
            .writeAsBytesSync(bytes!.buffer.asUint8List());
      });
    } finally {
      debugDisableShadows = true;
    }
  });
}
