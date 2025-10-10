import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/text_style.dart';

class BadgeWidget extends StatelessWidget {
  const BadgeWidget({
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
        color: colorBg ?? Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(32.r),
      ),
      margin: const EdgeInsets.only(right: 16.0),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Text(text, style: AppTextStyle.title14bold(color: colorText ?? Theme.of(context).colorScheme.secondary)),
    );
  }
}
