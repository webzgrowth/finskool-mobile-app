import 'package:flutter/material.dart';

import '../text/text_style_factory.dart';
import '../tokens/app_palette.dart';

/// Pinned to 0 for the same reason as the ticket styles: a bare `inter()`
/// inherits Material's 0.25 letter-spacing from the ambient style, which is
/// enough to re-wrap Figma's tightest lines.
TextStyle _i(double size, double weight, double height, Color color) => inter(
  size: size,
  weight: weight,
  height: height,
  color: color,
).copyWith(letterSpacing: 0);

TextStyle _m(double size, double weight, double height, Color color) => manrope(
  size: size,
  weight: weight,
  height: height,
  color: color,
).copyWith(letterSpacing: 0);

/// Subscription Detail (and the Edit Profile cards that share its chrome),
/// read from the Final page's `1216:6806` with figma-mcp-rust. Line heights
/// are Figma's pixel values over the size.
@immutable
class SubscriptionDetailTypography
    extends ThemeExtension<SubscriptionDetailTypography> {
  const SubscriptionDetailTypography({
    required this.sectionTitle,
    required this.label,
    required this.value,
    required this.communityName,
    required this.category,
    required this.activeStatus,
    required this.buttonLabel,
    required this.helpButton,
    required this.kitTitle,
    required this.kitBody,
    required this.kitBodyBold,
    required this.kitVideoTitle,
    required this.capitalAmount,
    required this.capitalCaption,
    required this.capitalNote,
    required this.capitalNoteBold,
    required this.statsHeading,
    required this.statValue,
    required this.statLabel,
    required this.noticeTitle,
    required this.noticeBody,
    required this.noticeBodyBold,
    required this.disclaimer,
    required this.disclaimerBold,
    required this.mission,
    required this.benefit,
    required this.benefitBold,
  });

  /// "Plan Details": Manrope 700 · 16, white on the teal bar.
  final TextStyle sectionTitle;

  /// The emphasised half of a detail cell — Manrope 700 · 12 black.
  final TextStyle label;

  /// The quiet half beneath it — Inter 400 · 10.
  final TextStyle value;

  final TextStyle communityName;
  final TextStyle category;
  final TextStyle activeStatus;
  final TextStyle buttonLabel;
  final TextStyle helpButton;

  /// "Welcome Kit" — sits on the page rather than in a teal bar, underlined.
  final TextStyle kitTitle;
  final TextStyle kitBody;
  final TextStyle kitBodyBold;
  final TextStyle kitVideoTitle;
  final TextStyle capitalAmount;
  final TextStyle capitalCaption;
  final TextStyle capitalNote;
  final TextStyle capitalNoteBold;
  final TextStyle statsHeading;
  final TextStyle statValue;
  final TextStyle statLabel;
  final TextStyle noticeTitle;
  final TextStyle noticeBody;
  final TextStyle noticeBodyBold;
  final TextStyle disclaimer;
  final TextStyle disclaimerBold;
  final TextStyle mission;
  final TextStyle benefit;
  final TextStyle benefitBold;

  static final SubscriptionDetailTypography light =
      SubscriptionDetailTypography(
        sectionTitle: _m(16, 700, 22 / 16, AppPalette.white),
        label: _m(12, 700, 14 / 12, AppPalette.postTitle),
        value: _i(10, 400, 15 / 10, AppPalette.subIntroInk),
        communityName: _m(18, 700, 22.75 / 18, AppPalette.white),
        category: _i(10, 500, 12 / 10, const Color(0xFFF5F6F9)),
        activeStatus: _i(8, 400, 9.6 / 8, AppPalette.profileRenew),
        buttonLabel: _i(
          14,
          600,
          20 / 14,
          AppPalette.white,
        ).copyWith(letterSpacing: 0.2657),
        helpButton: _i(
          14,
          500,
          20 / 14,
          AppPalette.ticketHint,
        ).copyWith(letterSpacing: 0.2657),
        kitTitle: _m(20, 700, 27 / 20, AppPalette.postTitle),
        kitBody: _i(10, 400, 15 / 10, AppPalette.subIntroInk),
        kitBodyBold: _i(10, 700, 15 / 10, AppPalette.postTitle),
        kitVideoTitle: _i(10, 400, 13 / 10, AppPalette.postTitle),
        capitalAmount: _m(18, 700, 25 / 18, AppPalette.badgeTeal),
        capitalCaption: _i(10, 500, 12 / 10, AppPalette.postTitle),
        capitalNote: _i(8, 400, 10 / 8, AppPalette.subBodyInk),
        capitalNoteBold: _i(8, 700, 10 / 8, AppPalette.subBodyInk),
        statsHeading: _m(14, 700, 19 / 14, AppPalette.postTitle),
        statValue: _m(18, 700, 25 / 18, AppPalette.postTitle),
        statLabel: _i(11, 400, 13 / 11, AppPalette.postTitle),
        noticeTitle: _m(12.5, 700, 17 / 12.5, AppPalette.subRiskInk),
        noticeBody: _i(10, 400, 15 / 10, AppPalette.subRiskBody),
        noticeBodyBold: _i(10, 700, 15 / 10, AppPalette.subRiskInk),
        disclaimer: _i(12, 400, 17 / 12, AppPalette.subBodyInk),
        disclaimerBold: _i(12, 700, 17 / 12, AppPalette.subBodyInk),
        mission: _i(11.5, 600, 19 / 11.5, AppPalette.badgeTeal),
        benefit: _i(10.69, 400, 17.5 / 10.69, AppPalette.postTitle),
        benefitBold: _i(10.69, 700, 17.5 / 10.69, AppPalette.postTitle),
      );

  /// The design has no dark variant; this screen is always on a white sheet.
  static SubscriptionDetailTypography of(Brightness brightness) => light;

  @override
  SubscriptionDetailTypography copyWith() => this;

  @override
  SubscriptionDetailTypography lerp(
    ThemeExtension<SubscriptionDetailTypography>? other,
    double t,
  ) => this;
}

extension SubscriptionDetailTypographyX on BuildContext {
  SubscriptionDetailTypography get subscriptionType =>
      Theme.of(this).extension<SubscriptionDetailTypography>()!;
}
