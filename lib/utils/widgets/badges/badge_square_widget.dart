import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/text_style.dart';
import '../../libs/string_helper.dart';

class BadgeSquareWidget extends StatelessWidget {
  const BadgeSquareWidget({
    super.key,
    required this.text,
    this.colorText,
    this.colorBg,
  });

  final String text;
  final Color? colorText;
  final Color? colorBg;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colorBg ?? null,
        borderRadius: BorderRadius.circular(5.r),
      ),
      margin: const EdgeInsets.only(bottom: 6.0),
      padding: const EdgeInsets.only(left: 12, right: 12, top: 4, bottom: 4),
      child: Center(
        child: Text(StringHleper.checkString(text), style: AppTextStyle.title14bold(color: colorText ?? Theme.of(context).colorScheme.surface)),
      ),
    );
  }
}
