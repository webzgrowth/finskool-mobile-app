import 'package:flutter/material.dart';

/// Raw brand colour values. No semantics here — map these onto meaning in
/// `color_schemes/`, and read them in widgets via `Theme.of(context)`.
class AppPalette {
  AppPalette._();

  // Brand (from Figma)
  static const Color primary = Color(0xFF1E9299);
  static const Color secondary = Color(0xFF164544);
  static const Color feedBase = Color(0xFFE7F3F3);

  // Auth header gradient — exact 3-stop values from the Figma node
  // (linear-gradient(145deg, #174645 0%, #154443 19.5%, #108B8B 47.6%)).
  static const Color headerGradientStart = Color(0xFF174645);
  static const Color headerGradientMid = Color(0xFF154443);
  static const Color headerGradientEnd = Color(0xFF108B8B);

  // Card title color used on the password-reset flow's screens
  // ("Reset password", "New password" etc.) — exact Figma value, distinct
  // from the theme's `secondary` token.
  static const Color cardTitle = Color(0xFF153D3A);

  // Teal ramp
  static const Color teal50 = Color(0xFFF4FAFA);
  static const Color teal100 = Color(0xFFE7F3F3);
  static const Color teal200 = Color(0xFFCDE8E8);
  static const Color teal300 = Color(0xFFA5D6D6);
  static const Color teal400 = Color(0xFF5FC9CF);
  static const Color teal600 = Color(0xFF2F7F86);
  static const Color teal800 = Color(0xFF134E52);
  static const Color teal900 = Color(0xFF06322F);

  // Neutrals
  static const Color white = Color(0xFFFFFFFF);
  static const Color ink = Color(0xFF0F1F1F);
  static const Color inkMuted = Color(0xFF4A5B5B);
  static const Color outline = Color(0xFF7A8C8C);
  static const Color outlineSoft = Color(0xFFC3D6D6);

  // Dark surfaces
  static const Color darkSurface = Color(0xFF0E1616);
  static const Color darkSurfaceLow = Color(0xFF141D1D);
  static const Color darkSurfaceContainer = Color(0xFF182121);
  static const Color darkSurfaceHigh = Color(0xFF232C2C);
  static const Color darkOnSurface = Color(0xFFE1EDED);
  static const Color darkOnSurfaceMuted = Color(0xFFB4C6C6);

  // Status
  static const Color error = Color(0xFFB3261E);
  static const Color errorContainer = Color(0xFFF9DEDC);
  static const Color errorDark = Color(0xFFF2B8B5);
  static const Color success = Color(0xFF2E7D5B);
  static const Color warning = Color(0xFFB26A00);
}
