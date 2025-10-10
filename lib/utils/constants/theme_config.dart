import 'package:flutter/material.dart';

import 'color_app.dart';

// const ColorApps.primary = Color(0xFF314188);
// const daryColor = Color(0xFF0E1C5F);

// const whiteColor = Color(0xFFFFFFFF);
// const redColor = Color(0xFFE81A1A);
// const greenColor = Color(0xFF14AE5C);
// const grayColor = Color(0xFFBEBEBE);

// const disableColor = Color(0xFFA8B7FF);
// const grayDisableColor = Color(0xFFE0E0E0);
// const grayTextfield = Color(0xFFF2F2F2);
// const grayDot = Color(0xFFA7A7A7);
// const Theme.of(context).colorScheme.tertiaryFixed = Color(0xFFD9D9D9);
// const grayBorder = Color(0xFFD4D4D4);
// const grayIconColor = Color(0xFFE0E0E0);
// const iconColor = Color(0xFF757575);
// const Theme.of(context).colorScheme.onSecondary = Color(0xFF414142);
// const backgroundColor = Color(0xFFF6F6F6);

// const contentColorPurple = Color(0xFF6E1BFF);
// const contentColorCyan = Color(0xFF50E4FF);
// const contentColorBlue = Color(0xFF2196F3);

// final ThemeData appThemeData = ThemeData(
//   fontFamily: 'IBMPlexSansThai', // กำหนด Font ที่ใช้ทั้งแอป
//   primaryColor: ColorApps.primary,
//   scaffoldBackgroundColor: ColorApps.onPrimary,
//   appBarTheme: AppBarTheme(
//     backgroundColor: ColorApps.primary,
//     foregroundColor: ColorApps.surface,
//   ),
// );

class ThemeConfig {
  static ThemeData getThemeData(BuildContext context) {
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
      // textTheme: AppTextStyle.getTextTheme(context, chosenColorScheme),
      useMaterial3: true,
    );
  }
}
