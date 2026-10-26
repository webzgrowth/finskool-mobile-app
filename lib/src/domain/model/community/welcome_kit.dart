/// The onboarding material a **paid** community's admin publishes for its
/// members — the videos to watch first, the capital the strategy expects, its
/// numbers at a glance, any notices, and what the member gets.
///
/// Backend-owned: `GET /mobile/communities/{id}/welcome-kit`. Every section
/// is optional (an admin can publish a kit with only some of them), so each
/// is nullable/empty here and the screen renders only what exists.
///
/// Free text (`intro`, descriptions, notice bodies, `whatYouGet`) arrives as
/// **raw markdown** and is rendered through `comman/markdown_text.dart`.
class WelcomeKit {
  const WelcomeKit({
    this.intro,
    this.videos = const [],
    this.capital,
    this.notices = const [],
    this.whatYouGet = const [],
  });

  /// "Watch before you start" paragraph; null when the admin skipped it.
  final String? intro;
  final List<WelcomeKitVideo> videos;
  final CapitalAllocation? capital;

  /// Strategy notices, in the admin's `priority` order.
  final List<WelcomeKitNotice> notices;

  /// "What You get" pointers, in `priority` order. When empty the screen
  /// falls back to the community's own catalog benefits.
  final List<String> whatYouGet;

  bool get hasWatchSection => videos.isNotEmpty || (intro?.isNotEmpty ?? false);

  /// True when there is nothing to draw at all.
  bool get isEmpty =>
      !hasWatchSection &&
      capital == null &&
      notices.isEmpty &&
      whatYouGet.isEmpty;

  factory WelcomeKit.fromJson(Map<String, dynamic> json) {
    final watch = json['watchBeforeYouStart'] as Map<String, dynamic>?;
    final capital = json['capitalAllocation'] as Map<String, dynamic>?;
    return WelcomeKit(
      intro: (watch?['introMarkdown'] as String?)?.trim(),
      videos: [
        for (final v in (watch?['videos'] as List?) ?? const [])
          if (v is Map<String, dynamic>)
            if (WelcomeKitVideo.fromJson(v) case final video?) video,
      ],
      capital: capital == null ? null : CapitalAllocation.fromJson(capital),
      notices: _byPriority(json['strategyNotices'])
          .map(WelcomeKitNotice.fromJson)
          .toList(),
      whatYouGet: _byPriority(json['whatYouGet'])
          .map((e) => (e['text'] as String? ?? '').trim())
          .where((t) => t.isNotEmpty)
          .toList(),
    );
  }
}

/// The API sorts nothing for us on the client side's behalf ("lists are
/// sorted by `priority`"); sort defensively anyway so a reordered payload
/// can't reorder the screen.
List<Map<String, dynamic>> _byPriority(Object? raw) {
  final rows = [
    for (final e in (raw as List?) ?? const [])
      if (e is Map<String, dynamic>) e,
  ];
  rows.sort(
    (a, b) =>
        ((a['priority'] as num?) ?? 0).compareTo((b['priority'] as num?) ?? 0),
  );
  return rows;
}

class WelcomeKitVideo {
  const WelcomeKitVideo({
    required this.url,
    this.title,
    this.thumbnailUrl,
    this.videoId,
  });

  /// The watch link — what tapping the row opens.
  final String url;

  /// Not in the documented payload; used when the backend sends one, else
  /// the row falls back to "Video N".
  final String? title;
  final String? thumbnailUrl;
  final String? videoId;

  /// Null when there's nothing to open, so a row can't be an empty link.
  static WelcomeKitVideo? fromJson(Map<String, dynamic> json) {
    String? pick(String key) {
      final v = json[key] as String?;
      return (v == null || v.isEmpty) ? null : v;
    }

    final url = pick('url') ?? pick('embedUrl');
    if (url == null) return null;
    return WelcomeKitVideo(
      url: url,
      title: pick('title'),
      thumbnailUrl: pick('thumbnailUrl'),
      videoId: pick('videoId'),
    );
  }
}

class CapitalAllocation {
  const CapitalAllocation({
    required this.amount,
    required this.description,
    required this.stats,
    this.caption,
    this.statsHeading = 'Strategy at a glance',
  });

  /// The big teal figure (`heroStat`) — pre-formatted by the admin
  /// (`₹50,000`), not computed.
  final String amount;

  /// A short label split off the front of the description ("Minimum
  /// recommended capital"), or null when the description is a single
  /// paragraph. See [fromJson].
  final String? caption;
  final String description;

  /// `strategyTitle`, e.g. "Strategy at a glance".
  final String statsHeading;

  /// Laid out two per row, so an odd count leaves the last tile half-width.
  final List<WelcomeKitStat> stats;

  factory CapitalAllocation.fromJson(Map<String, dynamic> json) {
    final (caption, body) = _splitCaption(
      (json['description'] as String? ?? '').trim(),
    );
    final heading = (json['strategyTitle'] as String?)?.trim();
    return CapitalAllocation(
      amount: (json['heroStat'] as String? ?? '').trim(),
      caption: caption,
      description: body,
      statsHeading: (heading == null || heading.isEmpty)
          ? 'Strategy at a glance'
          : heading,
      stats: _byPriority(json['strategies'])
          .map(
            (s) => WelcomeKitStat(
              value: (s['value'] as String? ?? '').trim(),
              label: (s['label'] as String? ?? '').trim(),
            ),
          )
          .toList(),
    );
  }

  /// The design puts a one-line label ("Recommended capital") above the
  /// descriptive paragraph, but the API has a single `description` field —
  /// the admin types both into it, label on the first line. Split on the
  /// first line break when that first line is short and isn't a sentence;
  /// otherwise keep it all as the description rather than guess.
  static (String?, String) _splitCaption(String text) {
    final at = text.indexOf('\n');
    if (at <= 0) return (null, text);
    final first = text.substring(0, at).trim();
    final rest = text.substring(at + 1).trim();
    final looksLikeLabel =
        first.length <= 48 && !first.endsWith('.') && rest.isNotEmpty;
    return looksLikeLabel ? (first, rest) : (null, text);
  }
}

class WelcomeKitStat {
  const WelcomeKitStat({required this.value, required this.label});

  final String value;
  final String label;
}

/// Tone drives the plate, hairline, ink and icon together — the notice
/// styles differ only in that, so they share one widget. The API has two
/// types: `warning` is the red risk notice, `normal` the teal "i" one.
enum NoticeTone { info, danger }

class WelcomeKitNotice {
  const WelcomeKitNotice({required this.tone, required this.body, this.title});

  final NoticeTone tone;
  final String? title;
  final String body;

  factory WelcomeKitNotice.fromJson(Map<String, dynamic> json) {
    final heading = (json['heading'] as String?)?.trim();
    return WelcomeKitNotice(
      tone: json['type'] == 'warning' ? NoticeTone.danger : NoticeTone.info,
      title: (heading == null || heading.isEmpty) ? null : heading,
      body: (json['description'] as String? ?? '').trim(),
    );
  }
}
