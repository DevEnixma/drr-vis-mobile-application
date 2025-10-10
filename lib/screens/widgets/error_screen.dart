import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/constants/text_style.dart';
import '../../utils/widgets/custom_button.dart';

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SizedBox.shrink(),
                Column(
                  children: [
                    SizedBox(height: 50.h),
                    SvgPicture.asset(
                      'assets/svg/ant-design_exclamation-circle-filled.svg',
                    ),
                    SizedBox(height: 20),
                    Text(
                      'บันทึกการเข้าชั่งไม่สำเร็จ',
                      style: AppTextStyle.title20bold(color: Theme.of(context).colorScheme.secondary),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'กรุณาตรวจสอบข้อมูลอีกครั้ง',
                      style: AppTextStyle.title16normal(),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),
                  ],
                ),
                Column(
                  children: [
                    CustomeButton(
                      text: 'ลองอีกครั้ง',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      child: Text(
                        'กลับหน้าจัดตั้งหน่วย',
                        style: AppTextStyle.title18bold(color: Theme.of(context).colorScheme.primary),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
