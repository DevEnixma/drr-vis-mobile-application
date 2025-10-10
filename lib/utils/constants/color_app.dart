import 'package:flutter/material.dart';

class ColorApps {
  // static Color memberTheme(color) {
  //   if (color == 'B') {
  //     return const Color(0xff191e1e);
  //   } else {
  //     return const Color(0xffdb1c3b);
  //   }
  // }

  static const Color colorMain = Color(0xFF314188);
  static const Color colorWhite = Color(0xFFFFFFFF);
  static const Color colorDary = Color(0xFF0E1C5F);
  static const Color colorRed = Color(0xFFE81A1A);
  static const Color colorText = Color(0xFF414142);
  static const Color colorDisable = Color(0xFFA8B7FF);
  static const Color colorBackground = Color(0xFFF6F6F6);
  static const Color colorGreen = Color(0xFF14AE5C);
  static const Color colorGray = Color(0xFFBEBEBE);
  static const Color colorGrayDisable = Color(0xFFE0E0E0);
  static const Color colorTextField = Color(0xFFF2F2F2);
  static const Color colorGrayBoxShadow = Color(0xFFD9D9D9);

  static const Color grayBorder = Color(0xFFD4D4D4);
  static const Color grayDot = Color(0xFFA7A7A7);
  static const Color iconColor = Color(0xFF757575);

  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contencotColorCyan = Color(0xFF50E4FF);
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color contentColorOrenge = Color(0xFFFF8400);

  // Define color schemes
  static const ColorScheme masterColorScheme = ColorScheme(
    primary: colorMain, // องค์ประกอบสำคัญ เช่น แถบแอป, ปุ่ม
    onPrimary: colorBackground, // ข้อความ/ไอคอนบนองค์ประกอบสีหลัก
    secondary: colorDary, // องค์ประกอบที่สำคัญน้อยกว่า
    onSecondary: colorText, // ข้อความ/ไอคอนบนองค์ประกอบสีรอง
    surface: colorWhite, // พื้นผิวขององค์ประกอบ เช่น การ์ด
    onSurface: colorDisable, // ข้อความ/ไอคอนบนพื้นผิว
    error: colorRed, // ข้อความแจ้งเตือนข้อผิดพลาด
    onError: colorWhite, // ข้อความ/ไอคอนบนพื้นหลังสีข้อผิดพลาด
    brightness: Brightness.light, // ธีมสีสว่าง
    tertiary: colorGreen,
    onTertiary: colorGray,
    tertiaryContainer: colorGrayDisable,
    onTertiaryContainer: colorTextField,
    tertiaryFixed: colorGrayBoxShadow,
  );

  // Theme.of(context).colorScheme.secondary

  static var primary;
  static var onPrimary;
  static var secondary;
  static var onSecondary;
  static var surface;
  static var onSurface;
  static var error;
  static var onError;
  static var brightness;
}
