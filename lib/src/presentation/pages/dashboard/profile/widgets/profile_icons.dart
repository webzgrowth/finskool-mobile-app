import 'package:flutter/material.dart';

/// Icon glyphs for the Profile screen's menu rows.
///
/// **Material stand-ins, not the design.** Every row in Figma uses an
/// exported svgrepo.com icon (camera, gift, education, user, star, tickets,
/// support, share, document, rupee); none have been exported yet — Figma
/// access was rate-limited while this screen was built (see CLAUDE.md
/// "Profile"). `ProfileMenuRow.icon` takes a plain `Widget`, so swapping any
/// entry below for `SvgPicture.asset('assets/icons/<name>.svg')` is a
/// one-line change once the export lands — no need to touch the rows
/// themselves. The Figma node id for each source glyph is recorded so the
/// export is unambiguous.
class ProfileIcons {
  ProfileIcons._();

  /// `camera_svgrepo.com`, `893:16148` — the avatar edit badge.
  static const IconData camera = Icons.photo_camera_outlined;

  /// `893:16233` (Academy subscription row).
  static const IconData chart = Icons.show_chart_rounded;

  /// `gift_svgrepo.com`, `893:16180` (Welcome kits row's leading glyph).
  static const IconData gift = Icons.card_giftcard_outlined;

  /// `education_svgrepo.com`, `893:16233`.
  static const IconData education = Icons.school_outlined;

  /// `user-rounded_svgrepo.com`, `893:16238` (Edit Profile row).
  static const IconData user = Icons.person_outline_rounded;

  /// `star-sharp_svgrepo.com`, `893:16255` (Give feedback row).
  static const IconData star = Icons.star_outline_rounded;

  /// `tickets-line_svgrepo.com`, `893:16275` (My tickets row).
  static const IconData tickets = Icons.confirmation_number_outlined;

  /// `support_svgrepo.com`, `893:16279` (Help & support row).
  static const IconData support = Icons.support_agent_outlined;

  /// `893:16167` — the Notifications row's icon box exists in the cached
  /// dump but its inner glyph (`Frame 2121453514`) wasn't captured with a
  /// named svg; a bell is the closest sane guess pending export.
  static const IconData notifications = Icons.notifications_outlined;

  /// `share_svgrepo.com`, `893:16284` (Share the app row).
  static const IconData share = Icons.ios_share_rounded;

  /// `document-1_svgrepo.com`, `893:16296` (Terms & privacy policy row).
  static const IconData document = Icons.description_outlined;

  /// `rupee_svgrepo.com`, `893:16301` (About & SEBI info row).
  static const IconData rupee = Icons.currency_rupee_rounded;
}
