import 'package:flutter/material.dart';

import 'color_schemes/dark_scheme.dart';
import 'color_schemes/light_scheme.dart';
import 'components/app_bar_theme.dart';
import 'components/button_themes.dart';
import 'components/input_theme.dart';
import 'components/navigation_theme.dart';
import 'components/selection_themes.dart';
import 'components/surface_themes.dart';
import 'extensions/app_gradients.dart';
import 'text/app_text_theme.dart';
import 'tokens/app_typography.dart';

/// Assembles both themes from a single builder — brightness lives only in the
/// two [ColorScheme]s, so light and dark cannot drift apart.
class AppTheme {
  AppTheme._();

  static ThemeData get light => _build(lightScheme);
  static ThemeData get dark => _build(darkScheme);

  static ThemeData _build(ColorScheme cs) {
    final tt = AppTextTheme.build(cs);
    return ThemeData(
      useMaterial3: true,
      brightness: cs.brightness,
      colorScheme: cs,
      fontFamily: AppTypography.body,
      scaffoldBackgroundColor: cs.surface,
      canvasColor: cs.surface,
      textTheme: tt,
      primaryColor: cs.primary,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      splashFactory: InkSparkle.splashFactory,
      extensions: [AppGradients.of(cs.brightness)],
      appBarTheme: buildAppBarTheme(cs, tt),
      iconTheme: buildIconTheme(cs),
      popupMenuTheme: buildPopupMenuTheme(cs, tt),
      drawerTheme: buildDrawerTheme(cs),
      elevatedButtonTheme: buildElevatedButtonTheme(cs, tt),
      filledButtonTheme: buildFilledButtonTheme(cs, tt),
      textButtonTheme: buildTextButtonTheme(cs, tt),
      outlinedButtonTheme: buildOutlinedButtonTheme(cs, tt),
      inputDecorationTheme: buildInputTheme(cs, tt),
      cardTheme: buildCardTheme(cs),
      dialogTheme: buildDialogTheme(cs, tt),
      bottomSheetTheme: buildBottomSheetTheme(cs),
      dividerTheme: buildDividerTheme(cs),
      listTileTheme: buildListTileTheme(cs, tt),
      checkboxTheme: buildCheckboxTheme(cs),
      radioTheme: buildRadioTheme(cs),
      switchTheme: buildSwitchTheme(cs),
      floatingActionButtonTheme: buildFabTheme(cs),
      snackBarTheme: buildSnackBarTheme(cs, tt),
      navigationBarTheme: buildNavigationBarTheme(cs, tt),
      bottomNavigationBarTheme: buildBottomNavTheme(cs, tt),
      tabBarTheme: buildTabBarTheme(cs, tt),
    );
  }
}
