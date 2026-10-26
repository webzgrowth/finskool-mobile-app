import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/presentation/pages/dashboard/profile/widgets/logout_dialog.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

void main() {
  /// Opens the dialog and returns what `showLogoutDialog` resolved to.
  Future<bool?> run(
    WidgetTester tester,
    Future<void> Function() interact,
  ) async {
    bool? result;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () async => result = await showLogoutDialog(context),
              child: const Text('open'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    expect(find.text('Log out?'), findsOneWidget);
    await interact();
    await tester.pumpAndSettle();
    expect(find.text('Log out?'), findsNothing);
    return result;
  }

  testWidgets('only the Log out button confirms', (tester) async {
    final r = await run(tester, () => tester.tap(find.text('Log out').last));
    expect(r, isTrue);
  });

  testWidgets('Cancel does not sign out', (tester) async {
    final r = await run(tester, () => tester.tap(find.text('Cancel')));
    expect(r, isFalse);
  });

  testWidgets('tapping outside the dialog does not sign out', (tester) async {
    final r = await run(tester, () => tester.tapAt(const Offset(5, 5)));
    expect(r, isFalse);
  });
}
