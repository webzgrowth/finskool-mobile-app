import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/injections/injection.dart';
import 'package:finskool/src/data/repository/profile_info_repository_impl.dart';
import 'package:finskool/src/domain/model/auth/user_model.dart';
import 'package:finskool/src/domain/repository/profile_info_repository.dart';
import 'package:finskool/src/presentation/pages/dashboard/profile/info/delete_account_request.dart';
import 'package:finskool/src/presentation/pages/dashboard/profile/info/delete_account_screen.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'support/ticket_fakes.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
    if (!locator.isRegistered<ProfileInfoRepository>()) {
      locator.registerSingleton<ProfileInfoRepository>(
        ProfileInfoRepositoryImpl(),
      );
    }
  });

  group('deleteAccountMailto', () {
    test('goes to support with a subject and an encoded body', () {
      final uri = Uri.parse(
        deleteAccountMailto(
          to: 'support@finskool21.com',
          user: const UserModel(
            id: '1',
            name: 'Asha Rao',
            phone: '+919876543210',
            email: 'asha@example.com',
            role: 'member',
            isSuperAdmin: false,
            postNotificationsEnabled: true,
          ),
        ),
      );
      expect(uri.scheme, 'mailto');
      expect(uri.path, 'support@finskool21.com');
      expect(uri.queryParameters['subject'], 'Account deletion request');
      final body = uri.queryParameters['body']!;
      expect(body, contains('Name: Asha Rao'));
      expect(body, contains('Email: asha@example.com'));
      expect(body, contains('Phone: +919876543210'));
    });

    test('spaces are %20, not +, so mail apps do not show a plus', () {
      expect(deleteAccountMailto(to: 'a@b.c'), isNot(contains('+')));
    });

    test('with no signed-in user it still produces a valid request', () {
      final body = Uri.parse(deleteAccountMailto(to: 'a@b.c'))
          .queryParameters['body']!;
      expect(body, contains('delete my Finskool21 account'));
      expect(body, isNot(contains('Name:')));
    });
  });

  group('DeleteAccountView', () {
    testWidgets('explains what is kept, then needs a confirm to proceed', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(750, 2400);
      tester.view.devicePixelRatio = 2;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        MaterialApp(theme: AppTheme.light, home: const DeleteAccountView()),
      );
      await tester.pump(const Duration(milliseconds: 400));

      expect(
        find.textContaining('except records we must keep by law'),
        findsOneWidget,
      );
      expect(find.textContaining('no refund will be issued'), findsOneWidget);

      await tester.tap(find.text('Request account deletion'));
      await tester.pumpAndSettle();
      expect(find.text('Delete your account?'), findsOneWidget);

      // Cancel leaves the dialog and does nothing else.
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(find.text('Delete your account?'), findsNothing);
      expect(tester.takeException(), isNull);
    });
  });
}
