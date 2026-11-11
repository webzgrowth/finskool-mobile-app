import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/domain/model/service/service_model.dart';
import 'package:finskool/src/presentation/pages/dashboard/profile/widgets/profile_glyphs.dart';
import 'package:finskool/src/presentation/pages/dashboard/profile/widgets/profile_menu_row.dart';
import 'package:finskool/src/presentation/pages/services/widgets/my_requests_row.dart';
import 'package:finskool/src/presentation/pages/services/widgets/service_card.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'support/ticket_fakes.dart';

Widget _app(Widget child) => MaterialApp(
  theme: AppTheme.light,
  home: Scaffold(body: SingleChildScrollView(child: child)),
);

void main() {
  setUpAll(loadAppFonts);

  testWidgets('a service description shows **bold** as bold, not asterisks', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(
        ServiceCard(
          service: const ServiceModel(
            id: 's1',
            title: 'Intelligent Model Portfolio',
            description: 'Invest in **quality businesses** for the long run.',
          ),
          onEnquire: () {},
        ),
      ),
    );
    expect(find.textContaining('**', findRichText: true), findsNothing);
    expect(
      find.textContaining('quality businesses', findRichText: true),
      findsOneWidget,
    );

    final rich = tester
        .widgetList<RichText>(find.byType(RichText))
        .firstWhere((r) => r.text.toPlainText().contains('quality businesses'));
    final weights = <String, FontWeight?>{};
    rich.text.visitChildren((s) {
      if (s is TextSpan && s.text != null) {
        weights[s.text!] = s.style?.fontWeight;
      }
      return true;
    });
    expect(
      weights['quality businesses']!.value > weights['Invest in ']!.value,
      isTrue,
      reason: '$weights',
    );
  });

  group('MyRequestsRow', () {
    testWidgets('shows its own unread count and reports a tap', (tester) async {
      var taps = 0;
      await tester.pumpWidget(
        _app(MyRequestsRow(unread: 3, onTap: () => taps++)),
      );
      expect(find.text('My requests'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      await tester.tap(find.text('My requests'));
      expect(taps, 1);
    });

    testWidgets('no count at zero, and 99+ when large', (tester) async {
      await tester.pumpWidget(_app(MyRequestsRow(unread: 0, onTap: () {})));
      expect(find.text('0'), findsNothing);
      await tester.pumpWidget(_app(MyRequestsRow(unread: 250, onTap: () {})));
      expect(find.text('99+'), findsOneWidget);
    });
  });

  group('ProfileMenuRow', () {
    Color? tile(WidgetTester tester) {
      final box = tester
          .widgetList<Container>(find.byType(Container))
          .map((c) => c.decoration)
          .whereType<BoxDecoration>()
          .firstWhere((d) => d.borderRadius != null);
      return box.color;
    }

    testWidgets('a normal row has the teal tile, a danger row the red one', (
      tester,
    ) async {
      await tester.pumpWidget(
        _app(
          const ProfileMenuRow(
            glyph: ProfileGlyphs.user,
            title: 'Edit Profile',
          ),
        ),
      );
      expect(tile(tester), AppPalette.badgeTeal);

      await tester.pumpWidget(
        _app(
          const ProfileMenuRow(
            glyph: ProfileGlyphs.trash,
            title: 'Delete account',
            danger: true,
          ),
        ),
      );
      expect(tile(tester), AppPalette.ticketRequired);
    });
  });
}
