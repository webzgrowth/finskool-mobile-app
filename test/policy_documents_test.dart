import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/injections/injection.dart';
import 'package:finskool/src/data/repository/profile_info_repository_impl.dart';
import 'package:finskool/src/domain/model/profile/profile_info.dart';
import 'package:finskool/src/domain/repository/profile_info_repository.dart';
import 'package:finskool/src/presentation/pages/dashboard/profile/info/policy_document_screen.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'support/ticket_fakes.dart';

void main() {
  final repo = ProfileInfoRepositoryImpl();

  setUpAll(() async {
    await loadAppFonts();
    if (!locator.isRegistered<ProfileInfoRepository>()) {
      locator.registerSingleton<ProfileInfoRepository>(repo);
    }
  });

  group('the compliance documents', () {
    test(
      'every kind resolves to its own document, and its slug round-trips',
      () {
        for (final kind in PolicyKind.values) {
          final doc = repo.policy(kind);
          expect(doc.kind, kind);
          expect(doc.blocks, isNotEmpty);
          expect(PolicyKind.fromSlug(kind.slug), kind);
        }
        expect(PolicyKind.fromSlug('nope'), isNull);
        expect(PolicyKind.fromSlug(null), isNull);
      },
    );

    test('every link block opens something', () {
      for (final kind in PolicyKind.values) {
        for (final b in repo.policy(kind).blocks.whereType<PolicyLinks>()) {
          for (final l in b.links) {
            expect(l.url, isNotNull, reason: l.title);
          }
        }
      }
    });

    test('the SEBI registration number is the same everywhere it appears', () {
      final parts = <String>[];
      for (final k in PolicyKind.values) {
        for (final b in repo.policy(k).blocks) {
          if (b is PolicyParagraph) parts.add(b.text);
          if (b is PolicyBullets) parts.addAll(b.items);
        }
      }
      final text = parts.join(' ');
      final numbers = RegExp(r'INH\d+').allMatches(text).map((m) => m.group(0));
      expect(numbers.toSet(), {repo.sebi.registrationNo});
    });

    test('About & SEBI no longer carries the documents list', () {
      // The documents moved to Profile → Settings; the model has no field left
      // to put them back in by accident.
      expect(repo.sebi.disclaimer, isNotEmpty);
    });
  });

  group('PolicyDocumentScreen', () {
    Future<void> open(WidgetTester tester, PolicyKind kind) async {
      tester.view.physicalSize = const Size(750, 2400);
      tester.view.devicePixelRatio = 2;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: PolicyDocumentScreen(kind: kind),
        ),
      );
      await tester.pump(const Duration(milliseconds: 400));
    }

    testWidgets('Disclosures shows its title and first section', (
      tester,
    ) async {
      await open(tester, PolicyKind.disclosures);
      expect(find.text('Disclosures'), findsWidgets);
      expect(
        find.textContaining('INH000022987', skipOffstage: false),
        findsWidgets,
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('Investor charter shows its lettered parts', (tester) async {
      await open(tester, PolicyKind.investorCharter);
      expect(find.text('Investor charter'), findsWidgets);
      expect(
        find.text('A. Vision and mission statements for investors'),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('Refund policy shows the no-refund clause', (tester) async {
      await open(tester, PolicyKind.refund);
      expect(find.text('Refund policy'), findsWidgets);
      expect(
        find.textContaining('All payments are final', skipOffstage: false),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('Terms and Privacy render without overflow', (tester) async {
      for (final k in [PolicyKind.terms, PolicyKind.privacy]) {
        await open(tester, k);
        expect(find.text(repo.policy(k).title), findsWidgets);
        expect(tester.takeException(), isNull);
      }
    });
  });
}
