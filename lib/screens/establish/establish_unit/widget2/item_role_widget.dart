import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wts_bloc/utils/libs/string_helper.dart';

import '../../../../app/routes/routes.dart';
import '../../../../data/models/establish/mobile_master_model.dart';
import '../../../../utils/constants/color_app.dart';
import '../../../../utils/constants/text_style.dart';

class ItemRoleWidget extends StatefulWidget {
  const ItemRoleWidget({
    super.key,
    required this.item,
  });

  final MobileMasterModel item;

  @override
  State<ItemRoleWidget> createState() => _ItemRoleWidgetState();
}

class _ItemRoleWidgetState extends State<ItemRoleWidget> {
  void goToWeightUnitDetail() {
    Routes.gotoHistoryDetails(context, widget.item);
  }

  @override
  Widget build(BuildContext context) {
    MobileMasterModel item = widget.item;
    return GestureDetector(
      onTap: () {
        goToWeightUnitDetail();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: ColorApps.colorWhite,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000).withOpacity(0.12),
              offset: const Offset(0, 1), // เงาเลื่อนลง 1px
              blurRadius: 6, // เงาเบลอ
              spreadRadius: 0, // ไม่มีการขยายเงา
            ),
          ],
        ),
        child: Container(
          margin: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 1, right: 10),
                    child: SvgPicture.asset(
                      'assets/svg/entypo_traffic-cone.svg',
                      color: Theme.of(context).colorScheme.primary,
                      width: 25.w,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          StringHleper.checkString(item.wayID),
                          style: AppTextStyle.title18bold(color: ColorApps.colorMain),
                        ),
                        AutoSizeText(
                          'ตั้งโดย ${StringHleper.checkString(item.firstName)} ${StringHleper.checkString(item.lastName)}',
                          style: AppTextStyle.title14normal(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              AutoSizeText(
                '${StringHleper.checkString(item.subdistrict)}, ${StringHleper.checkString(item.district)}, ${StringHleper.checkString(item.province)}',
                style: AppTextStyle.title16normal(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              AutoSizeText(
                'กม.ที่ ${StringHleper.checkString(item.kMFrom)} ถึง กม.ที่ ${StringHleper.checkString(item.kMTo)}',
                style: AppTextStyle.title16normal(),
              ),
              Divider(color: ColorApps.grayBorder),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: SvgPicture.asset(
                            'assets/svg/iconamoon_news-fill.svg',
                            color: Theme.of(context).colorScheme.primary,
                            width: 20.h,
                          ),
                        ),
                        SizedBox(width: 5.h),
                        Flexible(
                          child: AutoSizeText(
                            'รถเข้าชั่ง (${StringHleper.numberAddComma(item.total.toString())})',
                            style: AppTextStyle.title16bold(color: Theme.of(context).colorScheme.primary),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 35.h,
                    width: 1.h,
                    color: ColorApps.grayBorder,
                    margin: EdgeInsets.symmetric(horizontal: 8.h),
                  ),
                  Flexible(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/svg/truck_icon.svg',
                          color: Theme.of(context).colorScheme.error,
                          width: 22.h,
                        ),
                        SizedBox(width: 5.h),
                        Flexible(
                          child: AutoSizeText(
                            'รถน้ำหนักเกิน (${StringHleper.numberAddComma(item.totalOver.toString())})',
                            style: AppTextStyle.title16bold(color: Theme.of(context).colorScheme.error),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
