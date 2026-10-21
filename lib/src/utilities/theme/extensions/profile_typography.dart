import 'package:flutter/material.dart';

import '../text/text_style_factory.dart';
import '../tokens/app_palette.dart';

/// Figma sets no tracking on these styles, but a bare `inter()` leaves
/// `letterSpacing` unset, so a `Text` inherits Material's 0.25 from the
/// ambient style — enough to widen "Intraday Community" by ~4px. Pinned to 0.
TextStyle _i({
  required double size,
  required double weight,
  required double height,
  required Color color,
}) => inter(
  size: size,
  weight: weight,
  height: height,
  color: color,
).copyWith(letterSpacing: 0);

TextStyle _m({
  required double size,
  required double weight,
  required double height,
  required Color color,
}) => manrope(
  size: size,
  weight: weight,
  height: height,
  color: color,
).copyWith(letterSpacing: 0);

/// Profile screen type, from Figma's Profile mockup (`893:15731`).
///
/// A sibling of [CommunityTypography] rather than a reuse of it, for the
/// same reason that one is separate from [FeedTypography]: this screen's
/// scale doesn't match either surface exactly (the name is bigger than a
/// community title, row titles are smaller).
///
/// The light values are measured from the Final page; the dark set is
/// unused by the design and keeps its earlier approximations.
@immutable
class ProfileTypography extends ThemeExtension<ProfileTypography> {
  const ProfileTypography({
    required this.name,
    required this.contact,
    required this.memberSince,
    required this.sectionTitle,
    required this.rowTitle,
    required this.rowSubtitle,
    required this.badge,
    required this.statusActive,
    required this.statusExpiring,
    required this.noticeTitle,
    required this.noticeBody,
    required this.renew,
  });

  final TextStyle name;
  final TextStyle contact;
  final TextStyle memberSince;
  final TextStyle sectionTitle;
  final TextStyle rowTitle;
  final TextStyle rowSubtitle;

  /// The small count on "My tickets".
  final TextStyle badge;

  /// "Active till…" — muted, matching [rowSubtitle].
  final TextStyle statusActive;

  /// "Expires in N days" — the version that also shows a Renew pill, so it
  /// reads as needing attention rather than merely informational.
  final TextStyle statusExpiring;

  /// The amber "Changing your phone number" notice on Edit Profile.
  final TextStyle noticeTitle;
  final TextStyle noticeBody;

  /// "Renew" on the green pill.
  final TextStyle renew;

  /// Final page, frame `Profile` (`1372:1676`) — read with figma-mcp-rust, so
  /// these are exact. Line heights are Figma's pixel values over the size.
  static final ProfileTypography light = ProfileTypography(
    name: _m(
      size: 22,
      weight: 700,
      height: 30 / 22,
      color: AppPalette.badgeTeal,
    ),
    contact: _i(
      size: 12.5,
      weight: 400,
      height: 15 / 12.5,
      color: AppPalette.postTitle,
    ),
    memberSince: _i(
      size: 10.5,
      weight: 400,
      height: 13 / 10.5,
      color: AppPalette.profilePillInk,
    ),
    sectionTitle: _m(
      size: 11,
      weight: 700,
      height: 15 / 11,
      color: AppPalette.ticketChevron,
    ).copyWith(letterSpacing: 0.88),
    rowTitle: _i(
      size: 13,
      weight: 600,
      height: 18 / 13,
      color: AppPalette.ticketInk,
    ),
    rowSubtitle: _i(
      size: 11,
      weight: 400,
      height: 15 / 11,
      color: AppPalette.ticketMuted,
    ),
    badge: _i(size: 10, weight: 600, height: 1.2, color: AppPalette.white),
    statusActive: _i(
      size: 11,
      weight: 400,
      height: 15 / 11,
      color: AppPalette.ticketMuted,
    ),
    statusExpiring: _i(
      size: 11,
      weight: 400,
      height: 15 / 11,
      color: AppPalette.ticketRequired,
    ),
    noticeTitle: _i(
      size: 13,
      weight: 700,
      height: 1.35,
      color: AppPalette.noticeAmber,
    ),
    noticeBody: _i(
      size: 12.5,
      weight: 400,
      height: 1.45,
      color: AppPalette.noticeAmber,
    ),
    renew: _i(size: 11, weight: 600, height: 1.2, color: AppPalette.white),
  );

