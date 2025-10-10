import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wts_bloc/utils/libs/string_helper.dart';

import '../../../app/routes/routes.dart';
import '../../../data/models/establish/mobile_master_model.dart';
import '../../../utils/constants/color_app.dart';
import '../../../utils/constants/text_style.dart';

class ItemListWidget extends StatefulWidget {
  const ItemListWidget({
    super.key,
    required this.item,
  });

  final MobileMasterModel item;

  @override
  State<ItemListWidget> createState() => _ItemListWidgetState();
}

class _ItemListWidgetState extends State<ItemListWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Routes.gotoHistoryDetails(context, widget.item);
      },
      child: Padding(
        padding: EdgeInsets.all(8.0.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('สายทาง ${widget.item.wayID}', style: AppTextStyle.title16bold()),
                  Container(
                    decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(5.r), border: Border.all(color: Theme.of(context).colorScheme.primary)),
                    margin: const EdgeInsets.only(bottom: 6.0),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: Center(
                      child: Text('${StringHleper.convertDateThai(widget.item.createDate.toString(), 'dd MMMM yyyy')} ${widget.item.timeFrom}', style: AppTextStyle.title14bold(color: Theme.of(context).colorScheme.surface)),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 69.h,
                  width: 69.h,
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.tertiaryFixed,
                        blurRadius: 5,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.network(
                      widget.item.imagePath1 ?? '',
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                        return Image.asset(
                          'assets/images/app_logo.png',
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svg/tabler_map-pin.svg',
                          width: 20.h,
                        ),
                        SizedBox(
                          width: 5.h,
                        ),
                        Text('ที่อยู่ที่จัดตั้ง', style: AppTextStyle.title16normal()),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 220.w,
                          child: Text(
                            '${widget.item.wayName} ${widget.item.subdistrict} ${widget.item.district} ${widget.item.province}',
                            style: AppTextStyle.title16normal(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
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
                          'รถเข้าชั่ง (${StringHleper.numberAddComma(widget.item.total.toString())})',
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
                          'รถน้ำหนักเกิน (${StringHleper.numberAddComma(widget.item.totalOver.toString())})',
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
    );
  }
}
