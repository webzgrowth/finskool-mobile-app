@Tags(['golden'])
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/domain/model/auth/user_model.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';
import 'package:finskool/src/presentation/pages/dashboard/profile/widgets/profile_header.dart';
import 'package:finskool/src/presentation/pages/dashboard/profile/widgets/profile_sections.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'support/ticket_fakes.dart';

/// Renders the Profile header + sections into `build/profile_goldens/` to lay
/// beside Figma's export of the Final page's `Profile` frame.
void main() {
  setUpAll(loadAppFonts);

  testWidgets('profile', (tester) async {
    debugDisableShadows = false;
    try {
      tester.view.physicalSize = const Size(750, 2714);
      tester.view.devicePixelRatio = 2;
      addTearDown(tester.view.reset);

      CommunityModel c(String name, String slug, int days) => CommunityModel(
        id: slug,
        name: name,
        slug: slug,
        tags: const [],
        memberCount: 0,
        subscribedUntil: DateTime.now().add(Duration(days: days, hours: 2)),
      );

      await tester.pumpWidget(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          home: MediaQuery(
            data: const MediaQueryData(
              size: Size(375, 1357),
              padding: EdgeInsets.only(top: 44, bottom: 34),
            ),
            child: Scaffold(
              backgroundColor: AppPalette.white,
              body: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ProfileHeader(
                    user: UserModel(
                      id: 'u',
                      name: 'Ritesh Kumar',
                      phone: '+91 78882 20091',
                      email: 'ritesh@gmail.com',
                      role: 'user',
                      isSuperAdmin: false,
                      postNotificationsEnabled: true,
                      memberSince: DateTime(2026, 5, 1),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ProfileSections(
                      subscribed: [
                        c('Intraday Community', 'intraday', 200),
                        c('Finskool21 Academy Community', 'academy', 7),
                        c('Investor Community', 'investor', 200),
                      ],
                      unreadTickets: 4,
                      notificationsOn: true,
                      onToggleNotifications: (_) {},
                      onRenew: (_) {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 300)),
      );
      await tester.pump(const Duration(seconds: 2));
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('../build/profile_goldens/profile.png'),
      );
    } finally {
      debugDisableShadows = true;
    }
  });
}
