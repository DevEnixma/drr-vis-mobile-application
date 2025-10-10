import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/text_style.dart';

class TitleSvgWidget extends StatelessWidget {
  const TitleSvgWidget({
    super.key,
    required this.title,
    required this.imageSvg,
    this.colorBg,
    this.colorText,
    this.colorSvg,
  });

  final String title;
  final String imageSvg;
  final Color? colorBg;
  final Color? colorSvg;
  final Color? colorText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            height: 32.h,
            width: 32.h,
            padding: EdgeInsets.all(5.h),
            decoration: BoxDecoration(
              color: colorBg ?? Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(90.r),
            ),
            child: SvgPicture.asset(
              imageSvg,
              color: colorSvg ?? Theme.of(context).colorScheme.surface,
            )),
        SizedBox(width: 12.w),
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyle.title18bold(color: colorText ?? Theme.of(context).colorScheme.primary),
        )
      ],
    );
  }
}
