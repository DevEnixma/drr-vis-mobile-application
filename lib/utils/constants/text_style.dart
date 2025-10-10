import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wts_bloc/utils/constants/color_app.dart';

class AppTextStyle {
  // fontSize lip - 3 จะเท่ากับ fontSize ใน figma
  static TextStyle header32bold({Color? color, double? fontSize}) {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: fontSize ?? 28.sp,
      color: color ?? ColorApps.colorText,
      fontFamily: 'IBMPlexSansThai',
    );
  }

  static TextStyle header22bold({Color? color, double? fontSize}) {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: fontSize ?? 18.sp,
      color: color ?? ColorApps.colorText,
      fontFamily: 'IBMPlexSansThai',
    );
  }

  static TextStyle title14bold({Color? color, double? fontSize}) {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: fontSize ?? 11.sp,
      color: color ?? ColorApps.colorText,
      fontFamily: 'IBMPlexSansThai',
    );
  }

  static TextStyle title14normal({Color? color, double? fontSize}) {
    return TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: fontSize ?? 11.sp,
      color: color ?? ColorApps.colorText,
      fontFamily: 'IBMPlexSansThai',
    );
  }

  static TextStyle title16normal({Color? color, double? fontSize}) {
    return TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: fontSize ?? 13.sp,
      color: color ?? ColorApps.colorText,
      fontFamily: 'IBMPlexSansThai',
    );
  }

  static TextStyle title16bold({Color? color, double? fontSize}) {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: fontSize ?? 13.sp,
      color: color ?? ColorApps.colorText,
      fontFamily: 'IBMPlexSansThai',
    );
  }

  static TextStyle title18normal({Color? color, double? fontSize}) {
    return TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: fontSize ?? 15.sp,
      color: color ?? ColorApps.colorText,
      fontFamily: 'IBMPlexSansThai',
    );
  }

  static TextStyle title18bold({Color? color, double? fontSize}) {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: fontSize ?? 15.sp,
      color: color ?? ColorApps.colorText,
      fontFamily: 'IBMPlexSansThai',
    );
  }

  static TextStyle title20normal({Color? color, double? fontSize}) {
    return TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: fontSize ?? 17.sp,
      color: color ?? ColorApps.colorText,
      fontFamily: 'IBMPlexSansThai',
    );
  }

  static TextStyle title20bold({Color? color, double? fontSize}) {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: fontSize ?? 17.sp,
      color: color ?? ColorApps.colorText,
      fontFamily: 'IBMPlexSansThai',
    );
  }

  static TextStyle label12normal({Color? color, double? fontSize}) {
    return TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: fontSize ?? 9.sp,
      color: color ?? ColorApps.colorText,
      fontFamily: 'IBMPlexSansThai',
    );
  }

  static TextStyle label12bold({Color? color, double? fontSize}) {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: fontSize ?? 9.sp,
      color: color ?? ColorApps.colorText,
      fontFamily: 'IBMPlexSansThai',
    );
  }

  static TextStyle title18boldUnderLine({Color? color, double? fontSize}) {
    return TextStyle(
      decoration: TextDecoration.underline,
      decorationColor: color ?? ColorApps.colorText,
      fontWeight: FontWeight.bold,
      fontSize: fontSize ?? 15.sp,
      color: color ?? ColorApps.colorText,
      fontFamily: 'IBMPlexSansThai',
    );
  }

  static TextStyle title16boldUnderLine({Color? color, double? fontSize}) {
    return TextStyle(
      decoration: TextDecoration.underline,
      decorationColor: color ?? ColorApps.colorText,
      fontWeight: FontWeight.bold,
      fontSize: fontSize ?? 13.sp,
      color: color ?? ColorApps.colorText,
      fontFamily: 'IBMPlexSansThai',
    );
  }
}
