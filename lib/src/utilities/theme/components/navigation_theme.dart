import 'package:flutter/material.dart';

NavigationBarThemeData buildNavigationBarTheme(ColorScheme cs, TextTheme tt) =>
    NavigationBarThemeData(
      backgroundColor: cs.surface,
      surfaceTintColor: Colors.transparent,
      indicatorColor: cs.primaryContainer,
      elevation: 0,
      height: 68,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      labelTextStyle: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? tt.labelLarge?.copyWith(color: cs.primary)
            : tt.labelMedium,
      ),
      iconTheme: WidgetStateProperty.resolveWith(
        (states) => IconThemeData(
          size: 22,
          color: states.contains(WidgetState.selected)
              ? cs.primary
              : cs.onSurfaceVariant,
        ),
      ),
    );

BottomNavigationBarThemeData buildBottomNavTheme(ColorScheme cs, TextTheme tt) =>
    BottomNavigationBarThemeData(
      backgroundColor: cs.surface,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      selectedItemColor: cs.primary,
      unselectedItemColor: cs.onSurfaceVariant,
      selectedIconTheme: IconThemeData(color: cs.primary, size: 22),
      unselectedIconTheme: IconThemeData(color: cs.onSurfaceVariant, size: 22),
      selectedLabelStyle: tt.labelLarge,
      unselectedLabelStyle: tt.labelMedium,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    );

TabBarThemeData buildTabBarTheme(ColorScheme cs, TextTheme tt) =>
    TabBarThemeData(
      labelColor: cs.primary,
      unselectedLabelColor: cs.onSurfaceVariant,
      labelStyle: tt.titleMedium,
      unselectedLabelStyle: tt.titleMedium,
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: Colors.transparent,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: cs.primary, width: 2.5),
      ),
    );
