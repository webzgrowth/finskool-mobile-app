/// The onboarding material shown under a subscription: the videos to watch
/// first, how much capital the strategy expects, its numbers at a glance,
/// and the risk notices that go with it.
///
/// Per-community content — Intraday's kit and Investor's share no copy, no
/// figures and not even the same set of notices — so this is **data**, not
/// a widget full of literals. Every string may carry `**bold**` runs and is
/// rendered through `comman/rich_text_spans.dart`.
class WelcomeKit {
  const WelcomeKit({
    required this.watchIntro,
    required this.videos,
    required this.capital,
    required this.disclaimer,
    this.riskNotices = const [],
    this.mission = const [],
  });

  /// The paragraph above the video list, e.g. "**Welcome to the Intraday
  /// Community!** Both videos cover…".
  final String watchIntro;
  final List<WelcomeKitVideo> videos;
  final CapitalAllocation capital;

  /// Shown **between** Capital Allocation and "What You get" — the accuracy
  /// caveat and the high-risk warning. Investor's kit has none, which is
  /// why this defaults to empty rather than being required.
  final List<WelcomeKitNotice> riskNotices;

  /// The blue "understand the trading process" banner, which sits *after*
  /// "What You get" rather than with the others.
  final WelcomeKitNotice disclaimer;

  /// The centred teal sign-off, one entry per line.
  final List<String> mission;
}

class WelcomeKitVideo {
  const WelcomeKitVideo({
    required this.title,
    this.thumbnailUrl,
    this.videoUrl,
  });

  final String title;
  final String? thumbnailUrl;

  /// Tapping a row opens this. Null leaves the row inert rather than
  /// pretending to be a link.
  final String? videoUrl;
}

class CapitalAllocation {
  const CapitalAllocation({
    required this.amount,
    required this.caption,
    required this.description,
    required this.stats,
    this.title = 'Capital Allocation',
    this.statsHeading = 'Strategy at a glance',
  });

  /// The teal bar's text. Overridable because "Capital Allocation" and
  /// "Strategy" describe a *trading* community — a course has a fee and a
  /// syllabus, not capital to deploy.
  final String title;
  final String statsHeading;

  /// Pre-formatted (`₹50,000`, `₹8,00,000`) rather than an int: these are
  /// editorial figures in Indian grouping, not something to compute.
  final String amount;

  /// "Minimum recommended capital" / "Recommended capital".
  final String caption;
  final String description;

  /// The "Strategy at a glance" tiles. Laid out two per row, so an odd
  /// count leaves the last tile half-width — which is what the design does.
  final List<WelcomeKitStat> stats;
}

class WelcomeKitStat {
  const WelcomeKitStat({required this.value, required this.label});

  final String value;
  final String label;
}

/// Tone drives the plate, hairline, ink and icon together — the three
/// banners differ only in that, so they share one widget.
enum NoticeTone { info, warning, danger }

class WelcomeKitNotice {
  const WelcomeKitNotice({
    required this.tone,
    required this.body,
    this.title,
  });

  final NoticeTone tone;

  /// Null on the blue disclaimer, which is a single paragraph with no
  /// heading above it.
  final String? title;
  final String body;
}
