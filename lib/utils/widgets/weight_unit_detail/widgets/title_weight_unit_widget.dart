import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/models/establish/mobile_master_department_model.dart';
import '../../../constants/text_style.dart';
import '../../../libs/string_helper.dart';

class TitleWeightUnitWidget extends StatefulWidget {
  const TitleWeightUnitWidget({
    super.key,
    required this.item,
    required this.constraints,
  });

  final BoxConstraints constraints;
  final MobileMasterDepartmentModel item;

  @override
  State<TitleWeightUnitWidget> createState() => _TitleWeightUnitWidgetState();
}

class _TitleWeightUnitWidgetState extends State<TitleWeightUnitWidget> {
  @override
  Widget build(BuildContext context) {
    MobileMasterDepartmentModel item = widget.item;
    BoxConstraints constraints = widget.constraints;
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
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // constraints.maxWidth > 400 && constraints.maxWidth < 600 ? SizedBox() : SizedBox(),

                  Text(
                    '${item.tid != '' ? item.tid : '-'}',
                    style: AppTextStyle.title20bold(color: Theme.of(context).colorScheme.surface),
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
                            '${item.kmFrom != '' ? item.kmFrom : '-'}',
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
                            '${item.kmTo != '' ? item.kmTo : '-'}',
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'ผู้ร่วมบูรณาการ4',
                          style: AppTextStyle.title16bold(color: Theme.of(context).colorScheme.surface),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          '${item.collaboration != '' ? item.collaboration : '-'}',
                          style: AppTextStyle.title16normal(color: Theme.of(context).colorScheme.surface),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
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
                          child: AutoSizeText(
                            '${StringHleper.checkString(item.subDistrict)}, ${StringHleper.checkString(item.district)}, ${StringHleper.checkString(item.province)}',
                            style: AppTextStyle.title16normal(color: Theme.of(context).colorScheme.surface),
                          ),
                        ),
                      ],
                    ),
                  ),

                  constraints.maxWidth > 400 && constraints.maxWidth < 600 ? SizedBox(height: 30.h) : SizedBox(height: 40.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
