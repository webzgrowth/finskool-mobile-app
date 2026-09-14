import 'package:flutter/material.dart';

import '../text/text_style_factory.dart';
import '../tokens/app_palette.dart';

/// Post-card type, measured from Figma's feed frame (`605:15302`).
///
/// Separate from the global [TextTheme] on purpose: the card's author name
/// and title are **Manrope 700**, whereas the theme's `titleMedium` /
/// `titleLarge` are Inter by design because the auth screens are matched to
/// them. Repurposing those would silently reskin every auth screen.
///
/// **Two families in Figma aren't bundled**: the hashtags are Poppins and
/// the reaction count is Nunito. Neither ships with the app (only Manrope +
/// Inter, see CLAUDE.md "Typography"), so both are approximated with Inter
/// at Figma's exact size, weight, line-height and colour. Add the real
/// families to `pubspec.yaml` if the difference matters.
@immutable
class FeedTypography extends ThemeExtension<FeedTypography> {
  const FeedTypography({
    required this.authorName,
    required this.timestamp,
    required this.title,
    required this.body,
    required this.hashtag,
    required this.reactionCount,
    required this.durationBadge,
    required this.sheetTitle,
    required this.tabLabel,
    required this.reactorName,
  });

  final TextStyle authorName;
  final TextStyle timestamp;
  final TextStyle title;
  final TextStyle body;
  final TextStyle hashtag;
  final TextStyle reactionCount;
  final TextStyle durationBadge;

  /// Reactions bottom sheet.
  final TextStyle sheetTitle;
  final TextStyle tabLabel;
  final TextStyle reactorName;

  /// Figma line-heights are absolute px; the ratios below are
  /// `lineHeightPx / fontSize` so they survive text scaling.
  static final FeedTypography light = FeedTypography(
    // Manrope 700 · 14 · 20.25px · #143F3D
    authorName: manrope(
        size: 14, weight: 700, height: 1.446, color: AppPalette.postAuthor),
    // Inter 400 · 11 · 13.31px · #B4B2A9
    timestamp: inter(
        size: 11, weight: 400, height: 1.21, color: AppPalette.postTimestamp),
    // Manrope 700 · 14 · 16.70px · #000000
    title: manrope(
        size: 14, weight: 700, height: 1.193, color: AppPalette.postTitle),
    // Inter 400 · 10 · 13.36px · #2D2D2D
    body: inter(size: 10, weight: 400, height: 1.336, color: AppPalette.postBody),
    // Poppins 400 · 10.04 · 15.06px · #7D7D91  (approximated with Inter)
    hashtag:
        inter(size: 10, weight: 400, height: 1.5, color: AppPalette.postMeta),
    // Nunito 400 · 13.04 · 17.88px · #000000  (approximated with Inter)
    reactionCount: inter(
        size: 13, weight: 400, height: 1.371, color: AppPalette.postTitle),
    // Inter 500 · 8.55 · 11.40px · #FFFFFF
    durationBadge:
        inter(size: 8.5, weight: 500, height: 1.333, color: AppPalette.white),
    // Inter 600 · 18 · 22px · #000000
    sheetTitle: inter(
        size: 18, weight: 600, height: 1.222, color: AppPalette.postTitle),
    // Inter 400 · 12 · 22px · #108B8B — every tab is teal; only the
    // underline marks the selected one.
    tabLabel: inter(
        size: 12, weight: 400, height: 1.833, color: AppPalette.badgeTeal),
    // Inter 500 · 12 · #000000
    reactorName: inter(
        size: 12, weight: 500, height: 1.4, color: AppPalette.postTitle),
  );

  static final FeedTypography dark = FeedTypography(
    authorName: manrope(
        size: 14, weight: 700, height: 1.446, color: AppPalette.darkOnSurface),
    timestamp: inter(
        size: 11,
        weight: 400,
        height: 1.21,
        color: AppPalette.darkOnSurfaceMuted),
    title: manrope(
        size: 14, weight: 700, height: 1.193, color: AppPalette.darkOnSurface),
    body: inter(
        size: 10,
        weight: 400,
        height: 1.336,
        color: AppPalette.darkOnSurfaceMuted),
    hashtag: inter(
        size: 10,
        weight: 400,
        height: 1.5,
        color: AppPalette.darkOnSurfaceMuted),
    reactionCount: inter(
        size: 13, weight: 400, height: 1.371, color: AppPalette.darkOnSurface),
    durationBadge:
        inter(size: 8.5, weight: 500, height: 1.333, color: AppPalette.white),
    sheetTitle: inter(
        size: 18, weight: 600, height: 1.222, color: AppPalette.darkOnSurface),
    tabLabel: inter(
        size: 12, weight: 400, height: 1.833, color: AppPalette.teal400),
    reactorName: inter(
        size: 12, weight: 500, height: 1.4, color: AppPalette.darkOnSurface),
  );

  static FeedTypography of(Brightness brightness) =>
      brightness == Brightness.dark ? dark : light;

  @override
  FeedTypography copyWith({
    TextStyle? authorName,
    TextStyle? timestamp,
    TextStyle? title,
    TextStyle? body,
    TextStyle? hashtag,
    TextStyle? reactionCount,
    TextStyle? durationBadge,
    TextStyle? sheetTitle,
    TextStyle? tabLabel,
    TextStyle? reactorName,
  }) =>
      FeedTypography(
        authorName: authorName ?? this.authorName,
        timestamp: timestamp ?? this.timestamp,
        title: title ?? this.title,
        body: body ?? this.body,
        hashtag: hashtag ?? this.hashtag,
        reactionCount: reactionCount ?? this.reactionCount,
        durationBadge: durationBadge ?? this.durationBadge,
        sheetTitle: sheetTitle ?? this.sheetTitle,
        tabLabel: tabLabel ?? this.tabLabel,
        reactorName: reactorName ?? this.reactorName,
      );

  @override
  FeedTypography lerp(ThemeExtension<FeedTypography>? other, double t) {
    if (other is! FeedTypography) return this;
    return FeedTypography(
      authorName: TextStyle.lerp(authorName, other.authorName, t)!,
      timestamp: TextStyle.lerp(timestamp, other.timestamp, t)!,
      title: TextStyle.lerp(title, other.title, t)!,
      body: TextStyle.lerp(body, other.body, t)!,
      hashtag: TextStyle.lerp(hashtag, other.hashtag, t)!,
      reactionCount: TextStyle.lerp(reactionCount, other.reactionCount, t)!,
      durationBadge: TextStyle.lerp(durationBadge, other.durationBadge, t)!,
      sheetTitle: TextStyle.lerp(sheetTitle, other.sheetTitle, t)!,
      tabLabel: TextStyle.lerp(tabLabel, other.tabLabel, t)!,
      reactorName: TextStyle.lerp(reactorName, other.reactorName, t)!,
    );
  }
}

extension FeedTypographyX on BuildContext {
  FeedTypography get feedType => Theme.of(this).extension<FeedTypography>()!;
}
