import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../app/routes/routes.dart';
import '../../../../data/models/establish/mobile_car_model.dart';
import '../../../../data/repo/repo.dart';
import '../../../../utils/constants/text_style.dart';
import '../../../../utils/libs/string_helper.dart';
import '../../../../utils/widgets/tag_car_over_weight_widget.dart';

class CarItemWidget extends StatefulWidget {
  const CarItemWidget({
    super.key,
    required this.item,
    this.isShowArrest,
  });

  final MobileCarModel item;
  final bool? isShowArrest;

  @override
  State<CarItemWidget> createState() => _CarItemWidgetState();
}

class _CarItemWidgetState extends State<CarItemWidget> {
  bool _isLoading = false;

  void getPdf(String arrestId) async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // ใช้ repo เพื่อดึง PDF URL
      final pdfUrl = arrestRepo.getArrestLogsPdfUrl(arrestId);

      // นำทางไปยังหน้าแสดง PDF
      Routes.gotoPreviewFile(
        context: context,
        url: pdfUrl,
        fileName: 'บันทึกจับกุม_${widget.item.tdId}.pdf',
      );
    } catch (e) {
      // แสดง error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('ไม่สามารถเปิดเอกสารได้: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    MobileCarModel item = widget.item;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.tertiaryContainer,
          ),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 5),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '${StringHleper.checkString(item.lpHeadNo)} ${StringHleper.checkString(item.lpHeadProvinceName)}',
                          style: AppTextStyle.title16bold(),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
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
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            return Image.asset(
                              'assets/images/icon_placeholder_car.png',
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TagCarOverWeightWidget(
                                isOverWeight:
                                    StringHleper.checkString(item.isOverWeight),
                                isOverWeightDesc: StringHleper.checkString(
                                    item.isOverWeightDesc),
                              ),
                              if (widget.isShowArrest != null &&
                                  item.isArrested != null &&
                                  item.isArrested == 1)
                                GestureDetector(
                                  onTap: _isLoading
                                      ? null
                                      : () {
                                          getPdf(
                                              widget.item.arrestId.toString());
                                        },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _isLoading
                                          ? Colors.grey[300]
                                          : Theme.of(context)
                                              .colorScheme
                                              .surface,
                                      borderRadius: BorderRadius.circular(5.r),
                                      border: Border.all(
                                        color: _isLoading
                                            ? Colors.grey
                                            : Theme.of(context)
                                                .colorScheme
                                                .primary,
                                      ),
                                    ),
                                    margin: const EdgeInsets.only(bottom: 6.0),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 4),
                                    child: Center(
                                      child: _isLoading
                                          ? SizedBox(
                                              width: 16,
                                              height: 16,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ),
                                            )
                                          : Text(
                                              'ดูบันทึกการจับกุม',
                                              style: AppTextStyle.title14bold(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/svg/ph_truck.svg',
                                width: 20.h,
                              ),
                              SizedBox(
                                width: 5.h,
                              ),
                              Expanded(
                                child: Text(
                                  StringHleper.checkString(
                                      item.vehicleClassDesc),
                                  style: AppTextStyle.title14normal(),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/svg/ant-design_calendar-outlined.svg',
                                width: 20.h,
                              ),
                              SizedBox(
                                width: 5.h,
                              ),
                              Expanded(
                                child: Text(
                                  StringHleper.convertTimeThai(
                                      item.createDate.toString()),
                                  style: AppTextStyle.title14normal(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('น้ำหนักที่ชั่งรวม',
                          style: AppTextStyle.title16bold()),
                      SizedBox(
                        width: 5.h,
                      ),
                      Text(
                        '${StringHleper.convertStringToKilo(item.grossWeight)} กิโลกรัม',
                        style: AppTextStyle.title16bold(),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4.h),
                  child: Row(
                    children: [
                      Text(
                        'น้ำหนักตามกฎหมายกำหนด ${StringHleper.convertStringToKilo(item.legalWeight)} กิโลกรัม',
                        style: AppTextStyle.title14normal(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
