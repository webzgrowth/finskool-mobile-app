import 'package:flutter/material.dart';

import '../tokens/app_palette.dart';

/// Dark scheme. Brand primary is lightened to `teal400` — #1E9299 does not
/// reach adequate contrast against dark surfaces.
const ColorScheme darkScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: AppPalette.teal400,
  onPrimary: Color(0xFF00363A),
  primaryContainer: AppPalette.teal800,
  onPrimaryContainer: Color(0xFFB6ECEF),
  secondary: Color(0xFF9FCFCC),
  onSecondary: Color(0xFF0B2A29),
  secondaryContainer: AppPalette.secondary,
  onSecondaryContainer: Color(0xFFD3E6E4),
  tertiary: AppPalette.teal300,
  onTertiary: Color(0xFF06322F),
  tertiaryContainer: AppPalette.teal600,
  onTertiaryContainer: AppPalette.teal100,
  error: AppPalette.errorDark,
  onError: Color(0xFF601410),
  errorContainer: Color(0xFF8C1D18),
  onErrorContainer: AppPalette.errorContainer,
  surface: AppPalette.darkSurface,
  onSurface: AppPalette.darkOnSurface,
  onSurfaceVariant: AppPalette.darkOnSurfaceMuted,
  surfaceContainerLowest: Color(0xFF080F0F),
  surfaceContainerLow: AppPalette.darkSurfaceLow,
  surfaceContainer: AppPalette.darkSurfaceContainer,
  surfaceContainerHigh: AppPalette.darkSurfaceHigh,
  surfaceContainerHighest: Color(0xFF2E3838),
  outline: Color(0xFF849797),
  outlineVariant: Color(0xFF3F4C4C),
  inverseSurface: AppPalette.darkOnSurface,
  onInverseSurface: AppPalette.darkSurface,
  inversePrimary: AppPalette.primary,
  shadow: Color(0xFF000000),
  scrim: Color(0xFF000000),
);
