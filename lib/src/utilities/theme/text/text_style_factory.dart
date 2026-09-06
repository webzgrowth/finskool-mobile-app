import 'package:flutter/material.dart';

import '../tokens/app_typography.dart';

/// Builds a Manrope (heading) style with the `wght` axis applied.
TextStyle manrope({
  required double size,
  required double weight,
  required double height,
  required Color color,
}) =>
    TextStyle(
      fontFamily: AppTypography.heading,
      fontSize: size,
      height: height,
      color: color,
      fontWeight: FontWeight.values.firstWhere(
        (w) => w.value == weight.round(),
        orElse: () => FontWeight.normal,
      ),
      fontVariations: AppTypography.heavy(weight),
    );

/// Builds an Inter (body) style with the `wght` and `opsz` axes applied.
TextStyle inter({
  required double size,
  required double weight,
  required double height,
  required Color color,
}) =>
    TextStyle(
      fontFamily: AppTypography.body,
      fontSize: size,
      height: height,
      color: color,
      fontWeight: FontWeight.values.firstWhere(
        (w) => w.value == weight.round(),
        orElse: () => FontWeight.normal,
      ),
      fontVariations: AppTypography.text(weight, size),
    );
