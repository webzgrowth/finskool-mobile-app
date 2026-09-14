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
    required this.badgeFire,
    required this.badgeClap,
    required this.badgeVerified,
    required this.badgeWow,
    required this.pickerSurface,
    required this.pickerBorder,
  });

  final LinearGradient brand;
  final Color feedBase;
  final Color feedCard;

  /// Ring behind each badge in a post's reaction stack, per reaction.
  /// Figma's colourful feed variant gives like/love/clap directly; the
  /// other three are reassigned from the same palette.
  final Color badgeLike;
  final Color badgeLove;
  final Color badgeFire;
  final Color badgeClap;
  final Color badgeVerified;
  final Color badgeWow;

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
    badgeFire: AppPalette.badgeOrange,
    badgeClap: AppPalette.badgeGreen,
    badgeVerified: AppPalette.badgeTeal,
    badgeWow: AppPalette.badgeAmber,
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
    badgeFire: AppPalette.badgeOrange,
    badgeClap: AppPalette.badgeGreen,
    badgeVerified: AppPalette.badgeTeal,
    badgeWow: AppPalette.badgeAmber,
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
    Color? badgeFire,
    Color? badgeClap,
    Color? badgeVerified,
    Color? badgeWow,
    Color? pickerSurface,
    Color? pickerBorder,
  }) =>
      AppGradients(
        brand: brand ?? this.brand,
        feedBase: feedBase ?? this.feedBase,
        feedCard: feedCard ?? this.feedCard,
        badgeLike: badgeLike ?? this.badgeLike,
        badgeLove: badgeLove ?? this.badgeLove,
        badgeFire: badgeFire ?? this.badgeFire,
        badgeClap: badgeClap ?? this.badgeClap,
        badgeVerified: badgeVerified ?? this.badgeVerified,
        badgeWow: badgeWow ?? this.badgeWow,
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
      badgeFire: Color.lerp(badgeFire, other.badgeFire, t)!,
      badgeClap: Color.lerp(badgeClap, other.badgeClap, t)!,
      badgeVerified: Color.lerp(badgeVerified, other.badgeVerified, t)!,
      badgeWow: Color.lerp(badgeWow, other.badgeWow, t)!,
      pickerSurface: Color.lerp(pickerSurface, other.pickerSurface, t)!,
      pickerBorder: Color.lerp(pickerBorder, other.pickerBorder, t)!,
    );
  }
}

extension AppGradientsX on BuildContext {
  AppGradients get gradients => Theme.of(this).extension<AppGradients>()!;
}
