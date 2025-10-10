import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/text_style.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 32.h,
          width: 32.h,
          decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(90.r)),
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.surface,
            size: 20.h,
          ),
        ),
        SizedBox(width: 12.w),
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyle.title18bold(color: Theme.of(context).colorScheme.primary),
        )
      ],
    );
  }
}
