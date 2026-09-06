import 'package:flutter/material.dart';

import '../tokens/app_radii.dart';

OutlineInputBorder _border(Color color, {double width = 1}) =>
    OutlineInputBorder(
      borderRadius: AppRadii.medium,
      borderSide: BorderSide(color: color, width: width),
    );

InputDecorationTheme buildInputTheme(ColorScheme cs, TextTheme tt) =>
    InputDecorationTheme(
      filled: true,
      fillColor: cs.surfaceContainerLow,
      isDense: false,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      hintStyle: tt.bodyLarge?.copyWith(color: cs.onSurfaceVariant),
      labelStyle: tt.bodyLarge?.copyWith(color: cs.onSurfaceVariant),
      floatingLabelStyle: tt.bodyMedium?.copyWith(color: cs.primary),
      helperStyle: tt.bodySmall,
      errorStyle: tt.bodySmall?.copyWith(color: cs.error),
      prefixIconColor: cs.onSurfaceVariant,
      suffixIconColor: cs.onSurfaceVariant,
      border: _border(cs.outlineVariant),
      enabledBorder: _border(cs.outlineVariant),
      focusedBorder: _border(cs.primary, width: 1.5),
      errorBorder: _border(cs.error),
      focusedErrorBorder: _border(cs.error, width: 1.5),
      disabledBorder: _border(cs.outlineVariant.withValues(alpha: 0.5)),
    );
