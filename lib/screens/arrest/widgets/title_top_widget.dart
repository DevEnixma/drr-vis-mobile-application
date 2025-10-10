import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/establish/mobile_master_department_model.dart';
import '../../../utils/constants/text_style.dart';
import '../../../utils/libs/string_helper.dart';

class TitleTopWidget extends StatefulWidget {
  const TitleTopWidget({
    super.key,
    required this.constraints,
    required this.item,
    this.topWidget,
  });

  final BoxConstraints constraints;
  final MobileMasterDepartmentModel item;
  final double? topWidget;

  @override
  State<TitleTopWidget> createState() => _TitleTopWidgetState();
}

class _TitleTopWidgetState extends State<TitleTopWidget> {
  @override
  Widget build(BuildContext context) {
    BoxConstraints constraints = widget.constraints;
    MobileMasterDepartmentModel item = widget.item;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF314188), Color(0xFF1F2E6F)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: widget.topWidget ?? 50.h,
                  ),
                  // constraints.maxWidth > 400 && constraints.maxWidth < 600
                  //     ? SizedBox(
                  //         height: 50.h,
                  //       )
                  //     : SizedBox(
                  //         height: 50.h,
                  //       ),
                  Text(
                    StringHleper.checkString(item.wayId),
                    style: AppTextStyle.header22bold(color: Theme.of(context).colorScheme.surface),
                  ),
                  Row(
                    children: [
                      Text(
                        'จัดตั้งโดย:',
                        style: AppTextStyle.title16bold(color: Theme.of(context).colorScheme.surface),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        '${StringHleper.checkString(item.firstName)} ${StringHleper.checkString(item.lastName)}',
                        style: AppTextStyle.title16normal(color: Theme.of(context).colorScheme.surface),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'กม.ที่:',
                        style: AppTextStyle.title16normal(color: Theme.of(context).colorScheme.surface),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Container(
                        // height: 30,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(32.r),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
                        child: Center(
                          child: Text(
                            item.kmFrom.toString(),
                            style: AppTextStyle.title16normal(color: Theme.of(context).colorScheme.surface),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        'ถึง',
                        style: AppTextStyle.title16normal(color: Theme.of(context).colorScheme.surface),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Container(
                        // height: 30,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(32.r),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
                        child: Center(
                          child: Text(
                            item.kmTo.toString(),
                            style: AppTextStyle.title16normal(color: Theme.of(context).colorScheme.surface),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Theme.of(context).colorScheme.tertiaryContainer, // You can change the color or thickness of the divider here
                    height: 1, // Height between items
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'ผู้ร่วมบูรณาการ',
                          style: AppTextStyle.title16bold(color: Theme.of(context).colorScheme.surface),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          item.collaboration.toString(),
                          style: AppTextStyle.title16normal(color: Theme.of(context).colorScheme.surface),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'ที่อยู่',
                          style: AppTextStyle.title16bold(color: Theme.of(context).colorScheme.surface),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          '${StringHleper.checkString(item.subDistrict)}, ${StringHleper.checkString(item.district)}, ${StringHleper.checkString(item.province)}',
                          style: AppTextStyle.title16normal(color: Theme.of(context).colorScheme.surface),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
