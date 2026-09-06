import 'dart:ui';

/// Font families and variable-axis helpers.
///
/// Both bundled fonts are variable, so a weight is only applied if it is
/// passed as a `wght` axis value — `fontWeight` alone does not move the axis.
class AppTypography {
  AppTypography._();

  static const String heading = 'Manrope';
  static const String body = 'Inter';

  /// Manrope exposes a single `wght` axis (200–800).
  static List<FontVariation> heavy(double weight) => [
        FontVariation('wght', weight),
      ];

  /// Inter exposes `opsz` (14–32) alongside `wght`. Below 14 the optical size
  /// clamps to 14, which is what keeps 10px body text legible.
  static List<FontVariation> text(double weight, double size) => [
        FontVariation('wght', weight),
        FontVariation('opsz', size.clamp(14.0, 32.0)),
      ];
}
