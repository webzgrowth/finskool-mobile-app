import 'package:flutter/material.dart';

import '../tokens/app_palette.dart';

/// Light scheme. `surfaceContainer` is the Figma "feed base" (#E7F3F3).
const ColorScheme lightScheme = ColorScheme(
  brightness: Brightness.light,
  primary: AppPalette.primary,
  onPrimary: AppPalette.white,
  primaryContainer: AppPalette.teal200,
  onPrimaryContainer: AppPalette.teal900,
  secondary: AppPalette.secondary,
  onSecondary: AppPalette.white,
  secondaryContainer: Color(0xFFD3E6E4),
  onSecondaryContainer: Color(0xFF0B2A29),
  tertiary: AppPalette.teal600,
  onTertiary: AppPalette.white,
  tertiaryContainer: AppPalette.teal100,
  onTertiaryContainer: AppPalette.teal900,
  error: AppPalette.error,
  onError: AppPalette.white,
  errorContainer: AppPalette.errorContainer,
  onErrorContainer: Color(0xFF410E0B),
  surface: AppPalette.white,
  onSurface: AppPalette.ink,
  onSurfaceVariant: AppPalette.inkMuted,
  surfaceContainerLowest: AppPalette.white,
  surfaceContainerLow: AppPalette.teal50,
  surfaceContainer: AppPalette.feedBase,
  surfaceContainerHigh: Color(0xFFDCEDED),
  surfaceContainerHighest: Color(0xFFD0E6E6),
  outline: AppPalette.outline,
  outlineVariant: AppPalette.outlineSoft,
  inverseSurface: AppPalette.secondary,
  onInverseSurface: AppPalette.feedBase,
  inversePrimary: AppPalette.teal400,
  shadow: Color(0xFF000000),
  scrim: Color(0xFF000000),
);
