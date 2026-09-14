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

  /// Ring behind a reaction badge in the dark-teal variant of the feed
  /// mockup (`605:16036`). The shipped design uses the per-reaction colours
  /// below instead (`605:15302`); kept because both variants exist in Figma.
  static const Color reactionRing = Color(0xFF153D3A);

  /// Per-reaction badge rings, from Figma's colourful feed variant
  /// (`605:15302`). Blue/red/green map 1:1 onto like/love/clap; the amber,
  /// teal and orange are reassigned — see `reaction_icons.dart`.
  static const Color badgeBlue = Color(0xFF388FE7);
  static const Color badgeRed = Color(0xFFF15759);
  static const Color badgeAmber = Color(0xFFFFDA56);
  static const Color badgeTeal = Color(0xFF108B8B);
  static const Color badgeGreen = Color(0xFF6DAE53);
  static const Color badgeOrange = Color(0xFFF95428);

  /// Reactions bottom sheet: near-black drag handle, the tab row's rule and
  /// the lighter rule between reactor rows.
  static const Color sheetHandle = Color(0xFF141414);
  static const Color tabDivider = Color(0xFFD9D9D9);
  static const Color rowDivider = Color(0xFFE7E7E7);

  /// Figma puts the Like glyph on a 24px `#E4E4E4` disc. Kept as a record
  /// of the measured value, but **not currently applied** — the bare icon
  /// was preferred. Restore it in `post_reaction_bar.dart` to go back.
  static const Color likeButtonSurface = Color(0xFFE4E4E4);

  /// Feed post card text colours, measured from Figma. Deliberately not the
  /// generic `onSurface`/`onSurfaceVariant` pair — the card uses near-black
  /// for its title and a warm grey for timestamps.
  static const Color postAuthor = Color(0xFF143F3D);
  static const Color postTimestamp = Color(0xFFB4B2A9);
  static const Color postTitle = Color(0xFF000000);
  static const Color postBody = Color(0xFF2D2D2D);
  static const Color postMeta = Color(0xFF7D7D91);

  ///  =================================================================
  ///  *********************** Communities *****************************
  ///  =================================================================
  /// Measured from Figma's community card (`750:1116`). The card's title,
  /// tag text and CTA fill are all `#108B8B`, which the palette already
  /// carries as [badgeTeal] / [headerGradientEnd]; the avatar ring reuses
  /// [reactionRing] (`#153D3A`). Only these four are new.

  /// The bell's unread dot, from the exported icon (`750:1626`).
  static const Color notificationDot = Color(0xFFE50000);

  /// The category line above a community title ("Long Term Investment").
  static const Color communityCategory = Color(0xFF1A1A1A);

  /// "N New Announcements" tag — green text on the same green at 10%.
  static const Color announcementGreen = Color(0xFF37C000);

  /// Tag-chip fill is this teal at 6%; the hairline border is the grey.
  static const Color communityChipTint = Color(0xFF269595);
  static const Color communityChipBorder = Color(0xFFF5F6F9);

  /// The long-press reaction picker's pill: a light grey plate with a
  /// hairline border, not the white card surface.
  static const Color pickerSurface = Color(0xFFF2F2F2);
  static const Color pickerBorder = Color(0xFFD7D7D7);

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
