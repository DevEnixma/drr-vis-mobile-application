import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/constants/text_style.dart';

class EstablishEmptyScreen extends StatefulWidget {
  const EstablishEmptyScreen({super.key});

  @override
  State<EstablishEmptyScreen> createState() => _EstablishEmptyScreenState();
}

class _EstablishEmptyScreenState extends State<EstablishEmptyScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 12.h, horizontal: 18.h),
          padding: EdgeInsets.symmetric(vertical: 42.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.tertiaryFixed,
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 127.h,
                    child: Image.asset(
                      'assets/images/establish_empty.png',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Text('ไม่มีหน่วยชั่งเคลื่อนที่เปิดอยู่', style: AppTextStyle.title20bold(color: Theme.of(context).colorScheme.primary)),
                  RichText(
                    text: TextSpan(
                      text: 'กด',
                      style: AppTextStyle.title14normal(),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' + จัดตั้งหน่วยชั่งเคลื่อนที่ใหม่ ',
                          style: AppTextStyle.title14bold(),
                        ),
                        TextSpan(
                          text: 'เพื่อดำเนินการต่อ',
                          style: AppTextStyle.title14normal(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
