import 'package:flutter/material.dart';

import '../text/text_style_factory.dart';
import '../tokens/app_palette.dart';

/// Profile screen type, from Figma's Profile mockup (`893:15731`).
///
/// A sibling of [CommunityTypography] rather than a reuse of it, for the
/// same reason that one is separate from [FeedTypography]: this screen's
/// scale doesn't match either surface exactly (the name is bigger than a
/// community title, row titles are smaller).
///
/// **Every size/weight below is a best-guess** built on colors already
/// measured for Communities (`badgeTeal`, `postTitle`, `postMeta`) — Figma
/// access was rate-limited while this was written (see CLAUDE.md
/// "Profile" and the plan file). Swap each value for the real measurement
/// once available; nothing here should be treated as final.
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

  static final ProfileTypography light = ProfileTypography(
    name: manrope(size: 20, weight: 700, height: 1.3, color: AppPalette.badgeTeal),
    contact:
        inter(size: 12, weight: 400, height: 1.35, color: AppPalette.postMeta),
    memberSince:
        inter(size: 11, weight: 500, height: 1.3, color: AppPalette.postMeta),
    sectionTitle:
        inter(size: 16, weight: 600, height: 1.3, color: AppPalette.postTitle),
    rowTitle:
        inter(size: 14, weight: 600, height: 1.3, color: AppPalette.postTitle),
    rowSubtitle:
        inter(size: 11, weight: 400, height: 1.3, color: AppPalette.postMeta),
    badge: inter(size: 11, weight: 700, height: 1.2, color: AppPalette.white),
    statusActive:
        inter(size: 11, weight: 400, height: 1.3, color: AppPalette.postMeta),
    statusExpiring: inter(
        size: 11, weight: 500, height: 1.3, color: AppPalette.notificationDot),
  );

  static final ProfileTypography dark = ProfileTypography(
    name: manrope(size: 20, weight: 700, height: 1.3, color: AppPalette.teal400),
    contact: inter(
        size: 12, weight: 400, height: 1.35, color: AppPalette.darkOnSurfaceMuted),
    memberSince: inter(
        size: 11, weight: 500, height: 1.3, color: AppPalette.darkOnSurfaceMuted),
    sectionTitle: inter(
        size: 16, weight: 600, height: 1.3, color: AppPalette.darkOnSurface),
    rowTitle: inter(
        size: 14, weight: 600, height: 1.3, color: AppPalette.darkOnSurface),
    rowSubtitle: inter(
        size: 11, weight: 400, height: 1.3, color: AppPalette.darkOnSurfaceMuted),
    badge: inter(size: 11, weight: 700, height: 1.2, color: AppPalette.white),
    statusActive: inter(
        size: 11, weight: 400, height: 1.3, color: AppPalette.darkOnSurfaceMuted),
    statusExpiring: inter(
        size: 11, weight: 500, height: 1.3, color: AppPalette.notificationDot),
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
  }) =>
      ProfileTypography(
        name: name ?? this.name,
        contact: contact ?? this.contact,
        memberSince: memberSince ?? this.memberSince,
        sectionTitle: sectionTitle ?? this.sectionTitle,
        rowTitle: rowTitle ?? this.rowTitle,
        rowSubtitle: rowSubtitle ?? this.rowSubtitle,
        badge: badge ?? this.badge,
        statusActive: statusActive ?? this.statusActive,
        statusExpiring: statusExpiring ?? this.statusExpiring,
      );

  @override
  ProfileTypography lerp(ThemeExtension<ProfileTypography>? other, double t) {
    if (other is! ProfileTypography) return this;
    return ProfileTypography(
      name: TextStyle.lerp(name, other.name, t)!,
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
