import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../tokens/app_radii.dart';

AppBarTheme buildAppBarTheme(ColorScheme cs, TextTheme tt) {
  final isLight = cs.brightness == Brightness.light;
  return AppBarTheme(
    backgroundColor: cs.surface,
    foregroundColor: cs.onSurface,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    scrolledUnderElevation: 0.5,
    centerTitle: false,
    titleTextStyle: tt.titleLarge,
    toolbarTextStyle: tt.bodyMedium,
    iconTheme: IconThemeData(color: cs.onSurface, size: 22),
    actionsIconTheme: IconThemeData(color: cs.onSurface, size: 22),
    systemOverlayStyle: isLight
        ? SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
          )
        : SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.dark,
          ),
  );
}

IconThemeData buildIconTheme(ColorScheme cs) =>
    IconThemeData(color: cs.onSurface, size: 22);

PopupMenuThemeData buildPopupMenuTheme(ColorScheme cs, TextTheme tt) =>
    PopupMenuThemeData(
      color: cs.surfaceContainerLow,
      surfaceTintColor: Colors.transparent,
      elevation: 3,
      textStyle: tt.bodyMedium,
      shape: RoundedRectangleBorder(borderRadius: AppRadii.medium),
    );

DrawerThemeData buildDrawerTheme(ColorScheme cs) => DrawerThemeData(
      backgroundColor: cs.surface,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(AppRadii.xl),
        ),
      ),
    );
