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
  });

  final TextStyle sectionTitle;
  final TextStyle label;
  final TextStyle value;
  final TextStyle communityName;
  final TextStyle category;
  final TextStyle activeStatus;
  final TextStyle buttonLabel;
  final TextStyle helpButton;

  static final SubscriptionDetailTypography light =
      SubscriptionDetailTypography(
    sectionTitle:
        inter(size: 15, weight: 700, height: 1.3, color: AppPalette.white),
    // The label is the emphasised half of a detail cell; the value below
    // it is the quiet one — the inverse of most rows in this app. 12 is
    // the ceiling: at 13 "Amount Paid" wraps, and Figma keeps it on one
    // line.
    label: inter(
        size: 12, weight: 700, height: 1.25, color: AppPalette.postTitle),
    value: inter(
        size: 11,
        weight: 400,
        height: 1.3,
        color: AppPalette.subscriptionValue),
    communityName: manrope(
        size: 17, weight: 700, height: 1.25, color: AppPalette.white),
    category: inter(
        size: 11, weight: 400, height: 1.25, color: AppPalette.white),
    // Green on the pill's white fill — not white on green.
    activeStatus: inter(
        size: 11,
        weight: 600,
        height: 1.2,
        color: AppPalette.announcementGreen),
    buttonLabel:
        inter(size: 14, weight: 600, height: 1.3, color: AppPalette.white),
    helpButton: inter(
        size: 14, weight: 400, height: 1.3, color: AppPalette.postMeta),
  );

  static final SubscriptionDetailTypography dark =
      SubscriptionDetailTypography(
    sectionTitle: inter(
        size: 15, weight: 700, height: 1.3, color: AppPalette.white),
    label: inter(
        size: 12, weight: 700, height: 1.25, color: AppPalette.darkOnSurface),
    value: inter(
        size: 11,
        weight: 400,
        height: 1.3,
        color: AppPalette.darkOnSurfaceMuted),
    communityName: manrope(
        size: 17, weight: 700, height: 1.25, color: AppPalette.white),
    category: inter(
        size: 11, weight: 400, height: 1.25, color: AppPalette.white),
    activeStatus: inter(
        size: 11,
        weight: 600,
        height: 1.2,
        color: AppPalette.announcementGreen),
    buttonLabel: inter(
        size: 14, weight: 600, height: 1.3, color: AppPalette.white),
    helpButton: inter(
        size: 14,
        weight: 400,
        height: 1.3,
        color: AppPalette.darkOnSurfaceMuted),
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
  }) =>
      SubscriptionDetailTypography(
        sectionTitle: sectionTitle ?? this.sectionTitle,
        label: label ?? this.label,
        value: value ?? this.value,
        communityName: communityName ?? this.communityName,
        category: category ?? this.category,
        activeStatus: activeStatus ?? this.activeStatus,
        buttonLabel: buttonLabel ?? this.buttonLabel,
        helpButton: helpButton ?? this.helpButton,
      );

  @override
  SubscriptionDetailTypography lerp(
      ThemeExtension<SubscriptionDetailTypography>? other, double t) {
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
    );
  }
}

extension SubscriptionDetailTypographyX on BuildContext {
  SubscriptionDetailTypography get subscriptionType =>
      Theme.of(this).extension<SubscriptionDetailTypography>()!;
}
