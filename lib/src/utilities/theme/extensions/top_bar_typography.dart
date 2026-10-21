import 'package:flutter/material.dart';

import '../text/text_style_factory.dart';
import '../tokens/app_palette.dart';

/// The shared gradient top bar (Feed + Communities) — Final page frame
/// `iPhone 16 - 12` (`605:15302`), search bar `605:15979`.
///
/// Figma sets the hint in **Poppins** 10.55, which the app doesn't ship; it is
/// approximated with Inter at the same size, as the feed's hashtags are.
/// Letter-spacing is pinned to 0 (the ambient 0.25 would widen the hint).
@immutable
class TopBarTypography extends ThemeExtension<TopBarTypography> {
  const TopBarTypography({
    required this.hint,
    required this.input,
    required this.title,
    required this.badge,
  });

  /// "Search posts, stocks or tags…" — white at 80%.
  final TextStyle hint;

  /// What the member types.
  final TextStyle input;

  /// The pushed feed's screen title (a single community).
  final TextStyle title;

  /// The bell's count, 4.46px — Figma draws it that small.
  final TextStyle badge;

  static final TopBarTypography light = TopBarTypography(
    hint: inter(
      size: 10.55,
      weight: 400,
      height: 1.0,
      color: AppPalette.topBarHint,
    ).copyWith(letterSpacing: 0),
    input: inter(
      size: 10.55,
      weight: 400,
      height: 1.0,
      color: AppPalette.white,
    ).copyWith(letterSpacing: 0),
    title: manrope(
      size: 16,
      weight: 700,
      height: 1.3,
      color: AppPalette.white,
    ).copyWith(letterSpacing: 0),
    badge: inter(
      size: 4.46,
      weight: 600,
      height: 1.0,
      color: AppPalette.white,
    ).copyWith(letterSpacing: 0),
  );

  static TopBarTypography of(Brightness brightness) => light;

  @override
  TopBarTypography copyWith({
    TextStyle? hint,
    TextStyle? input,
    TextStyle? title,
    TextStyle? badge,
  }) => TopBarTypography(
    hint: hint ?? this.hint,
    input: input ?? this.input,
    title: title ?? this.title,
    badge: badge ?? this.badge,
  );

  @override
  TopBarTypography lerp(ThemeExtension<TopBarTypography>? other, double t) {
    if (other is! TopBarTypography) return this;
    return TopBarTypography(
      hint: TextStyle.lerp(hint, other.hint, t)!,
      input: TextStyle.lerp(input, other.input, t)!,
      title: TextStyle.lerp(title, other.title, t)!,
      badge: TextStyle.lerp(badge, other.badge, t)!,
    );
  }
}

extension TopBarTypographyX on BuildContext {
  TopBarTypography get topBarType =>
      Theme.of(this).extension<TopBarTypography>()!;
}
