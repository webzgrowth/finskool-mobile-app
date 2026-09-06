import 'package:flutter/material.dart';

import '../tokens/app_radii.dart';

const Size _minSize = Size.fromHeight(52);
const EdgeInsets _pad = EdgeInsets.symmetric(horizontal: 24, vertical: 14);

RoundedRectangleBorder _shape() =>
    RoundedRectangleBorder(borderRadius: AppRadii.medium);

/// Filled primary CTA. Uses the brand teal; see CLAUDE.md on contrast if you
/// need a stronger fill (`cs.secondary` reaches 11:1 against white).
ElevatedButtonThemeData buildElevatedButtonTheme(ColorScheme cs, TextTheme tt) =>
    ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
        disabledBackgroundColor: cs.onSurface.withValues(alpha: 0.12),
        disabledForegroundColor: cs.onSurface.withValues(alpha: 0.38),
        elevation: 0,
        minimumSize: _minSize,
        padding: _pad,
        shape: _shape(),
        textStyle: tt.titleMedium,
      ),
    );

FilledButtonThemeData buildFilledButtonTheme(ColorScheme cs, TextTheme tt) =>
    FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: cs.secondary,
        foregroundColor: cs.onSecondary,
        minimumSize: _minSize,
        padding: _pad,
        shape: _shape(),
        textStyle: tt.titleMedium,
      ),
    );

TextButtonThemeData buildTextButtonTheme(ColorScheme cs, TextTheme tt) =>
    TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: cs.primary,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: AppRadii.small),
        textStyle: tt.titleMedium,
      ),
    );

OutlinedButtonThemeData buildOutlinedButtonTheme(ColorScheme cs, TextTheme tt) =>
    OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: cs.primary,
        backgroundColor: Colors.transparent,
        minimumSize: _minSize,
        padding: _pad,
        shape: _shape(),
        side: BorderSide(color: cs.primary),
        textStyle: tt.titleMedium,
      ),
    );
