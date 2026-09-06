import 'package:flutter/material.dart';

import 'text_style_factory.dart';

/// Type scale matching the Figma screens: Manrope is reserved for the big
/// hero headline and section titles (h1 28, headlineMedium/Small).
/// Everything else — field labels, buttons, tab labels, body, hints — is
/// Inter, per the actual screen designs (not just the abstract size guide).
class AppTextTheme {
  AppTextTheme._();

  static TextTheme build(ColorScheme cs) {
    final ink = cs.onSurface;
    final muted = cs.onSurfaceVariant;

    return TextTheme(
      displayLarge: manrope(size: 40, weight: 800, height: 1.15, color: ink),
      displayMedium: manrope(size: 34, weight: 800, height: 1.18, color: ink),
      displaySmall: manrope(size: 30, weight: 700, height: 1.20, color: ink),

      // h1
      headlineLarge: manrope(size: 28, weight: 700, height: 1.25, color: ink),
      headlineMedium: manrope(size: 22, weight: 700, height: 1.27, color: ink),
      headlineSmall: manrope(size: 18, weight: 600, height: 1.30, color: ink),

      // titles: buttons, tab labels, field labels — Inter per the screens
      titleLarge: inter(size: 16, weight: 600, height: 1.35, color: ink),
      titleMedium: inter(size: 14, weight: 600, height: 1.40, color: ink),
      titleSmall: inter(size: 12, weight: 500, height: 1.40, color: ink),

      // body
      bodyLarge: inter(size: 14, weight: 400, height: 1.50, color: ink),
      bodyMedium: inter(size: 12, weight: 400, height: 1.50, color: ink),
      bodySmall: inter(size: 10, weight: 400, height: 1.60, color: muted),

      labelLarge: inter(size: 12, weight: 600, height: 1.20, color: ink),
      labelMedium: inter(size: 11, weight: 500, height: 1.20, color: muted),
      labelSmall: inter(size: 10, weight: 500, height: 1.20, color: muted),
    );
  }
}
