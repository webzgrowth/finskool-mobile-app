@Tags(['golden'])
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/injections/injection.dart';
import 'package:finskool/src/data/repository/profile_info_repository_impl.dart';
import 'package:finskool/src/domain/repository/profile_info_repository.dart';
import 'package:finskool/src/presentation/pages/dashboard/profile/info/about_sebi_screen.dart';
import 'package:finskool/src/presentation/pages/dashboard/profile/info/help_support_screen.dart';
import 'package:finskool/src/presentation/pages/dashboard/profile/info/terms_privacy_screen.dart';
import 'package:finskool/src/presentation/pages/dashboard/profile/widgets/logout_button.dart';
import 'package:finskool/src/presentation/pages/dashboard/profile/widgets/logout_dialog.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'support/ticket_fakes.dart';

/// Renders the Profile info screens + the logout control into
/// `build/profile_goldens/` to lay beside Figma's `1554:8149` / `1554:8682`.
void main() {
  setUpAll(() async {
    await loadAppFonts();
    if (!locator.isRegistered<ProfileInfoRepository>()) {
      locator.registerSingleton<ProfileInfoRepository>(
        ProfileInfoRepositoryImpl(),
      );
    }
  });

  Future<void> shot(
    WidgetTester tester,
    String name,
    Widget screen,
    double height,
  ) async {
    debugDisableShadows = false;
    try {
      tester.view.physicalSize = Size(750, height * 2);
      tester.view.devicePixelRatio = 2;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          home: MediaQuery(
            data: MediaQueryData(
              size: Size(375, height),
              padding: const EdgeInsets.only(top: 44, bottom: 34),
            ),
            child: screen,
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 400));
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('../build/profile_goldens/$name.png'),
      );
    } finally {
      debugDisableShadows = true;
    }
  }

  testWidgets(
    'about',
    (t) => shot(t, 'info_about', const AboutSebiScreen(), 1384),
  );
  testWidgets(
    'terms',
    (t) => shot(t, 'info_terms', const TermsPrivacyScreen(), 1010),
  );
  testWidgets(
    'privacy tab',
    (t) =>
        shot(t, 'info_privacy', const TermsPrivacyScreen(initialTab: 1), 1010),
  );
  testWidgets(
    'help',
    (t) => shot(t, 'info_help', const HelpSupportScreen(), 1100),
  );

  testWidgets('logout button + dialog', (t) async {
    await shot(
      t,
      'info_logout',
      Scaffold(
        backgroundColor: AppPalette.white,
        body: Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 60),
                LogoutButton(
                  loading: false,
                  onPressed: () => showLogoutDialog(context),
                ),
              ],
            ),
          ),
        ),
      ),
      400,
    );
    await t.tap(find.byType(LogoutButton));
    await t.pump();
    await t.pump(const Duration(milliseconds: 400));
    expect(find.text('Log out?'), findsOneWidget);
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('../build/profile_goldens/info_logout_dialog.png'),
    );
  });
}
