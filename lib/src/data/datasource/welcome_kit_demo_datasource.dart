import 'package:finskool/src/domain/model/community/welcome_kit.dart';

/// Welcome Kit copy for the communities the design covers.
///
/// **Content, with no endpoint behind it.** Nothing in the API describes a
/// welcome kit — not the videos, the capital figures, the strategy stats or
/// the risk notices — so this is transcribed from the design. It is keyed by
/// slug and returns null for anything it doesn't know, which hides the whole
/// section rather than showing another community's figures.
///
/// Move this to the backend before these numbers can change: capital
/// guidance and risk wording are the kind of thing that gets revised, and a
/// shipped build is a bad place to keep them.
class WelcomeKitDemoDatasource {
  WelcomeKitDemoDatasource._();

  static WelcomeKit? forSlug(String slug) {
    final key = slug.toLowerCase();
    if (key.contains('intraday')) return _intraday;
    if (key.contains('investor')) return _investor;
    if (key.contains('academy')) return _academy;
    return null;
  }

  static const _disclaimer = WelcomeKitNotice(
    tone: NoticeTone.info,
    body:
        'Please ensure that you **understand the trading** process and '
        'associated risks before participating in any trade.',
  );

  static const _mission = [
    'Saath Mein Seekhenge… Saath Mein Grow Karenge!!',
    'Our Mission: Har Ghar Ek Smart Investor!!',
  ];

  static const _intraday = WelcomeKit(
    watchIntro:
        '**Welcome to the Intraday Community!** Both videos cover the '
        'full trading process, capital allocation, and how to follow the '
        'recommendations.',
    videos: [
      WelcomeKitVideo(
        title:
            'Launching Finskool21 Intraday Community | Happy Independence '
            'Day',
      ),
      WelcomeKitVideo(
        title:
            'Intraday Community | Addressing Queries | Capital Allocation, '
            'How To Buy | Detailed explanation',
      ),
    ],
    capital: CapitalAllocation(
      amount: '₹50,000',
      caption: 'Minimum recommended capital',
      description:
          'Deploy the **full amount** on each recommended trade '
          'rather than splitting it across positions.',
      stats: [
        WelcomeKitStat(value: '3', label: 'Recommendations per week'),
        WelcomeKitStat(value: '12', label: 'Trades per month'),
        WelcomeKitStat(value: '~3%', label: 'Target per trade'),
        WelcomeKitStat(value: '1 : 1', label: 'Risk-reward ratio'),
      ],
    ),
    riskNotices: [
      WelcomeKitNotice(
        tone: NoticeTone.danger,
        title: 'This is a high-risk strategy',
        body:
            'Intraday trading involves a **high level of market risk** and '
            'is not suitable for investors uncomfortable with short-term '
            '**fluctuations or potential losses.**',
      ),
    ],
    disclaimer: _disclaimer,
    mission: _mission,
  );

  /// **Placeholder copy, written here — the Academy has no Figma frame.**
  /// Added so the Welcome Kit shows on every subscription for the demo.
  ///
  /// Deliberately carries **no capital guidance, accuracy figure or risk
  /// warning**: the Academy is a course, and Intraday's "₹50,000 minimum
  /// capital / ~70% accuracy / high-risk strategy" banners would be false
  /// on it. The headings are overridden for the same reason. Every number
  /// below is invented and must be replaced before this is shown to
  /// anyone outside the team.
  static const _academy = WelcomeKit(
    watchIntro:
        '**Welcome to Finskool21 Academy!** Start with the orientation '
        'video — it walks through the syllabus, how modules unlock, and how '
        'to join the live doubt-clearing sessions.',
    videos: [
      WelcomeKitVideo(title: 'Finskool21 Academy | Orientation & How to Begin'),
    ],
    capital: CapitalAllocation(
      title: 'Your Programme',
      statsHeading: 'Programme at a glance',
      amount: '₹15,000',
      caption: 'One-time course fee',
      description:
          'Covers **lifetime access** to every module in your tier, '
          'including future updates to the syllabus.',
      stats: [
        WelcomeKitStat(value: '12', label: 'Modules in this tier'),
        WelcomeKitStat(value: '3 Months', label: 'Average completion time'),
        WelcomeKitStat(value: 'Weekly', label: 'Live doubt-clearing sessions'),
        WelcomeKitStat(value: 'Yes', label: 'Certificate on completion'),
      ],
    ),
    disclaimer: _disclaimer,
    mission: _mission,
  );

  static const _investor = WelcomeKit(
    watchIntro:
        '**Welcome to the Investor Community!** The video covers the '
        'complete trading process, capital allocation, and how to follow the '
        'Investor Community recommendations.',
    videos: [WelcomeKitVideo(title: 'Investors Community - Welcome Video')],
    capital: CapitalAllocation(
      amount: '₹8,00,000',
      caption: 'Recommended capital',
      description:
          'The recommended capital for the Investor Community is '
          '₹8,00,000, in which we provide trades with an **average target of '
          '15%–20%**.',
      stats: [
        WelcomeKitStat(value: '15%–20%', label: 'Average target per trade'),
        WelcomeKitStat(
          value: '10%',
          label: 'Recommended capital allocation per trade',
        ),
        WelcomeKitStat(value: '3 Months', label: 'Average holding period'),
        WelcomeKitStat(value: '3', label: 'Trades per month'),
        WelcomeKitStat(value: '~10', label: 'Trade positions over 3 months'),
      ],
    ),
    // Investor's kit shows no accuracy or high-risk banner — only the blue
    // disclaimer below "What You get".
    disclaimer: _disclaimer,
    mission: _mission,
  );
}
