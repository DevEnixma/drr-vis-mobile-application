import 'package:flutter/material.dart';

import 'color_app.dart';

class ThemeConfig {
  ThemeConfig._();

  static ThemeData? _cachedTheme;

  static ThemeData getThemeData(BuildContext context) {
    _cachedTheme ??= _buildThemeData();
    return _cachedTheme!;
  }

  static ThemeData _buildThemeData() {
    ColorScheme chosenColorScheme = ColorApps.masterColorScheme;
    return ThemeData(
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      }),
      primaryColor: ColorApps.primary,
      appBarTheme: AppBarTheme(
        backgroundColor: ColorApps.colorMain,
        surfaceTintColor: ColorApps.colorBackground,
      ),
      colorScheme: chosenColorScheme,
      scaffoldBackgroundColor: ColorApps.colorWhite,
      useMaterial3: true,
    );
  }

  static void refreshTheme() {
    _cachedTheme = null;
  }
}
