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

  int page = 1;
  int pageSize = 20;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

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

  void clearJoinProcess() async {
    context.read<EstablishBloc>().add(ClearPostJoinWeightUnit());
  }

  void showError(String errorMsg) async {
    if (!processJoin && errorMsg != isJoinItemMsg) {
      showSnackbarBottom(context, errorMsg);
      clearJoinProcess();
    }
    setState(() {
      processJoin = true;
      isJoinItemMsg = errorMsg;
    });
  }

  void ClearUnitID() async {
    final LocalStorage storage = LocalStorage();
    await storage.setValueString(KeyLocalStorage.weightUnitId, '');
  }

  void funcIsJoinWeigthUnit() async {
    context.read<EstablishBloc>().add(ClearPostJoinWeightUnit());

    widget.isActionJoin('isActionJoin', isJoinSuccess);
    // ไปที่หน้ารายละเอียด
    Routes.gotoWeightUnitDetailsScreen(context, widget.item.tID.toString());

    // Reset flag หลังจากเสร็จสิ้น
    setState(() {
      processJoin = false;
      isJoinSuccess = false;
    });
  }

  void funcIsLeaveJoin() async {
    ClearUnitID();
    context.read<EstablishBloc>().add(ClearPostJoinWeightUnit());
    widget.isActionJoin('isActionJoin', isLeaveJoinSuccess);

    setState(() {
      isLeaveJoinSuccess = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isJoinItem = widget.isJoinItem;
    return GestureDetector(
      onTap: () {
        goToWeightUnitDetail();
      },
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
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 1, right: 10),
              child: SvgPicture.asset(
                'assets/svg/entypo_traffic-cone.svg',
                color: Theme.of(context).colorScheme.primary,
                width: 35.w,
              ),
            ),
            Expanded(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(widget.item.wayID ?? '', style: AppTextStyle.title20bold(color: Theme.of(context).colorScheme.primary)),
                            Container(
                              child: AutoSizeText(
                                'ตั้งโดย ${StringHleper.checkString(widget.item.firstName)} ${StringHleper.checkString(widget.item.lastName)}',
                                style: AppTextStyle.title14normal(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              child: AutoSizeText(
                                'กม.ที่ ${StringHleper.checkString(widget.item.kMFrom)} ถึง ${StringHleper.checkString(widget.item.kMTo)}',
                                style: AppTextStyle.title14normal(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (!isJoinItem && !widget.userIsJoin)
                      Flexible(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () {
                            showCustomBottomSheetConfirm(context, widget.item);
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 6, bottom: 4, left: 8, right: 8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            child: Text(
                              'เข้าร่วมหน่วยชั่ง',
                              style: AppTextStyle.title14bold(color: Theme.of(context).colorScheme.secondary),
                            ),
                          ),
                        ),
                      ),
                    if (isJoinItem)
                      Flexible(
                        flex: 3,
                        child: GestureDetector(
                          onTap: () {
                            showCustomBottomSheetChange(context, widget.item);
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 6, bottom: 4, left: 8, right: 8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            child: Text(
                              'ออกจากหน่วยชั่ง',
                              style: AppTextStyle.title14bold(color: Theme.of(context).colorScheme.surface),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showCustomBottomSheetConfirm(BuildContext context, MobileMasterModel mobileMasterData) {
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
          message: 'ท่านยืนยันที่จะเข้าร่วมสายทาง ${mobileMasterData.wayID} \nใช่หรือไม่ ?',
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

  void showCustomBottomSheetChange(BuildContext context, MobileMasterModel mobileMasterData) {
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
          message: 'ท่านยืนยันที่จะออกจากสายทาง ${mobileMasterData.wayID} ปัจจุบัน\nใช่หรือไม่ ?',
          onConfirm: () {
            Navigator.pop(context);
            onJoinWeightUnit(mobileMasterData.tID!, false);
            // Routes.gotoEstablishUnitDetails(context, mobileMasterData.tID);
          },
          onCancel: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
