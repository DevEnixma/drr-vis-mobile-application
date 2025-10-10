import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/constants/text_style.dart';

class EmptyWidget extends StatelessWidget {
  final String title;
  final String label;
  const EmptyWidget({super.key, required this.title, required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 25.h),
          SizedBox(
            height: 100.h,
            child: Image.asset(
              'assets/images/empty_data.png',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 15.h),
          Text(title, style: AppTextStyle.title20bold()),
          SizedBox(height: 5.h),
          Text(label, textAlign: TextAlign.center, style: AppTextStyle.title16normal()),
        ],
      ),
    );
  }
}
