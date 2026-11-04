import 'package:flutter/material.dart';

import '../tokens/app_palette.dart';

/// Brand values that have no home in a Material [ColorScheme]: the
/// secondary-to-primary gradient and the feed background.
///
/// A [ThemeExtension] rather than static constants so these swap with
/// brightness and lerp during a theme transition.
@immutable
class AppGradients extends ThemeExtension<AppGradients> {
  const AppGradients({
    required this.brand,
    required this.feedBase,
    required this.feedCard,
    required this.badgeLike,
    required this.badgeLove,
    required this.badgeHaha,
    required this.badgeInsightful,
    required this.badgeCelebrate,
    required this.pickerSurface,
    required this.pickerBorder,
  });

  final LinearGradient brand;
  final Color feedBase;
  final Color feedCard;

  /// Ring behind each badge in a post's reaction stack, per reaction.
  /// All five are Figma's own discs (colourful feed variant): blue like, red
  /// love, amber bulb = insightful, teal laughing face = haha, green clap =
  /// celebrate — see `reaction_icons.dart`.
  final Color badgeLike;
  final Color badgeLove;
  final Color badgeHaha;
  final Color badgeInsightful;
  final Color badgeCelebrate;

  /// The long-press reaction picker's plate and its hairline border.
  final Color pickerSurface;
  final Color pickerBorder;

  // Direction vector for the Figma node's 145deg CSS linear-gradient,
  // converted to Flutter's Alignment-based begin/end (CSS 0deg = up,
  // clockwise; Flutter's x = sin(theta), y = -cos(theta)).
  static const AppGradients light = AppGradients(
    brand: LinearGradient(
      begin: Alignment(-0.574, -0.819),
      end: Alignment(0.574, 0.819),
      colors: [
        AppPalette.headerGradientStart,
        AppPalette.headerGradientMid,
        AppPalette.headerGradientEnd,
      ],
      stops: [0.0, 0.195, 0.476],
    ),
    feedBase: AppPalette.feedBase,
    feedCard: AppPalette.white,
    badgeLike: AppPalette.badgeBlue,
    badgeLove: AppPalette.badgeRed,
    badgeHaha: AppPalette.badgeTeal,
    badgeInsightful: AppPalette.badgeAmber,
    badgeCelebrate: AppPalette.badgeGreen,
    pickerSurface: AppPalette.pickerSurface,
    pickerBorder: AppPalette.pickerBorder,
  );

  static const AppGradients dark = AppGradients(
    brand: LinearGradient(
      begin: Alignment(-0.574, -0.819),
      end: Alignment(0.574, 0.819),
      colors: [AppPalette.headerGradientStart, AppPalette.teal600],
    ),
    feedBase: AppPalette.darkSurfaceContainer,
    feedCard: AppPalette.darkSurfaceHigh,
    badgeLike: AppPalette.badgeBlue,
    badgeLove: AppPalette.badgeRed,
    badgeHaha: AppPalette.badgeTeal,
    badgeInsightful: AppPalette.badgeAmber,
    badgeCelebrate: AppPalette.badgeGreen,
    pickerSurface: AppPalette.darkSurfaceHigh,
    pickerBorder: AppPalette.teal800,
  );

  static AppGradients of(Brightness brightness) =>
      brightness == Brightness.dark ? dark : light;

  @override
  AppGradients copyWith({
    LinearGradient? brand,
    Color? feedBase,
    Color? feedCard,
    Color? badgeLike,
    Color? badgeLove,
    Color? badgeHaha,
    Color? badgeInsightful,
    Color? badgeCelebrate,
    Color? pickerSurface,
    Color? pickerBorder,
  }) => AppGradients(
    brand: brand ?? this.brand,
    feedBase: feedBase ?? this.feedBase,
    feedCard: feedCard ?? this.feedCard,
    badgeLike: badgeLike ?? this.badgeLike,
    badgeLove: badgeLove ?? this.badgeLove,
    badgeHaha: badgeHaha ?? this.badgeHaha,
    badgeInsightful: badgeInsightful ?? this.badgeInsightful,
    badgeCelebrate: badgeCelebrate ?? this.badgeCelebrate,
    pickerSurface: pickerSurface ?? this.pickerSurface,
    pickerBorder: pickerBorder ?? this.pickerBorder,
  );

  @override
  AppGradients lerp(ThemeExtension<AppGradients>? other, double t) {
    if (other is! AppGradients) return this;
    return AppGradients(
      brand: LinearGradient.lerp(brand, other.brand, t)!,
      feedBase: Color.lerp(feedBase, other.feedBase, t)!,
      feedCard: Color.lerp(feedCard, other.feedCard, t)!,
      badgeLike: Color.lerp(badgeLike, other.badgeLike, t)!,
      badgeLove: Color.lerp(badgeLove, other.badgeLove, t)!,
      badgeHaha: Color.lerp(badgeHaha, other.badgeHaha, t)!,
      badgeInsightful: Color.lerp(badgeInsightful, other.badgeInsightful, t)!,
      badgeCelebrate: Color.lerp(badgeCelebrate, other.badgeCelebrate, t)!,
      pickerSurface: Color.lerp(pickerSurface, other.pickerSurface, t)!,
      pickerBorder: Color.lerp(pickerBorder, other.pickerBorder, t)!,
    );
  }
}

extension AppGradientsX on BuildContext {
  AppGradients get gradients => Theme.of(this).extension<AppGradients>()!;
}
