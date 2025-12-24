import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app/routes/routes.dart';
import '../../../blocs/establish/establish_bloc.dart';
import '../../../data/models/establish/mobile_master_model.dart';
import '../../../local_storage.dart';
import '../../../utils/constants/key_localstorage.dart';
import '../../../utils/constants/text_style.dart';
import '../../../utils/libs/string_helper.dart';
import '../../../utils/widgets/sneckbar_message.dart';
import '../../establish/establish_unit/widgets/custom_bottom_sheet_widget.dart';

class CardWeightUnitWidget extends StatefulWidget {
  const CardWeightUnitWidget({
    super.key,
    required this.item,
    required this.isJoinItem,
    required this.userIsJoin,
    required this.isActionJoin,
  });

  final MobileMasterModel item;
  final bool isJoinItem;
  final bool userIsJoin;
  final Function(String, bool) isActionJoin;

  @override
  State<CardWeightUnitWidget> createState() => _CardWeightUnitWidgetState();
}

class _CardWeightUnitWidgetState extends State<CardWeightUnitWidget> {
  bool processJoin = false;
  bool isJoinSuccess = false;
  bool isLeaveJoinSuccess = false;

  String isJoinItemMsg = '';

  @override
  void initState() {
    super.initState();
  }

  void onJoinWeightUnit(String weightUnitId, bool join) async {
    widget.isActionJoin(weightUnitId, join);
  }

  void goToWeightUnitDetail() {
    if (widget.isJoinItem) {
      Routes.gotoWeightUnitDetailsScreen(context, widget.item.tID.toString());
    }
  }

  void clearJoinProcess() {
    if (mounted) {
      context.read<EstablishBloc>().add(ClearPostJoinWeightUnit());
    }
  }

  void showError(String errorMsg) {
    if (!processJoin && errorMsg != isJoinItemMsg) {
      if (mounted) {
        showSnackbarBottom(context, errorMsg);
      }
      clearJoinProcess();
    }
    if (mounted) {
      setState(() {
        processJoin = true;
        isJoinItemMsg = errorMsg;
      });
    }
  }

  Future<void> clearUnitID() async {
    final LocalStorage storage = LocalStorage();
    await storage.setValueString(KeyLocalStorage.weightUnitId, '');
  }

  Future<void> funcIsJoinWeightUnit() async {
    if (!mounted) return;

    context.read<EstablishBloc>().add(ClearPostJoinWeightUnit());

    widget.isActionJoin('isActionJoin', isJoinSuccess);

    // ไปที่หน้ารายละเอียด
    if (mounted) {
      Routes.gotoWeightUnitDetailsScreen(context, widget.item.tID.toString());
    }

    // Reset flag หลังจากเสร็จสิ้น
    if (mounted) {
      setState(() {
        processJoin = false;
        isJoinSuccess = false;
      });
    }
  }

  Future<void> funcIsLeaveJoin() async {
    await clearUnitID();

    if (!mounted) return;

    context.read<EstablishBloc>().add(ClearPostJoinWeightUnit());
    widget.isActionJoin('isActionJoin', isLeaveJoinSuccess);

    if (mounted) {
      setState(() {
        isLeaveJoinSuccess = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isJoinItem = widget.isJoinItem;
    return GestureDetector(
      onTap: goToWeightUnitDetail,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 18.h),
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.tertiaryFixed,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 1, right: 10),
              child: SvgPicture.asset(
                'assets/svg/entypo_traffic-cone.svg',
                color: Theme.of(context).colorScheme.primary,
                width: 35.w,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          widget.item.wayID ?? '',
                          style: AppTextStyle.title20bold(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        AutoSizeText(
                          'ตั้งโดย ${StringHleper.checkString(widget.item.firstName)} ${StringHleper.checkString(widget.item.lastName)}',
                          style: AppTextStyle.title14normal(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        AutoSizeText(
                          'กม.ที่ ${StringHleper.checkString(widget.item.kMFrom)} ถึง ${StringHleper.checkString(widget.item.kMTo)}',
                          style: AppTextStyle.title14normal(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  if (!isJoinItem && !widget.userIsJoin)
                    Flexible(
                      flex: 2,
                      child: _buildJoinButton(context),
                    ),
                  if (isJoinItem)
                    Flexible(
                      flex: 3,
                      child: _buildLeaveButton(context),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /// ปุ่ม "เข้าร่วมหน่วยชั่ง"
  Widget _buildJoinButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _showCustomBottomSheetConfirm(context, widget.item),
      child: Container(
        padding: const EdgeInsets.only(top: 6, bottom: 4, left: 8, right: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 2.0,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: Text(
          'เข้าร่วมหน่วยชั่ง',
          style: AppTextStyle.title14bold(
            color: Theme.of(context).colorScheme.secondary,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  /// ปุ่ม "ออกจากหน่วยชั่ง"
  Widget _buildLeaveButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _showCustomBottomSheetChange(context, widget.item),
      child: Container(
        padding: const EdgeInsets.only(top: 6, bottom: 4, left: 8, right: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 2.0,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: Text(
          'ออกจากหน่วยชั่ง',
          style: AppTextStyle.title14bold(
            color: Theme.of(context).colorScheme.surface,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  /// Bottom Sheet สำหรับยืนยันการเข้าร่วม
  void _showCustomBottomSheetConfirm(
    BuildContext context,
    MobileMasterModel mobileMasterData,
  ) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width,
      ),
      builder: (BuildContext context) {
        return CustomBottomSheetWidget(
          icon: 'check_icon_shadow',
          title: 'ยืนยันการเข้าร่วม',
          message:
              'ท่านยืนยันที่จะเข้าร่วมสายทาง ${mobileMasterData.wayID} \nใช่หรือไม่ ?',
          onConfirm: () {
            Navigator.pop(context);
            onJoinWeightUnit(mobileMasterData.tID!, true);
          },
          onCancel: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  /// Bottom Sheet สำหรับยืนยันการออกจากหน่วย
  void _showCustomBottomSheetChange(
    BuildContext context,
    MobileMasterModel mobileMasterData,
  ) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width,
      ),
      builder: (BuildContext context) {
        return CustomBottomSheetWidget(
          icon: 'icon_exit',
          title: 'ออกจากหน่วยชั่ง',
          message:
              'ท่านยืนยันที่จะออกจากสายทาง ${mobileMasterData.wayID} ปัจจุบัน\nใช่หรือไม่ ?',
          onConfirm: () {
            Navigator.pop(context);
            onJoinWeightUnit(mobileMasterData.tID!, false);
          },
          onCancel: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
