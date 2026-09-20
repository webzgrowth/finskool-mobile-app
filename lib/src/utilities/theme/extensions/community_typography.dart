import 'package:flutter/material.dart';

import '../text/text_style_factory.dart';
import '../tokens/app_palette.dart';

/// Community card type, measured from Figma's card (`750:1116`).
///
/// A sibling of [FeedTypography] rather than an addition to it: the two
/// surfaces size and colour their text differently (the community title is
/// Manrope Bold **18** in teal, the feed title Manrope Bold **14** in
/// near-black), and keeping them apart means a change to one can't silently
/// reskin the other.
@immutable
class CommunityTypography extends ThemeExtension<CommunityTypography> {
  const CommunityTypography({
    required this.category,
    required this.title,
    required this.announcement,
    required this.description,
    required this.descriptionBold,
    required this.tagChip,
    required this.cta,
    required this.memberCount,
    required this.price,
    required this.pricePeriod,
    required this.planLabel,
    required this.benefit,
    required this.benefitBold,
  });

  final TextStyle category;
  final TextStyle title;
  final TextStyle announcement;
  final TextStyle description;

  /// The bold run inside a description — see `comman/rich_text_spans.dart`.
  final TextStyle descriptionBold;
  final TextStyle tagChip;
  final TextStyle cta;
  final TextStyle memberCount;
  final TextStyle price;
  final TextStyle pricePeriod;
  final TextStyle planLabel;
  final TextStyle benefit;

  /// The emphasised figure in a benefit line ("**12 trades per month**").
  final TextStyle benefitBold;

  static final CommunityTypography light = CommunityTypography(
    // Inter 500 · 10 · #1A1A1A
    category: inter(
        size: 10, weight: 500, height: 1.2, color: AppPalette.communityCategory),
    // Manrope 700 · 18 · 22.75px · #108B8B
    title:
        manrope(size: 18, weight: 700, height: 1.264, color: AppPalette.badgeTeal),
    // Inter 500 · 10 · #37C000
    announcement: inter(
        size: 10, weight: 500, height: 1.2, color: AppPalette.announcementGreen),
    // Inter 400 · 12 · 16.373px · #000000
    description:
        inter(size: 12, weight: 400, height: 1.364, color: AppPalette.postTitle),
    descriptionBold:
        inter(size: 12, weight: 700, height: 1.364, color: AppPalette.postTitle),
    // Inter 400 · 10 · 12.642px · #108B8B
    tagChip:
        inter(size: 10, weight: 400, height: 1.264, color: AppPalette.badgeTeal),
    // Inter 600 · 14 · 19.929px · white, tracking 0.2657
    cta: inter(size: 14, weight: 600, height: 1.423, color: AppPalette.white)
        .copyWith(letterSpacing: 0.2657),
    // Inter 600 · 10 · 12.642px · white
    memberCount:
        inter(size: 10, weight: 600, height: 1.264, color: AppPalette.white),
    // Teal, not near-black: the headline price is the same #108B8B as the
    // community title.
    price:
        manrope(size: 18, weight: 700, height: 1.264, color: AppPalette.badgeTeal),
    pricePeriod:
        inter(size: 12, weight: 400, height: 1.364, color: AppPalette.postMeta),
    planLabel:
        inter(size: 12, weight: 600, height: 1.3, color: AppPalette.postTitle),
    benefit:
        inter(size: 11, weight: 400, height: 1.45, color: AppPalette.postBody),
    benefitBold:
        inter(size: 11, weight: 700, height: 1.45, color: AppPalette.postTitle),
  );

  static final CommunityTypography dark = CommunityTypography(
    category: inter(
        size: 10, weight: 500, height: 1.2, color: AppPalette.darkOnSurfaceMuted),
    title:
        manrope(size: 18, weight: 700, height: 1.264, color: AppPalette.teal400),
    announcement: inter(
        size: 10, weight: 500, height: 1.2, color: AppPalette.announcementGreen),
    description: inter(
        size: 12, weight: 400, height: 1.364, color: AppPalette.darkOnSurface),
    descriptionBold: inter(
        size: 12, weight: 700, height: 1.364, color: AppPalette.darkOnSurface),
    tagChip:
        inter(size: 10, weight: 400, height: 1.264, color: AppPalette.teal400),
    cta: inter(size: 14, weight: 600, height: 1.423, color: AppPalette.white)
        .copyWith(letterSpacing: 0.2657),
    memberCount:
        inter(size: 10, weight: 600, height: 1.264, color: AppPalette.white),
    price: manrope(
        size: 18, weight: 700, height: 1.264, color: AppPalette.darkOnSurface),
    pricePeriod: inter(
        size: 12, weight: 400, height: 1.364, color: AppPalette.darkOnSurfaceMuted),
    planLabel: inter(
        size: 12, weight: 600, height: 1.3, color: AppPalette.darkOnSurface),
    benefit: inter(
        size: 11, weight: 400, height: 1.45, color: AppPalette.darkOnSurfaceMuted),
    benefitBold: inter(
        size: 11, weight: 700, height: 1.45, color: AppPalette.darkOnSurface),
  );

  static CommunityTypography of(Brightness brightness) =>
      brightness == Brightness.dark ? dark : light;

  @override
  CommunityTypography copyWith({
    TextStyle? category,
    TextStyle? title,
    TextStyle? announcement,
    TextStyle? description,
    TextStyle? descriptionBold,
    TextStyle? tagChip,
    TextStyle? cta,
    TextStyle? memberCount,
    TextStyle? price,
    TextStyle? pricePeriod,
    TextStyle? planLabel,
    TextStyle? benefit,
    TextStyle? benefitBold,
  }) =>
      CommunityTypography(
        category: category ?? this.category,
        title: title ?? this.title,
        announcement: announcement ?? this.announcement,
        description: description ?? this.description,
        descriptionBold: descriptionBold ?? this.descriptionBold,
        tagChip: tagChip ?? this.tagChip,
        cta: cta ?? this.cta,
        memberCount: memberCount ?? this.memberCount,
        price: price ?? this.price,
        pricePeriod: pricePeriod ?? this.pricePeriod,
        planLabel: planLabel ?? this.planLabel,
        benefit: benefit ?? this.benefit,
        benefitBold: benefitBold ?? this.benefitBold,
      );

  @override
  CommunityTypography lerp(ThemeExtension<CommunityTypography>? other, double t) {
    if (other is! CommunityTypography) return this;
    return CommunityTypography(
      category: TextStyle.lerp(category, other.category, t)!,
      title: TextStyle.lerp(title, other.title, t)!,
      announcement: TextStyle.lerp(announcement, other.announcement, t)!,
      description: TextStyle.lerp(description, other.description, t)!,
      descriptionBold:
          TextStyle.lerp(descriptionBold, other.descriptionBold, t)!,
      tagChip: TextStyle.lerp(tagChip, other.tagChip, t)!,
      cta: TextStyle.lerp(cta, other.cta, t)!,
      memberCount: TextStyle.lerp(memberCount, other.memberCount, t)!,
      price: TextStyle.lerp(price, other.price, t)!,
      pricePeriod: TextStyle.lerp(pricePeriod, other.pricePeriod, t)!,
      planLabel: TextStyle.lerp(planLabel, other.planLabel, t)!,
      benefit: TextStyle.lerp(benefit, other.benefit, t)!,
      benefitBold: TextStyle.lerp(benefitBold, other.benefitBold, t)!,
    );
  }
}

extension CommunityTypographyX on BuildContext {
  CommunityTypography get communityType =>
      Theme.of(this).extension<CommunityTypography>()!;
}
