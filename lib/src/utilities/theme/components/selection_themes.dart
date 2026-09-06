import 'package:flutter/material.dart';

import '../tokens/app_radii.dart';

CheckboxThemeData buildCheckboxTheme(ColorScheme cs) => CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? cs.primary
            : Colors.transparent,
      ),
      checkColor: WidgetStatePropertyAll(cs.onPrimary),
      side: BorderSide(color: cs.outline, width: 1.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.xs),
      ),
    );

RadioThemeData buildRadioTheme(ColorScheme cs) => RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (states) =>
            states.contains(WidgetState.selected) ? cs.primary : cs.outline,
      ),
    );

SwitchThemeData buildSwitchTheme(ColorScheme cs) => SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? cs.onPrimary
            : cs.outline,
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? cs.primary
            : cs.surfaceContainerHighest,
      ),
    );

FloatingActionButtonThemeData buildFabTheme(ColorScheme cs) =>
    FloatingActionButtonThemeData(
      backgroundColor: cs.primary,
      foregroundColor: cs.onPrimary,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: AppRadii.medium),
    );

SnackBarThemeData buildSnackBarTheme(ColorScheme cs, TextTheme tt) =>
    SnackBarThemeData(
      backgroundColor: cs.inverseSurface,
      contentTextStyle: tt.bodyLarge?.copyWith(color: cs.onInverseSurface),
      actionTextColor: cs.inversePrimary,
      behavior: SnackBarBehavior.floating,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: AppRadii.medium),
    );
