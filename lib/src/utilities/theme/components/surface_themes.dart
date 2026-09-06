import 'package:flutter/material.dart';

import '../tokens/app_radii.dart';

CardThemeData buildCardTheme(ColorScheme cs) => CardThemeData(
      color: cs.surface,
      surfaceTintColor: Colors.transparent,
      shadowColor: cs.shadow.withValues(alpha: 0.06),
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: AppRadii.large),
    );

DialogThemeData buildDialogTheme(ColorScheme cs, TextTheme tt) =>
    DialogThemeData(
      backgroundColor: cs.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 3,
      titleTextStyle: tt.headlineSmall,
      contentTextStyle: tt.bodyLarge,
      shape: RoundedRectangleBorder(borderRadius: AppRadii.large),
    );

BottomSheetThemeData buildBottomSheetTheme(ColorScheme cs) =>
    BottomSheetThemeData(
      backgroundColor: cs.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      showDragHandle: true,
      dragHandleColor: cs.outlineVariant,
      shape: RoundedRectangleBorder(borderRadius: AppRadii.sheet),
    );

DividerThemeData buildDividerTheme(ColorScheme cs) => DividerThemeData(
      color: cs.outlineVariant,
      thickness: 1,
      space: 1,
    );

ListTileThemeData buildListTileTheme(ColorScheme cs, TextTheme tt) =>
    ListTileThemeData(
      iconColor: cs.onSurfaceVariant,
      textColor: cs.onSurface,
      titleTextStyle: tt.titleMedium,
      subtitleTextStyle: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: AppRadii.medium),
    );
