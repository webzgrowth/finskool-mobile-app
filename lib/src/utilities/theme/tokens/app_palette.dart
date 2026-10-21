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
  /// (`605:15302`). Blue and red map 1:1 onto like/love and teal onto haha
  /// (Figma's laughing disc); amber, green and orange are reassigned to wow,
  /// sad and angry — see `reaction_icons.dart`.
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

  /// The 24px disc behind the Like glyph, per Figma's `Group 1739329635`.
  /// Applied in `post_reaction_bar.dart`.
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

  ///  =================================================================
  ///  ************************* Profile *******************************
  ///  =================================================================
  /// Read from the user's reference screenshot (not yet Figma-verified —
  /// see CLAUDE.md "Profile"). Neutral grey, deliberately not one of the
  /// existing teal-tinted `surfaceContainer*` slots — those don't match
  /// what this screen actually shows.
  static const Color profileCardFill = Color(0xFFF5F5F7);

  ///  =================================================================
  ///  ******************* Subscription Detail *************************
  ///  =================================================================
  /// Every filled surface on this screen — section headers, detail icon
  /// discs, the card scrim, the Download Invoice button — is [primary].
  /// An earlier pass invented a darker teal for them; keep them on the
  /// brand colour.
  ///
  /// Section body fill: near-white, a shade off the white sheet behind it.
  static const Color subscriptionBody = Color(0xFFF8FAFA);
  static const Color subscriptionBorder = Color(0xFFE6EDED);
  static const Color subscriptionDivider = Color(0xFFE3EAEA);

  /// The grey value under each bold detail label.
  static const Color subscriptionValue = Color(0xFF5C5C5C);

  ///  =================================================================
  ///  ********************** Edit Profile *****************************
  ///  =================================================================
  /// The "Changing your phone number" notice — one amber for both the
  /// icon disc and the copy, on a cream surface.
  static const Color noticeAmber = Color(0xFFA87C21);
  static const Color noticeAmberSurface = Color(0xFFFBF3E4);

  /// "Discard Changes" — a brighter red than [error], which is the dark
  /// Material scheme colour used for field-level validation text.
  static const Color destructive = Color(0xFFE04B4B);

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

  // ── Welcome Kit (Subscription Detail) ──────────────────────────────
  // Screenshot-derived, like the rest of this screen — Figma was not
  // reachable when these were sampled. Re-verify against the file.

  /// The pale mint plate behind the recommended-capital figure.
  static const Color capitalHighlight = Color(0xFFEAF5F2);
  static const Color capitalAmount = Color(0xFF1E9299);

  /// Stat tiles sit on white inside the card's off-white body, so they
  /// need their own hairline to read as tiles.
  static const Color statTileBorder = Color(0xFFE2E8E8);

  /// The three notice banners, each a tinted plate + a matching hairline
  /// and a title in the stronger shade.
  static const Color noticeInfoSurface = Color(0xFFEFF6FF);
  static const Color noticeInfoBorder = Color(0xFFBFD9F5);
  static const Color noticeInfoInk = Color(0xFF2B6CB0);

  static const Color noticeWarnSurface = Color(0xFFFFF8E6);
  static const Color noticeWarnBorder = Color(0xFFF0D79B);
  static const Color noticeWarnInk = Color(0xFF9A6B00);

  static const Color noticeDangerSurface = Color(0xFFFEF0EF);
  static const Color noticeDangerBorder = Color(0xFFF3C0BC);
  static const Color noticeDangerInk = Color(0xFFD4342A);

  // ── Support tickets ────────────────────────────────────────────────
  // Read from Figma's **Final** page (file FINSKOOL App, frames
  // `Profile / My Tickets` and `Profile / Raise a Ticket`) with
  // figma-mcp-rust — exact, not sampled. An earlier pass was built from the
  // *working* `tickets` page (a cream canvas, lime accents, a dark-teal
  // button) and was thrown away: the final design is a white sheet over a
  // short teal hero with `#108B8B` actions and grey `#F6F6F6` cards.
  //
  // `#108B8B` is `badgeTeal` and `#153D3A` is `reactionRing`; both are reused
  // rather than re-declared.

  static const Color ticketCard = Color(0xFFF6F6F6);
  static const Color ticketInk = Color(0xFF12201F);

  /// Field and chip text (`#1A1A1A`), a hair softer than true black.
  static const Color ticketInkSoft = Color(0xFF1A1A1A);

  /// Ticket numbers, meta lines, summary labels.
  static const Color ticketMuted = Color(0xFF7A7A74);

  /// Subtitles, hints, placeholders and the dashed upload box's helper copy.
  static const Color ticketHint = Color(0xFF888780);
  static const Color ticketFootnote = Color(0xFF8A8A85);
  static const Color ticketPlaceholder = Color(0xFF9A9A94);
  static const Color ticketTile = Color(0xFFE6F2F0);

  /// A pending stepper disc, an unselected star.
  static const Color ticketPending = Color(0xFFEAE7DE);
  static const Color ticketPendingLine = Color(0xFFE0DED6);

  /// The centred "Status changed…" pill: `#7D7D91` at 20%, with `#6B6B6B` text.
  static const Color ticketSystemSurface = Color(0x337D7D91);
  static const Color ticketSystemInk = Color(0xFF6B6B6B);

  static const Color ticketCardBorder = Color(0x0F153D3A);
  static const Color ticketDivider = Color(0x14153D3A);
  static const Color ticketOutline = Color(0x40153D3A);
  static const Color ticketChevron = Color(0x99153D3A);

  /// Input border `#7D7D91` at 60%; an unselected filter chip's at 50%.
  static const Color ticketFieldBorder = Color(0x997D7D91);
  static const Color ticketChipBorder = Color(0x807D7D91);
  static const Color ticketShadow = Color(0x0F153D3A);

  static const Color ticketRed = Color(0xFFC62828);
  static const Color ticketRequired = Color(0xFFE10200);
  static const Color ticketPendingRed = Color(0xFFFF383C);
  static const Color ticketOpenSurface = Color(0x1AFE0000);
  static const Color ticketProgressSurface = Color(0xFFFDF3E0);
  static const Color ticketProgressInk = Color(0xFF8A5A0B);
  static const Color ticketResolvedSurface = Color(0xFFE3F6E8);
  static const Color ticketResolvedInk = Color(0xFF1F8A3B);

  /// `#108B8B` at 10% behind a file's type tag, and the success halo.
  static const Color ticketTagSurface = Color(0x1A108B8B);

  /// The success disc inside the halo.
  static const Color ticketSuccessDisc = Color(0xFFB7DCDC);

  /// The support bubble's hairline, and the file chip inside a member's
  /// bubble (white at 12% — measured: it lands on `#2D9999` over `#108B8B`).
  static const Color ticketBubbleBorder = Color(0xFFE4E7E7);
  static const Color ticketChipOnDark = Color(0x1FFFFFFF);

  // Status
  static const Color error = Color(0xFFB3261E);
  static const Color errorContainer = Color(0xFFF9DEDC);
  static const Color errorDark = Color(0xFFF2B8B5);
  static const Color success = Color(0xFF2E7D5B);
  static const Color warning = Color(0xFFB26A00);
}
