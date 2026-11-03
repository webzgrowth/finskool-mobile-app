import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/comman/widgets/app_snack.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

void main() {
  final navigator = GlobalKey<NavigatorState>();

  Future<void> pumpApp(WidgetTester tester) async {
    AppSnack.overlayProvider = () => navigator.currentState?.overlay;
    addTearDown(AppSnack.dismiss);
    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navigator,
        theme: AppTheme.light,
        home: const Scaffold(
          body: SizedBox.expand(),
          bottomNavigationBar: SizedBox(height: 80),
        ),
      ),
    );
  }

  testWidgets(
    'it appears at the TOP, under the status bar, not at the bottom',
    (tester) async {
      await pumpApp(tester);
      AppSnack.show('Saved');
      await tester.pump();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      final rect = tester.getRect(find.text('Saved'));
      final screen = tester.view.physicalSize / tester.view.devicePixelRatio;
      expect(rect.top, lessThan(screen.height / 4));
      expect(rect.bottom, lessThan(screen.height / 2));
      AppSnack.dismiss();
    },
  );

  testWidgets('a new one replaces the current, and it clears itself', (
    tester,
  ) async {
    await pumpApp(tester);
    AppSnack.show('First');
    AppSnack.show('Second');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('First'), findsNothing);
    expect(find.text('Second'), findsOneWidget);
    await tester.pump(const Duration(seconds: 4));
    expect(find.text('Second'), findsNothing);
  });

  testWidgets('an action runs its callback and closes the snack', (
    tester,
  ) async {
    await pumpApp(tester);
    var taps = 0;
    AppSnack.show('Failed', actionLabel: 'Retry', onAction: () => taps++);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    await tester.tap(find.text('Retry'));
    await tester.pump();
    expect(taps, 1);
    expect(find.text('Failed'), findsNothing);
  });

  testWidgets('it floats above a dialog', (tester) async {
    await pumpApp(tester);
    showDialog<void>(
      context: navigator.currentContext!,
      builder: (_) => const AlertDialog(content: Text('Dialog body')),
    );
    await tester.pump(const Duration(milliseconds: 300));
    AppSnack.show('Over the dialog');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('Over the dialog'), findsOneWidget);
    expect(tester.takeException(), isNull);
    AppSnack.dismiss();
  });

  testWidgets('with no overlay yet it does nothing instead of throwing', (
    tester,
  ) async {
    AppSnack.overlayProvider = () => null;
    AppSnack.show('Nowhere');
    expect(tester.takeException(), isNull);
  });

  testWidgets('an empty message is ignored', (tester) async {
    await pumpApp(tester);
    AppSnack.show('   ');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.byType(Material), findsWidgets); // the app itself
    expect(find.text('   '), findsNothing);
  });
}
