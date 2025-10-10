import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../service/token_refresh.service.dart';
import '../../utils/constants/text_style.dart';
import '../../utils/widgets/custom_button.dart';

//  หน้าบันทึกสำเร็จ

// TODO: 777

class SuccessScreen extends StatelessWidget {
  final String icon;
  final String titleBT;

  final String title;
  final String message;
  final Function() onConfirm;
  final Function()? onCancel;

  SuccessScreen({
    required this.icon,
    required this.titleBT,
    required this.title,
    required this.message,
    required this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    Provider.of<TokenRefreshService>(context, listen: false).startTokenRefreshTimer();
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SizedBox(height: 12),
                Column(
                  children: [
                    SizedBox(height: 120.h),
                    SvgPicture.asset(icon),
                    SizedBox(height: 20.h),
                    Text(
                      title,
                      style: AppTextStyle.title20bold(color: Theme.of(context).colorScheme.secondary),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      message,
                      style: AppTextStyle.title16normal(),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),

                Column(
                  children: [
                    CustomeButton(
                      text: titleBT,
                      onPressed: onConfirm,
                    ),
                    onCancel == null
                        ? Container() // ไม่แสดงปุ่มยกเลิกถ้าถูกซ่อนไว้
                        : TextButton(
                            onPressed: () {
                              if (onCancel != null) {
                                onCancel!();
                              } else {
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              'กลับหน้าจัดตั้งหน่วย',
                              style: AppTextStyle.title18bold(color: Theme.of(context).colorScheme.primary),
                              textAlign: TextAlign.center,
                            ),
                          ),
                    SizedBox(height: 20.h),
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
