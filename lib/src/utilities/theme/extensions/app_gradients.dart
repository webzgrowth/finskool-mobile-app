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
  });

  final LinearGradient brand;
  final Color feedBase;
  final Color feedCard;

  static const AppGradients light = AppGradients(
    brand: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [AppPalette.secondary, AppPalette.primary],
    ),
    feedBase: AppPalette.feedBase,
    feedCard: AppPalette.white,
  );

  static const AppGradients dark = AppGradients(
    brand: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [AppPalette.secondary, AppPalette.teal600],
    ),
    feedBase: AppPalette.darkSurfaceContainer,
    feedCard: AppPalette.darkSurfaceHigh,
  );

  static AppGradients of(Brightness brightness) =>
      brightness == Brightness.dark ? dark : light;

  @override
  AppGradients copyWith({
    LinearGradient? brand,
    Color? feedBase,
    Color? feedCard,
  }) =>
      AppGradients(
        brand: brand ?? this.brand,
        feedBase: feedBase ?? this.feedBase,
        feedCard: feedCard ?? this.feedCard,
      );

  @override
  AppGradients lerp(ThemeExtension<AppGradients>? other, double t) {
    if (other is! AppGradients) return this;
    return AppGradients(
      brand: LinearGradient.lerp(brand, other.brand, t)!,
      feedBase: Color.lerp(feedBase, other.feedBase, t)!,
      feedCard: Color.lerp(feedCard, other.feedCard, t)!,
    );
  }
}

extension AppGradientsX on BuildContext {
  AppGradients get gradients => Theme.of(this).extension<AppGradients>()!;
}
