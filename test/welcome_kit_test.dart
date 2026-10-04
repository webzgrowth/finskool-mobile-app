import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/data/datasource/welcome_kit_demo_datasource.dart';
import 'package:finskool/src/domain/model/community/welcome_kit.dart';

void main() {
  test('intraday carries two videos, four stats and both risk notices', () {
    final kit = WelcomeKitDemoDatasource.forSlug('intraday-community')!;
    expect(kit.videos, hasLength(2));
    expect(kit.capital.amount, '₹50,000');
    expect(kit.capital.caption, 'Minimum recommended capital');
    expect(kit.capital.stats, hasLength(4));
    expect(kit.riskNotices.map((n) => n.tone),
        [NoticeTone.warning, NoticeTone.danger]);
  });

  test('investor has one video, five stats and no risk notices', () {
    final kit = WelcomeKitDemoDatasource.forSlug('investor-community')!;
    expect(kit.videos, hasLength(1));
    expect(kit.capital.amount, '₹8,00,000');
    expect(kit.capital.caption, 'Recommended capital');
    // Five is odd on purpose — the grid must leave the last tile half-width.
    expect(kit.capital.stats, hasLength(5));
    expect(kit.riskNotices, isEmpty);
  });

  test('both share the blue disclaimer and the mission sign-off', () {
    for (final slug in ['intraday-community', 'investor-community']) {
      final kit = WelcomeKitDemoDatasource.forSlug(slug)!;
      expect(kit.disclaimer.tone, NoticeTone.info);
      // The disclaimer is the one notice with no heading above it.
      expect(kit.disclaimer.title, isNull);
      expect(kit.mission, hasLength(2));
    }
  });

  test('the academy carries no trading risk or capital claims', () {
    final kit = WelcomeKitDemoDatasource.forSlug('finskool21-academy')!;
    // A course has a fee and a syllabus; Intraday's capital and risk
    // banners would be false on it.
    expect(kit.riskNotices, isEmpty);
    expect(kit.capital.title, isNot('Capital Allocation'));
    expect(kit.capital.caption, 'One-time course fee');
  });

  test('an unknown community gets no kit', () {
    expect(WelcomeKitDemoDatasource.forSlug('swing-alpha-community'), isNull);
    expect(WelcomeKitDemoDatasource.forSlug(''), isNull);
  });
}
