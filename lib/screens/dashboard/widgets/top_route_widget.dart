import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/constants/text_style.dart';

class TopRouteWidget extends StatelessWidget {
  const TopRouteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 15.h),
          Container(
            height: 32.h,
            width: 32.h,
            padding: EdgeInsets.all(5.w),
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(90.r)),
            child: SvgPicture.asset(
              'assets/svg/top_five.svg',
            ),
          ),
          SizedBox(width: 15.h),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '5 อันดับสายทางที่มีปริมาณรถมากที่สุด',
                style: AppTextStyle.title18bold(),
              ),
              Text(
                'จากจำนวนสายทางทั้งหมด',
                style: AppTextStyle.title14normal(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
