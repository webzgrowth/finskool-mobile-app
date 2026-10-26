import 'package:flutter/material.dart';

import '../text/text_style_factory.dart';
import '../tokens/app_palette.dart';

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

/// Type for the Profile info screens — About & SEBI info, Terms & privacy
/// policy and Help & support — measured from the Final page (`1554:8149`,
/// `1554:8682`). `letterSpacing` is pinned to 0 for the usual reason: a bare
/// style inherits Material's 0.25 and widens every line.
///
/// Light only: the design has no dark variant, so [of] ignores brightness.
@immutable
class InfoTypography extends ThemeExtension<InfoTypography> {
  const InfoTypography({
    required this.heroTitle,
    required this.heroSubtitle,
    required this.brandName,
    required this.brandMeta,
    required this.eyebrow,
    required this.verified,
    required this.regNumber,
    required this.detailLabel,
    required this.detailValue,
    required this.sectionLabel,
    required this.body,
    required this.rowTitle,
    required this.rowSub,
    required this.link,
    required this.disclaimerHead,
    required this.disclaimerBody,
    required this.tabOn,
    required this.tabOff,
    required this.metaLabel,
    required this.metaValue,
    required this.chip,
    required this.articleNo,
    required this.articleTitle,
    required this.articleBody,
  });

  final TextStyle heroTitle;
  final TextStyle heroSubtitle;
  final TextStyle brandName;
  final TextStyle brandMeta;
  final TextStyle eyebrow;
  final TextStyle verified;
  final TextStyle regNumber;
  final TextStyle detailLabel;
  final TextStyle detailValue;
  final TextStyle sectionLabel;
  final TextStyle body;
  final TextStyle rowTitle;
  final TextStyle rowSub;
  final TextStyle link;
  final TextStyle disclaimerHead;
  final TextStyle disclaimerBody;
  final TextStyle tabOn;
  final TextStyle tabOff;
  final TextStyle metaLabel;
  final TextStyle metaValue;
  final TextStyle chip;
  final TextStyle articleNo;
  final TextStyle articleTitle;
  final TextStyle articleBody;

  static const Color _ink = AppPalette.infoInk;
  static const Color _deep = AppPalette.cardTitle;

  static final InfoTypography light = InfoTypography(
    heroTitle: _m(20, 700, 27 / 20, AppPalette.white),
    heroSubtitle: _i(12, 400, 15 / 12, const Color(0xCCFFFFFF)),
    brandName: _m(16, 700, 22 / 16, _deep),
    brandMeta: _i(11.5, 400, 14 / 11.5, AppPalette.infoMuted),
    eyebrow: _i(10.5, 500, 13 / 10.5, AppPalette.infoMuted),
    verified: _i(10.5, 600, 13 / 10.5, AppPalette.badgeTeal),
    regNumber: _m(26, 600, 36 / 26, _deep),
    detailLabel: _i(11.5, 400, 14 / 11.5, AppPalette.infoMuted),
    detailValue: _i(14, 600, 17 / 14, _ink),
    sectionLabel: _i(11, 600, 13 / 11, AppPalette.infoLabel),
    body: _i(13, 400, 20 / 13, AppPalette.infoBody),
    rowTitle: _i(13.5, 600, 16 / 13.5, _ink),
    rowSub: _i(12, 400, 17 / 12, AppPalette.infoSub),
    link: _i(12, 600, 15 / 12, AppPalette.badgeTeal),
    disclaimerHead: _i(13, 600, 16 / 13, AppPalette.infoDisclaimerInk),
    disclaimerBody: _i(12, 400, 18 / 12, AppPalette.infoDisclaimerBody),
    tabOn: _i(13, 600, 16 / 13, _deep),
    tabOff: _i(13, 500, 16 / 13, AppPalette.infoSub),
    metaLabel: _i(12, 400, 15 / 12, AppPalette.infoLabel),
    metaValue: _i(12, 600, 15 / 12, _deep),
    chip: _i(11, 500, 13 / 11, AppPalette.infoChipInk),
    articleNo: _m(11, 700, 15 / 11, AppPalette.badgeTeal),
    articleTitle: _m(16, 700, 22 / 16, _deep),
    articleBody: _i(13.5, 400, 22 / 13.5, AppPalette.infoArticle),
  );

  static InfoTypography of(Brightness _) => light;

  @override
  InfoTypography copyWith() => this;

  @override
  InfoTypography lerp(ThemeExtension<InfoTypography>? other, double t) => this;
}

extension InfoTypographyX on BuildContext {
  InfoTypography get infoType => Theme.of(this).extension<InfoTypography>()!;
}
