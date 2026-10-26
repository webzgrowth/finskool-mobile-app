import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/domain/model/community/welcome_kit.dart';

/// `GET /mobile/communities/{id}/welcome-kit`, as documented.
Map<String, dynamic> _payload() => {
  'communityId': 'c1',
  'communityName': 'Intraday',
  'watchBeforeYouStart': {
    'introMarkdown': '**Welcome!** Watch both videos.',
    'videos': [
      {
        'url': 'https://youtu.be/aaaaaaaaaaa',
        'videoId': 'aaaaaaaaaaa',
        'embedUrl': 'https://www.youtube.com/embed/aaaaaaaaaaa',
        'thumbnailUrl': 'https://img/a.jpg',
      },
      {'url': 'https://youtu.be/bbbbbbbbbbb', 'thumbnailUrl': null},
    ],
  },
  'capitalAllocation': {
    'heroStat': '₹50,000',
    'description': 'Minimum recommended capital\nDeploy the **full amount**.',
    'strategyTitle': 'Strategy at a glance',
    'strategies': [
      {'priority': 2, 'value': '12', 'label': 'Trades per month'},
      {'priority': 1, 'value': '3', 'label': 'Recommendations per week'},
    ],
  },
  'strategyNotices': [
    {
      'priority': 1,
      'type': 'warning',
      'heading': 'High risk',
      'description': 'Be careful.',
    },
    {'priority': 2, 'type': 'normal', 'heading': '', 'description': 'FYI.'},
  ],
  'whatYouGet': [
    {'priority': 2, 'text': 'second'},
    {'priority': 1, 'text': 'first'},
  ],
};

void main() {
  test('parses every section, ordered by priority', () {
    final kit = WelcomeKit.fromJson(_payload());
    expect(kit.intro, '**Welcome!** Watch both videos.');
    expect(kit.videos, hasLength(2));
    expect(kit.videos.first.thumbnailUrl, 'https://img/a.jpg');
    expect(kit.videos.last.thumbnailUrl, isNull);
    expect(kit.capital!.amount, '₹50,000');
    expect(kit.capital!.stats.map((s) => s.value), ['3', '12']);
    expect(kit.whatYouGet, ['first', 'second']);
    expect(kit.isEmpty, isFalse);
  });

  test('a one-line label is split off the description', () {
    final capital = WelcomeKit.fromJson(_payload()).capital!;
    expect(capital.caption, 'Minimum recommended capital');
    expect(capital.description, 'Deploy the **full amount**.');
  });

  test('a single paragraph stays whole — no invented caption', () {
    final kit = WelcomeKit.fromJson({
      'capitalAllocation': {
        'heroStat': '₹8,00,000',
        'description': 'The recommended capital is ₹8,00,000, with a target.',
      },
    });
    expect(kit.capital!.caption, isNull);
    expect(kit.capital!.description, contains('recommended capital is'));
    expect(kit.capital!.statsHeading, 'Strategy at a glance');
  });

  test(
    'warning is the red notice, normal the info one; blank heading is null',
    () {
      final notices = WelcomeKit.fromJson(_payload()).notices;
      expect(notices.map((n) => n.tone), [NoticeTone.danger, NoticeTone.info]);
      expect(notices.first.title, 'High risk');
      expect(notices.last.title, isNull);
    },
  );

  test('every section is optional; an empty kit says so', () {
    final kit = WelcomeKit.fromJson({
      'watchBeforeYouStart': null,
      'capitalAllocation': null,
      'strategyNotices': [],
      'whatYouGet': [],
    });
    expect(kit.isEmpty, isTrue);
    expect(kit.capital, isNull);
  });

  test('a video with no url at all is dropped, not rendered as a dead row', () {
    final kit = WelcomeKit.fromJson({
      'watchBeforeYouStart': {
        'videos': [
          {'thumbnailUrl': 'x'},
          {'embedUrl': 'https://www.youtube.com/embed/ccccccccccc'},
        ],
      },
    });
    expect(kit.videos, hasLength(1));
  });
}
