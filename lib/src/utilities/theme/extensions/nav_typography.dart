import 'package:flutter/material.dart';

import '../text/text_style_factory.dart';
import '../tokens/app_palette.dart';

/// The bottom navigation's labels — Final page `iPhone 16 - 12` (`605:15302`),
/// Inter Medium 10 on an 11.67 line. Active is the brand `#108B8B`, inactive
/// `#888880`. Letter-spacing is pinned to 0 so the ambient 0.25 can't widen
/// "Communities" past its 63px slot.
@immutable
class NavTypography extends ThemeExtension<NavTypography> {
  const NavTypography({required this.active, required this.inactive});

  final TextStyle active;
  final TextStyle inactive;

  static TextStyle _label(Color color) => inter(
    size: 10,
    weight: 500,
    height: 11.67 / 10,
    color: color,
  ).copyWith(letterSpacing: 0);

  static final NavTypography light = NavTypography(
    active: _label(AppPalette.badgeTeal),
    inactive: _label(AppPalette.navInactive),
  );

  static NavTypography of(Brightness brightness) => light;

  @override
  NavTypography copyWith({TextStyle? active, TextStyle? inactive}) =>
      NavTypography(
        active: active ?? this.active,
        inactive: inactive ?? this.inactive,
      );

  @override
  NavTypography lerp(ThemeExtension<NavTypography>? other, double t) {
    if (other is! NavTypography) return this;
    return NavTypography(
      active: TextStyle.lerp(active, other.active, t)!,
      inactive: TextStyle.lerp(inactive, other.inactive, t)!,
    );
  }
}

extension NavTypographyX on BuildContext {
  NavTypography get navType => Theme.of(this).extension<NavTypography>()!;
}
