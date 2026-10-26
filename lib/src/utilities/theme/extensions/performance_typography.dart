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

/// Type for the Performance screen, measured from the Final page
/// (`1554:6103`). The header subtitle is Nunito in Figma, which isn't bundled,
/// so it is approximated with Inter at the same size/weight. `letterSpacing`
/// is pinned to 0 — a bare style inherits Material's 0.25.
///
/// Light only: the design has no dark variant, so [of] ignores brightness.
@immutable
class PerformanceTypography extends ThemeExtension<PerformanceTypography> {
  const PerformanceTypography({
    required this.heroTitle,
    required this.heroSubtitle,
    required this.cardLabel,
    required this.chip,
    required this.bigValue,
    required this.unit,
    required this.barLabel,
    required this.barValue,
    required this.capitalValue,
    required this.donutValue,
    required this.donutCaption,
    required this.legendLabel,
    required this.legendValue,
    required this.note,
    required this.listTitle,
    required this.count,
    required this.logo,
    required this.stock,
    required this.meta,
    required this.tag,
    required this.result,
    required this.resultPct,
    required this.detailLabel,
    required this.detailValue,
  });

  final TextStyle heroTitle;
  final TextStyle heroSubtitle;
  final TextStyle cardLabel;
  final TextStyle chip;
  final TextStyle bigValue;
  final TextStyle unit;
  final TextStyle barLabel;
  final TextStyle barValue;
  final TextStyle capitalValue;
  final TextStyle donutValue;
  final TextStyle donutCaption;
  final TextStyle legendLabel;
  final TextStyle legendValue;
  final TextStyle note;
  final TextStyle listTitle;
  final TextStyle count;
  final TextStyle logo;
  final TextStyle stock;
  final TextStyle meta;
  final TextStyle tag;
  final TextStyle result;
  final TextStyle resultPct;
  final TextStyle detailLabel;
  final TextStyle detailValue;

  static const Color _ink = AppPalette.cardTitle;

  static final PerformanceTypography light = PerformanceTypography(
    heroTitle: _m(18, 700, 25 / 18, AppPalette.white),
    heroSubtitle: _i(12, 600, 16 / 12, const Color(0xCCFFFFFF)),
    cardLabel: _i(12.5, 500, 15 / 12.5, AppPalette.perfMuted),
    chip: _i(11, 600, 13 / 11, _ink),
    bigValue: _m(42, 700, 57 / 42, AppPalette.ticketRed),
    unit: _i(13, 600, 16 / 13, AppPalette.perfHint),
    barLabel: _i(12.5, 400, 15 / 12.5, AppPalette.perfLabel),
    barValue: _i(13.5, 600, 16 / 13.5, AppPalette.perfProfit),
    capitalValue: _m(15, 700, 20 / 15, _ink),
    donutValue: _m(24, 700, 33 / 24, _ink),
    donutCaption: _i(9.5, 500, 11 / 9.5, AppPalette.perfMuted),
    legendLabel: _i(12, 400, 15 / 12, AppPalette.perfLabel),
    legendValue: _m(20, 700, 27 / 20, AppPalette.perfProfit),
    note: _i(11.5, 400, 16 / 11.5, AppPalette.perfMuted),
    listTitle: _m(15, 700, 20 / 15, _ink),
    count: _i(11, 600, 13 / 11, _ink),
    logo: _m(13, 700, 18 / 13, AppPalette.logoRedInk),
    stock: _i(14, 600, 17 / 14, _ink),
    meta: _i(11.5, 400, 14 / 11.5, AppPalette.perfMuted),
    tag: _i(10.5, 600, 13 / 10.5, AppPalette.badgeTeal),
    result: _m(15, 700, 20 / 15, AppPalette.perfProfit),
    resultPct: _i(11.5, 500, 14 / 11.5, AppPalette.perfProfit),
    detailLabel: _i(11, 400, 13 / 11, AppPalette.perfMuted),
    detailValue: _i(13.5, 600, 16 / 13.5, _ink),
  );

  static PerformanceTypography of(Brightness _) => light;

  @override
  PerformanceTypography copyWith() => this;

  @override
  PerformanceTypography lerp(
    ThemeExtension<PerformanceTypography>? other,
    double t,
  ) => this;
}

extension PerformanceTypographyX on BuildContext {
  PerformanceTypography get performanceType =>
      Theme.of(this).extension<PerformanceTypography>()!;
}
