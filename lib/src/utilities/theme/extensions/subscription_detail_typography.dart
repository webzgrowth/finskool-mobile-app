import 'package:flutter/material.dart';

import '../text/text_style_factory.dart';
import '../tokens/app_palette.dart';

/// Subscription Detail screen type scale, derived from the Figma
/// screenshot (`Frame 2121453551`).
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
    required this.statValue,
    required this.statLabel,
    required this.noticeTitle,
    required this.noticeBody,
    required this.mission,
  });

  final TextStyle sectionTitle;
  final TextStyle label;
  final TextStyle value;
  final TextStyle communityName;
  final TextStyle category;
  final TextStyle activeStatus;
  final TextStyle buttonLabel;
  final TextStyle helpButton;

  /// "Welcome Kit" — the one heading on this screen that sits on the page
  /// rather than in a teal bar, and is underlined.
  final TextStyle kitTitle;
  final TextStyle kitBody;
  final TextStyle kitBodyBold;
  final TextStyle kitVideoTitle;
  final TextStyle capitalAmount;
  final TextStyle capitalCaption;
  final TextStyle statValue;
  final TextStyle statLabel;
  final TextStyle noticeTitle;
  final TextStyle noticeBody;
  final TextStyle mission;

  static final SubscriptionDetailTypography light =
      SubscriptionDetailTypography(
        sectionTitle: inter(
          size: 15,
          weight: 700,
          height: 1.3,
          color: AppPalette.white,
        ),
        // The label is the emphasised half of a detail cell; the value below
        // it is the quiet one — the inverse of most rows in this app. 12 is
        // the ceiling: at 13 "Amount Paid" wraps, and Figma keeps it on one
        // line.
        label: inter(
          size: 12,
          weight: 700,
          height: 1.25,
          color: AppPalette.postTitle,
        ),
        value: inter(
          size: 11,
          weight: 400,
          height: 1.3,
          color: AppPalette.subscriptionValue,
        ),
        communityName: manrope(
          size: 17,
          weight: 700,
          height: 1.25,
          color: AppPalette.white,
        ),
        category: inter(
          size: 11,
          weight: 400,
          height: 1.25,
          color: AppPalette.white,
        ),
        // Green on the pill's white fill — not white on green.
        activeStatus: inter(
          size: 11,
          weight: 600,
          height: 1.2,
          color: AppPalette.announcementGreen,
        ),
        buttonLabel: inter(
          size: 14,
          weight: 600,
          height: 1.3,
          color: AppPalette.white,
        ),
        helpButton: inter(
          size: 14,
          weight: 400,
          height: 1.3,
          color: AppPalette.postMeta,
        ),
        kitTitle: inter(
          size: 17,
          weight: 700,
          height: 1.25,
          color: AppPalette.postTitle,
        ),
        kitBody: inter(
          size: 11,
          weight: 400,
          height: 1.45,
          color: AppPalette.subscriptionValue,
        ),
        kitBodyBold: inter(
          size: 11,
          weight: 700,
          height: 1.45,
          color: AppPalette.postTitle,
        ),
        kitVideoTitle: inter(
          size: 11,
          weight: 400,
          height: 1.35,
          color: AppPalette.postTitle,
        ),
        capitalAmount: inter(
          size: 22,
          weight: 700,
          height: 1.2,
          color: AppPalette.capitalAmount,
        ),
        capitalCaption: inter(
          size: 11,
          weight: 700,
          height: 1.3,
          color: AppPalette.postTitle,
        ),
        statValue: inter(
          size: 17,
          weight: 700,
          height: 1.2,
          color: AppPalette.postTitle,
        ),
        statLabel: inter(
          size: 10,
          weight: 400,
          height: 1.3,
          color: AppPalette.subscriptionValue,
        ),
        // The colour here is a base only — `WelcomeKitNoticeCard` overrides it
        // per tone, since the three banners differ in ink as well as plate.
        noticeTitle: inter(
          size: 11,
          weight: 700,
          height: 1.35,
          color: AppPalette.postTitle,
        ),
        noticeBody: inter(
          size: 10,
          weight: 400,
          height: 1.4,
          color: AppPalette.postTitle,
        ),
        mission: inter(
          size: 11,
          weight: 600,
          height: 1.5,
          color: AppPalette.primary,
        ),
      );

  static final SubscriptionDetailTypography dark = SubscriptionDetailTypography(
    sectionTitle: inter(
      size: 15,
      weight: 700,
      height: 1.3,
      color: AppPalette.white,
    ),
    label: inter(
      size: 12,
      weight: 700,
      height: 1.25,
      color: AppPalette.darkOnSurface,
    ),
    value: inter(
      size: 11,
      weight: 400,
      height: 1.3,
      color: AppPalette.darkOnSurfaceMuted,
    ),
    communityName: manrope(
      size: 17,
      weight: 700,
      height: 1.25,
      color: AppPalette.white,
    ),
    category: inter(
      size: 11,
      weight: 400,
      height: 1.25,
      color: AppPalette.white,
    ),
    activeStatus: inter(
      size: 11,
      weight: 600,
      height: 1.2,
      color: AppPalette.announcementGreen,
    ),
    buttonLabel: inter(
      size: 14,
      weight: 600,
      height: 1.3,
      color: AppPalette.white,
    ),
    helpButton: inter(
      size: 14,
      weight: 400,
      height: 1.3,
      color: AppPalette.darkOnSurfaceMuted,
    ),
    kitTitle: inter(
      size: 17,
      weight: 700,
      height: 1.25,
      color: AppPalette.darkOnSurface,
    ),
    kitBody: inter(
      size: 11,
      weight: 400,
      height: 1.45,
      color: AppPalette.darkOnSurfaceMuted,
    ),
    kitBodyBold: inter(
      size: 11,
      weight: 700,
      height: 1.45,
      color: AppPalette.darkOnSurface,
    ),
    kitVideoTitle: inter(
      size: 11,
      weight: 400,
      height: 1.35,
      color: AppPalette.darkOnSurface,
    ),
    capitalAmount: inter(
      size: 22,
      weight: 700,
      height: 1.2,
      color: AppPalette.capitalAmount,
    ),
    capitalCaption: inter(
      size: 11,
      weight: 700,
      height: 1.3,
      color: AppPalette.darkOnSurface,
    ),
    statValue: inter(
      size: 17,
      weight: 700,
      height: 1.2,
      color: AppPalette.darkOnSurface,
    ),
    statLabel: inter(
      size: 10,
      weight: 400,
      height: 1.3,
      color: AppPalette.darkOnSurfaceMuted,
    ),
    // The notice banners keep their own tinted inks in both themes — the
    // plates they sit on are the same tints either way.
    // The colour here is a base only — `WelcomeKitNoticeCard` overrides it
    // per tone, since the three banners differ in ink as well as plate.
    noticeTitle: inter(
      size: 11,
      weight: 700,
      height: 1.35,
      color: AppPalette.postTitle,
    ),
    noticeBody: inter(
      size: 10,
      weight: 400,
      height: 1.4,
      color: AppPalette.postTitle,
    ),
    mission: inter(
      size: 11,
      weight: 600,
      height: 1.5,
      color: AppPalette.primary,
    ),
  );

  static SubscriptionDetailTypography of(Brightness brightness) =>
      brightness == Brightness.dark ? dark : light;

  @override
  SubscriptionDetailTypography copyWith({
    TextStyle? sectionTitle,
    TextStyle? label,
    TextStyle? value,
    TextStyle? communityName,
    TextStyle? category,
    TextStyle? activeStatus,
    TextStyle? buttonLabel,
    TextStyle? helpButton,
    TextStyle? kitTitle,
    TextStyle? kitBody,
    TextStyle? kitBodyBold,
    TextStyle? kitVideoTitle,
    TextStyle? capitalAmount,
    TextStyle? capitalCaption,
    TextStyle? statValue,
    TextStyle? statLabel,
    TextStyle? noticeTitle,
    TextStyle? noticeBody,
    TextStyle? mission,
  }) => SubscriptionDetailTypography(
    sectionTitle: sectionTitle ?? this.sectionTitle,
    label: label ?? this.label,
    value: value ?? this.value,
    communityName: communityName ?? this.communityName,
    category: category ?? this.category,
    activeStatus: activeStatus ?? this.activeStatus,
    buttonLabel: buttonLabel ?? this.buttonLabel,
    helpButton: helpButton ?? this.helpButton,
    kitTitle: kitTitle ?? this.kitTitle,
    kitBody: kitBody ?? this.kitBody,
    kitBodyBold: kitBodyBold ?? this.kitBodyBold,
    kitVideoTitle: kitVideoTitle ?? this.kitVideoTitle,
    capitalAmount: capitalAmount ?? this.capitalAmount,
    capitalCaption: capitalCaption ?? this.capitalCaption,
    statValue: statValue ?? this.statValue,
    statLabel: statLabel ?? this.statLabel,
    noticeTitle: noticeTitle ?? this.noticeTitle,
    noticeBody: noticeBody ?? this.noticeBody,
    mission: mission ?? this.mission,
  );

  @override
  SubscriptionDetailTypography lerp(
    ThemeExtension<SubscriptionDetailTypography>? other,
    double t,
  ) {
    if (other is! SubscriptionDetailTypography) return this;
    return SubscriptionDetailTypography(
      sectionTitle: TextStyle.lerp(sectionTitle, other.sectionTitle, t)!,
      label: TextStyle.lerp(label, other.label, t)!,
      value: TextStyle.lerp(value, other.value, t)!,
      communityName: TextStyle.lerp(communityName, other.communityName, t)!,
      category: TextStyle.lerp(category, other.category, t)!,
      activeStatus: TextStyle.lerp(activeStatus, other.activeStatus, t)!,
      buttonLabel: TextStyle.lerp(buttonLabel, other.buttonLabel, t)!,
      helpButton: TextStyle.lerp(helpButton, other.helpButton, t)!,
      kitTitle: TextStyle.lerp(kitTitle, other.kitTitle, t)!,
      kitBody: TextStyle.lerp(kitBody, other.kitBody, t)!,
      kitBodyBold: TextStyle.lerp(kitBodyBold, other.kitBodyBold, t)!,
      kitVideoTitle: TextStyle.lerp(kitVideoTitle, other.kitVideoTitle, t)!,
      capitalAmount: TextStyle.lerp(capitalAmount, other.capitalAmount, t)!,
      capitalCaption: TextStyle.lerp(capitalCaption, other.capitalCaption, t)!,
      statValue: TextStyle.lerp(statValue, other.statValue, t)!,
      statLabel: TextStyle.lerp(statLabel, other.statLabel, t)!,
      noticeTitle: TextStyle.lerp(noticeTitle, other.noticeTitle, t)!,
      noticeBody: TextStyle.lerp(noticeBody, other.noticeBody, t)!,
      mission: TextStyle.lerp(mission, other.mission, t)!,
    );
  }
}

extension SubscriptionDetailTypographyX on BuildContext {
  SubscriptionDetailTypography get subscriptionType =>
      Theme.of(this).extension<SubscriptionDetailTypography>()!;
}
