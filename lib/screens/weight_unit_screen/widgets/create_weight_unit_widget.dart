import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants/text_style.dart';

class CreateWeightUnitWidget extends StatelessWidget {
  const CreateWeightUnitWidget({
    super.key,
    required this.addEstablishItem,
  });

  final Function(String) addEstablishItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Center(
        child: ElevatedButton.icon(
          onPressed: () async {
            addEstablishItem('getLocation');
          },
          icon: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.surface,
            size: 15.h,
          ),
          label: Text('จัดตั้งหน่วยใหม่', style: AppTextStyle.title14bold(color: Theme.of(context).colorScheme.surface)),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 4.h, bottom: 2.h),
            // padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 4.w),
            backgroundColor: Theme.of(context).colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
      ),
    );
  }
}