  static final ProfileTypography dark = ProfileTypography(
    name: manrope(
      size: 20,
      weight: 700,
      height: 1.3,
      color: AppPalette.teal400,
    ),
    contact: inter(
      size: 12,
      weight: 400,
      height: 1.35,
      color: AppPalette.darkOnSurfaceMuted,
    ),
    memberSince: inter(
      size: 11,
      weight: 500,
      height: 1.3,
      color: AppPalette.darkOnSurfaceMuted,
    ),
    sectionTitle: inter(
      size: 16,
      weight: 600,
      height: 1.3,
      color: AppPalette.darkOnSurface,
    ),
    rowTitle: inter(
      size: 14,
      weight: 600,
      height: 1.3,
      color: AppPalette.darkOnSurface,
    ),
    rowSubtitle: inter(
      size: 11,
      weight: 400,
      height: 1.3,
      color: AppPalette.darkOnSurfaceMuted,
    ),
    badge: inter(size: 11, weight: 700, height: 1.2, color: AppPalette.white),
    statusActive: inter(
      size: 11,
      weight: 400,
      height: 1.3,
      color: AppPalette.darkOnSurfaceMuted,
    ),
    statusExpiring: inter(
      size: 11,
      weight: 500,
      height: 1.3,
      color: AppPalette.notificationDot,
    ),
    noticeTitle: inter(
      size: 13,
      weight: 700,
      height: 1.35,
      color: AppPalette.noticeAmber,
    ),
    noticeBody: inter(
      size: 12.5,
      weight: 400,
      height: 1.45,
      color: AppPalette.noticeAmber,
    ),
    renew: inter(size: 11, weight: 600, height: 1.2, color: AppPalette.white),
  );

  static ProfileTypography of(Brightness brightness) =>
      brightness == Brightness.dark ? dark : light;

  @override
  ProfileTypography copyWith({
    TextStyle? name,
    TextStyle? contact,
    TextStyle? memberSince,
    TextStyle? sectionTitle,
    TextStyle? rowTitle,
    TextStyle? rowSubtitle,
    TextStyle? badge,
    TextStyle? statusActive,
    TextStyle? statusExpiring,
    TextStyle? noticeTitle,
    TextStyle? noticeBody,
    TextStyle? renew,
  }) => ProfileTypography(
    name: name ?? this.name,
    contact: contact ?? this.contact,
    memberSince: memberSince ?? this.memberSince,
    sectionTitle: sectionTitle ?? this.sectionTitle,
    rowTitle: rowTitle ?? this.rowTitle,
    rowSubtitle: rowSubtitle ?? this.rowSubtitle,
    badge: badge ?? this.badge,
    statusActive: statusActive ?? this.statusActive,
    statusExpiring: statusExpiring ?? this.statusExpiring,
    noticeTitle: noticeTitle ?? this.noticeTitle,
    noticeBody: noticeBody ?? this.noticeBody,
    renew: renew ?? this.renew,
  );

  @override
  ProfileTypography lerp(ThemeExtension<ProfileTypography>? other, double t) {
    if (other is! ProfileTypography) return this;
    return ProfileTypography(
      name: TextStyle.lerp(name, other.name, t)!,
      noticeTitle: TextStyle.lerp(noticeTitle, other.noticeTitle, t)!,
      noticeBody: TextStyle.lerp(noticeBody, other.noticeBody, t)!,
      renew: TextStyle.lerp(renew, other.renew, t)!,
      contact: TextStyle.lerp(contact, other.contact, t)!,
      memberSince: TextStyle.lerp(memberSince, other.memberSince, t)!,
      sectionTitle: TextStyle.lerp(sectionTitle, other.sectionTitle, t)!,
      rowTitle: TextStyle.lerp(rowTitle, other.rowTitle, t)!,
      rowSubtitle: TextStyle.lerp(rowSubtitle, other.rowSubtitle, t)!,
      badge: TextStyle.lerp(badge, other.badge, t)!,
      statusActive: TextStyle.lerp(statusActive, other.statusActive, t)!,
      statusExpiring: TextStyle.lerp(statusExpiring, other.statusExpiring, t)!,
    );
  }
}

extension ProfileTypographyX on BuildContext {
  ProfileTypography get profileType =>
      Theme.of(this).extension<ProfileTypography>()!;
}
