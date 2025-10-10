import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/constants/text_style.dart';
import '../../../../utils/widgets/custom_button.dart';

class CustomBottomSheetWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String message;
  final Function()? onConfirm;
  final Function()? onCancel;
  const CustomBottomSheetWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 22, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 6.w),
          Column(
            children: [
              SvgPicture.asset(
                'assets/svg/$icon.svg',
                height: 75.w,
              ),
              Text(
                title,
                style: AppTextStyle.title20bold(color: Theme.of(context).colorScheme.secondary),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                message,
                style: AppTextStyle.title16normal(),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
            ],
          ),
          CustomeButton(
            text: 'ยืนยัน',
            onPressed: onConfirm,
          ),
          TextButton(
            onPressed: onCancel,
            child: Text(
              'ยกเลิก',
              style: AppTextStyle.title18bold(color: Theme.of(context).colorScheme.primary),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
