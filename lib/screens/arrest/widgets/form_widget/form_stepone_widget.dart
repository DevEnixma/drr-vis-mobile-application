import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wts_bloc/utils/constants/color_app.dart';
import 'package:wts_bloc/utils/libs/convert_date.dart';

import '../../../../blocs/arrest/arrest_bloc.dart';
import '../../../../blocs/master_data/province_master/province_master_bloc.dart';
import '../../../../data/models/arrest/arrest_form/arrest_form_step_one.dart';
import '../../../../data/models/arrest/arrest_log_detail_model_res.dart';
import '../../../../data/models/establish/mobile_car_model.dart';
import '../../../../data/models/master_data/address/districts_model.dart';
import '../../../../data/models/master_data/address/sub_districts_model.dart';
import '../../../../data/models/master_data/province/province_master_data_res.dart';
import '../../../../main.dart';
import '../../../../utils/constants/text_style.dart';
import '../../../../utils/libs/string_helper.dart';
import '../../../../utils/widgets/buttom_sheet_widget/custom_province_bottom_sheet2.dart';
import '../../../../utils/widgets/custom_button.dart';
import '../../../../utils/widgets/inputs/dropdown_input_custom_widget.dart';
import '../../../../utils/widgets/inputs/label_input_widget.dart';
import '../../../../utils/widgets/inputs/text_input_widget.dart';
import '../../../../utils/widgets/inputs/title_widget.dart';

class FormSteponeWidget extends StatefulWidget {
  const FormSteponeWidget({
    super.key,
    required this.onStepSubmitForm,
    required this.onStepFormBack,
    required this.item,
  });

  final Function(String) onStepSubmitForm;
  final Function(String) onStepFormBack;
  final MobileCarModel item;

  @override
  State<FormSteponeWidget> createState() => _FormSteponeWidgetState();
}

class _FormSteponeWidgetState extends State<FormSteponeWidget> {
  final newFormKey = GlobalKey<FormState>();

  final TextEditingController recordNumberController = TextEditingController();
  final FocusNode recordNumberFocusNode = FocusNode();

  final TextEditingController recordLocationController = TextEditingController();
  final FocusNode recordLocationFocusNode = FocusNode();

  final TextEditingController recordDateController = TextEditingController();
  final FocusNode recordDateFocusNode = FocusNode();

  final TextEditingController recordTimeController = TextEditingController();
  final FocusNode recordTimeFocusNode = FocusNode();

  final TextEditingController witnessFullNameController = TextEditingController();
  final FocusNode witnessFullNameFocusNode = FocusNode();
  final TextEditingController witnessRaceController = TextEditingController();
  final FocusNode witnessRaceFocusNode = FocusNode();
  final TextEditingController witnessNationalityController = TextEditingController();
  final FocusNode witnessNationalityFocusNode = FocusNode();
  final TextEditingController witnessoccupationController = TextEditingController();
  final FocusNode witnessoccupationFocusNode = FocusNode();
  final TextEditingController witnessAddressNoController = TextEditingController();
  final FocusNode witnessAddressNoFocusNode = FocusNode();
  final TextEditingController witnessAddressMooController = TextEditingController();
  final FocusNode witnessAddressMooFocusNode = FocusNode();
  final TextEditingController witnessAddressRoadController = TextEditingController();
  final FocusNode witnessAddressRoadFocusNode = FocusNode();
  final TextEditingController witnessAddressSoiController = TextEditingController();
  final FocusNode witnessAddressSoiFocusNode = FocusNode();
  final TextEditingController witnessPhoneNumberController = TextEditingController();
  final FocusNode witnessPhoneNumberFocusNode = FocusNode();

  final TextEditingController subdistrictController = TextEditingController();
  final FocusNode subdistrictFocusNode = FocusNode();
  final TextEditingController districtController = TextEditingController();
  final FocusNode districtFocusNode = FocusNode();
  final TextEditingController provinceController = TextEditingController();
  final FocusNode provinceFocusNode = FocusNode();

  String recordNumber = 'เลขที่บันทึก';
  String recordLocation = 'สถานที่บันทึก';
  String recordDate = 'วันที่บันทึก';
  String recordTime = 'วันนี้เวลา ประมาณ';

  // ข้อมูลผู้ต้องหา
  String witnessFullName = 'ชื่อ - นามสกุล';
  String witnessRace = 'เชื้อชาติ';
  String witnessNationality = 'สัญชาติ';
  String witnessoccupation = 'อาชีพ';
  String witnessAddressNo = 'บ้านเลขที่';
  String witnessAddressMoo = 'หมู่ที่';
  String witnessAddressRoad = 'ถนน';
  String witnessAddressSoi = 'ตรอก/ซอย';

  String witnessPhoneNumber = 'โทรศัพท์';

  String subDistrict = 'ตำบล/แขวง';
  String district = 'อำเภอ/เขต';
  String provinces = 'จังหวัด';

  List<ProvinceMasterDataModel>? province = [];
  List<DistrictsMasterDataModel>? _district = [];
  List<SubDistrictsMasterDataModel>? _subDistrict = [];

  String provinceId = '';
  String districtId = '';
  String subDistrictId = '';

  bool districtDisable = true;
  bool subDistrictDisable = true;

  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();

    initScreenData();
  }

  void initScreenData() async {
    getProvince('');
    onTextChange('init', 'init');

    updateData();
  }

  void updateData() async {
    if (context.read<ArrestBloc>().state.arrestLogDetail != null && context.read<ArrestBloc>().state.arrestLogDetail!.recordNo != null) {
      ArrestLogDetailModelRes itemUpdate = context.read<ArrestBloc>().state.arrestLogDetail!;

      recordNumberController.text = itemUpdate.recordNo ?? '';
      recordLocationController.text = itemUpdate.recordLocation ?? '';
      witnessFullNameController.text = itemUpdate.witnessFullname ?? '';
      witnessRaceController.text = itemUpdate.witnessRace ?? '';
      witnessNationalityController.text = itemUpdate.witnessNationality ?? '';
      witnessoccupationController.text = itemUpdate.witnessOcupation ?? '';
      witnessAddressNoController.text = itemUpdate.addressNo ?? '';
      witnessAddressMooController.text = itemUpdate.addressMoo ?? '';
      witnessAddressRoadController.text = itemUpdate.addressRoad ?? '';
      witnessAddressSoiController.text = itemUpdate.addressSoi ?? '';
      witnessPhoneNumberController.text = itemUpdate.phoneNumber ?? '';

      subdistrictController.text = itemUpdate.subDistrict ?? '';
      districtController.text = itemUpdate.district ?? '';
      provinceController.text = itemUpdate.province ?? '';

      List<String> timeSave = StringHleper.splitData(itemUpdate.recordTime.toString(), ':');
      recordTimeController.text = '${timeSave[0]}:${timeSave[1]}';

      selectedDate = ConvertDate.stringToDateYYYYMMDD(itemUpdate.recordDate.toString());
      recordDateController.text = ConvertDate.convertDateToDDMMMMYYYY(ConvertDate.stringToDateYYYYMMDD(itemUpdate.recordDate.toString()));

      // if (itemUpdate.provinceId != null) {
      //   getProvince(itemUpdate.provinceId!.toString());
      // }

      if (itemUpdate.districtId != null) {
        getDistrictMaster(itemUpdate.districtId!.toString());
      }

      if (itemUpdate.subDistrictId != null) {
        getSubDistrictMaster(itemUpdate.subDistrictId!.toString());
      }

      setState(() {});
      onTextChange(subdistrictController.text, subDistrict);
    }
  }

  void getProvince(String value) {
    context.read<ProvinceMasterBloc>().add(GetProvinceMaster(value));
  }

  void getDistrictMaster(String value) {
    context.read<ProvinceMasterBloc>().add(GetDistrictMaster(value, provinceId));
  }

  void getSubDistrictMaster(String value) {
    context.read<ProvinceMasterBloc>().add(GetSubDistrictMaster(value, districtId));
  }

  void onSelectItem(dynamic item, String label) async {
    if (label == 'provinceMasterData') {
      if (item is ProvinceMasterDataModel) {
        setState(() {
          provinceId = item.id.toString();
          districtDisable = false;
          subDistrictDisable = true;
          districtController.text = '';
          subdistrictController.text = '';
        });

        provinceController.text = item.nameTh!;
        onTextChange(provinceController.text, provinces);
        getDistrictMaster('');
      } else {
        logger.e('Item is not of type ProvinceMasterDataModel');
      }
    }
    if (label == 'disctrictMasterData') {
      if (item is DistrictsMasterDataModel) {
        setState(() {
          districtId = item.id.toString();
          subDistrictDisable = false;
          subdistrictController.text = '';
        });

        districtController.text = item.nameTh!;
        onTextChange(districtController.text, district);
        getSubDistrictMaster('');
      } else {
        logger.e('Item is not of type DistrictsMasterDataModel');
      }
    }
    if (label == 'subDisctrictMasterData') {
      if (item is SubDistrictsMasterDataModel) {
        setState(() {
          subDistrictId = item.id.toString();
        });

        subdistrictController.text = item.nameTh!;
        onTextChange(subdistrictController.text, subDistrict);
      } else {
        logger.e('Item is not of type SubDistrictsMasterDataModel');
      }
    }
  }

  void onTextChange(String value, String nameInput) {
    var payload = ArrestFormStepOneReq(
      tdid: widget.item.tdId,
      recordNo: recordNumberController.text,
      recordLocation: recordLocationController.text,
      recordDate: selectedDate != null ? ConvertDate.convertDateToYYYYDDMM(selectedDate!) : '',
      recordTime: recordTimeController.text != '' ? '${recordTimeController.text}:00' : '',
      witnessFullname: witnessFullNameController.text,
      witnessRace: witnessRaceController.text,
      witnessNationality: witnessNationalityController.text,
      witnessOcupation: witnessoccupationController.text,
      addressNo: witnessAddressNoController.text,
      addressMoo: witnessAddressMooController.text,
      addressRoad: witnessAddressRoadController.text,
      addressSoi: witnessAddressSoiController.text,
      subDistrict: subDistrictId != '' ? int.parse(subDistrictId) : null,
      district: districtId != '' ? int.parse(districtId) : null,
      province: provinceId != '' ? int.parse(provinceId) : null,
      phoneNumber: witnessPhoneNumberController.text,
    );

    context.read<ArrestBloc>().add(StepOneFormEvent(payload));
  }

  void validateForm() {
    // if (newFormKey.currentState!.validate()) {
    //   widget.onStepSubmitForm('step_one');
    // }
    widget.onStepSubmitForm('step_one');
  }

  void onStepFormBack() {
    widget.onStepFormBack('step_two');
  }

  @override
  void dispose() {
    super.dispose();

    recordNumberController.dispose();
    recordNumberFocusNode.dispose();

    recordLocationController.dispose();
    recordLocationFocusNode.dispose();

    recordDateController.dispose();
    recordDateFocusNode.dispose();

    recordTimeController.dispose();
    recordTimeFocusNode.dispose();

    witnessFullNameController.dispose();
    witnessFullNameFocusNode.dispose();
    witnessRaceController.dispose();
    witnessRaceFocusNode.dispose();
    witnessNationalityController.dispose();
    witnessNationalityFocusNode.dispose();
    witnessoccupationController.dispose();
    witnessoccupationFocusNode.dispose();
    witnessAddressNoController.dispose();
    witnessAddressNoFocusNode.dispose();
    witnessAddressMooController.dispose();
    witnessAddressMooFocusNode.dispose();
    witnessAddressRoadController.dispose();
    witnessAddressRoadFocusNode.dispose();
    witnessAddressSoiController.dispose();
    witnessAddressSoiFocusNode.dispose();
    witnessPhoneNumberController.dispose();
    witnessPhoneNumberFocusNode.dispose();

    subdistrictController.dispose();
    subdistrictFocusNode.dispose();
    districtController.dispose();
    districtFocusNode.dispose();
    provinceController.dispose();
    provinceFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(12.h),
          child: Form(
            key: newFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabelInputWidget(
                        title: recordNumber,
                        // isRequired: true,
                      ),
                      TextInputWidget(
                        label: recordNumber,
                        hint: recordNumber,
                        controller: recordNumberController,
                        focusNode: recordNumberFocusNode,
                        onTextChange: onTextChange,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabelInputWidget(
                        title: recordLocation,
                        // isRequired: true,
                      ),
                      TextInputWidget(
                        label: recordLocation,
                        hint: recordLocation,
                        controller: recordLocationController,
                        focusNode: recordLocationFocusNode,
                        onTextChange: onTextChange,
                      ),
                    ],
                  ),
                ),
                AutoSizeText(
                  'บันทึกนี้ทำไว้เป็นหลักฐานเพื่อแสดงว่า',
                  style: AppTextStyle.title14normal(),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabelInputWidget(
                        title: recordDate,
                        // isRequired: true,
                      ),
                      GestureDetector(
                        onTap: () async {
                          DateTime? pickedDate = await showRoundedDatePicker(
                            context: context,
                            locale: Locale("th", "TH"),
                            era: EraMode.BUDDHIST_YEAR,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            borderRadius: 16,
                            theme: ThemeData(primaryColor: ColorApps.colorMain),
                            styleDatePicker: MaterialRoundedDatePickerStyle(
                              textStyleDayButton: TextStyle(fontSize: 36, color: Colors.white),
                              textStyleYearButton: TextStyle(
                                fontSize: 36,
                                color: Colors.white,
                              ),
                              textStyleDayHeader: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              decorationDateSelected: BoxDecoration(color: ColorApps.colorGrayBoxShadow, shape: BoxShape.circle),
                              textStyleDayOnCalendarSelected: TextStyle(fontSize: 16, color: ColorApps.colorMain, fontWeight: FontWeight.bold),
                              textStyleButtonPositive: TextStyle(fontSize: 16, color: ColorApps.colorMain, fontWeight: FontWeight.bold),
                              textStyleButtonNegative: TextStyle(fontSize: 16, color: ColorApps.colorGray, fontWeight: FontWeight.bold),
                            ),
                          );

                          if (pickedDate != null) {
                            setState(() {
                              selectedDate = pickedDate;
                              recordDateController.text = ConvertDate.convertDateToDDMMMMYYYY(pickedDate);
                            });
                            onTextChange(pickedDate.toString(), recordDate);
                          }
                        },
                        child: TextInputWidget(
                          label: recordDate,
                          hint: recordDate,
                          controller: recordDateController,
                          focusNode: recordDateFocusNode,
                          isDisable: true,
                          isShowIconError2: true,
                          isSuffixIcon: true,
                          iconName: Icons.calendar_today,
                          iconColor: ColorApps.colorGray,
                          isDisableBgColor: ColorApps.colorBackground,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabelInputWidget(
                        title: recordTime,
                        // isRequired: true,
                      ),
                      GestureDetector(
                        onTap: () async {
                          final timePicked = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                            builder: (BuildContext context, Widget? child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  timePickerTheme: TimePickerThemeData(
                                    backgroundColor: ColorApps.colorWhite, // Background color
                                    hourMinuteTextColor: ColorApps.colorMain, // Text color for hours and minutes
                                    dayPeriodTextColor: ColorApps.colorGreen, // Text color for AM/PM
                                    dayPeriodBorderSide: BorderSide(color: ColorApps.colorMain), // Border color for AM/PM
                                    dialHandColor: ColorApps.colorDisable, // Color of the hour hand
                                    dialTextColor: ColorApps.colorMain, // Text color on the clock dial
                                    dialBackgroundColor: ColorApps.colorGrayBoxShadow,
                                    dayPeriodColor: ColorApps.colorGrayBoxShadow,
                                    hourMinuteColor: ColorApps.colorGrayBoxShadow,
                                    entryModeIconColor: ColorApps.colorMain,
                                    cancelButtonStyle: ButtonStyle(backgroundColor: WidgetStateProperty.all<Color>(ColorApps.colorGray), foregroundColor: WidgetStateProperty.all<Color>(ColorApps.colorMain)),
                                    confirmButtonStyle: ButtonStyle(backgroundColor: WidgetStateProperty.all<Color>(ColorApps.colorMain), foregroundColor: WidgetStateProperty.all<Color>(ColorApps.colorWhite)),
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );

                          if (timePicked != null) {
                            setState(() {
                              recordTimeController.text = "${timePicked.hour.toString().padLeft(2, '0')}:${timePicked.minute.toString().padLeft(2, '0')}";
                            });
                            onTextChange('${timePicked.hour.toString().padLeft(2, '0')}:${timePicked.minute.toString().padLeft(2, '0')}', recordTime);
                          }
                        },
                        child: TextInputWidget(
                          label: recordTime,
                          hint: recordTime,
                          controller: recordTimeController,
                          focusNode: recordTimeFocusNode,
                          isDisable: true,
                          isShowIconError2: true,
                          isSuffixIcon: true,
                          iconName: Icons.schedule,
                          iconColor: ColorApps.colorGray,
                          isDisableBgColor: ColorApps.colorBackground,
                        ),
                      ),
                    ],
                  ),
                ),
                AutoSizeText(
                  'เจ้าพนักงานทางหลวง ผู้มีรายชื่อท้ายบันทึกนี้ได้ร่วมกันจับกุม',
                  style: AppTextStyle.title14normal(),
                ),
                Divider(
                  color: ColorApps.colorGray,
                ),
                TitleWidget(
                  title: 'ข้อมูลผู้ต้องหา',
                  icon: Icons.person,
                ),
                SizedBox(height: 12.0.h),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabelInputWidget(
                        title: witnessFullName,
                        // isRequired: true,
                      ),
                      TextInputWidget(
                        label: witnessFullName,
                        hint: witnessFullName,
                        controller: witnessFullNameController,
                        focusNode: witnessFullNameFocusNode,
                        onTextChange: onTextChange,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabelInputWidget(
                        title: witnessRace,
                        // isRequired: true,
                      ),
                      TextInputWidget(
                        label: witnessRace,
                        hint: witnessRace,
                        controller: witnessRaceController,
                        focusNode: witnessRaceFocusNode,
                        onTextChange: onTextChange,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabelInputWidget(
                        title: witnessNationality,
                        // isRequired: true,
                      ),
                      TextInputWidget(
                        label: witnessNationality,
                        hint: witnessNationality,
                        controller: witnessNationalityController,
                        focusNode: witnessNationalityFocusNode,
                        onTextChange: onTextChange,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabelInputWidget(
                        title: witnessoccupation,
                        // isRequired: true,
                      ),
                      TextInputWidget(
                        label: witnessoccupation,
                        hint: witnessoccupation,
                        controller: witnessoccupationController,
                        focusNode: witnessoccupationFocusNode,
                        onTextChange: onTextChange,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabelInputWidget(
                        title: witnessAddressNo,
                        // isRequired: true,
                      ),
                      TextInputWidget(
                        label: witnessAddressNo,
                        hint: witnessAddressNo,
                        controller: witnessAddressNoController,
                        focusNode: witnessAddressNoFocusNode,
                        onTextChange: onTextChange,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabelInputWidget(
                        title: witnessAddressMoo,
                        // isRequired: true,
                      ),
                      TextInputWidget(
                        label: witnessAddressMoo,
                        hint: witnessAddressMoo,
                        controller: witnessAddressMooController,
                        focusNode: witnessAddressMooFocusNode,
                        onTextChange: onTextChange,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabelInputWidget(
                        title: witnessAddressRoad,
                        // isRequired: true,
                      ),
                      TextInputWidget(
                        label: witnessAddressRoad,
                        hint: witnessAddressRoad,
                        controller: witnessAddressRoadController,
                        focusNode: witnessAddressRoadFocusNode,
                        onTextChange: onTextChange,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabelInputWidget(
                        title: witnessAddressSoi,
                        // isRequired: true,
                      ),
                      TextInputWidget(
                        label: witnessAddressSoi,
                        hint: witnessAddressSoi,
                        controller: witnessAddressSoiController,
                        focusNode: witnessAddressSoiFocusNode,
                        onTextChange: onTextChange,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelInputWidget(
                      title: provinces,
                      // isRequired: true,
                    ),
                    BlocListener<ProvinceMasterBloc, ProvinceMasterState>(
                      listener: (context, state) {
                        if (state.provinceMasterStatus == ProvinceMasterStatus.success) {
                          if (state.provinceMaster != null && state.provinceMaster!.isNotEmpty) {
                            province = state.provinceMaster!;
                          } else {
                            province = [];
                          }
                        }
                      },
                      child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                        },
                        child: DropdownInputCustomWidget(
                          label: "Text Input 1",
                          hint: provinces,
                          controller: provinceController,
                          focusNode: provinceFocusNode,
                          onTap: () => {
                            FocusScope.of(context).unfocus(),
                            showModalBottomSheet(
                              backgroundColor: Theme.of(context).colorScheme.surface,
                              context: context,
                              isScrollControlled: true,
                              constraints: BoxConstraints(
                                minWidth: MediaQuery.of(context).size.width,
                              ),
                              builder: (BuildContext context) {
                                return DraggableScrollableSheet(
                                  initialChildSize: 0.6,
                                  minChildSize: 0.6,
                                  maxChildSize: 0.8,
                                  expand: false,
                                  builder: (BuildContext context, ScrollController scrollController) {
                                    return CustomModalBottomSheet2(
                                      data_list: province!,
                                      scrollController: scrollController,
                                      title: provinces,
                                      label: 'provinceMasterData',
                                      onSelectItem: onSelectItem,
                                      onClose: (result) {
                                        Navigator.pop(context, result);
                                      },
                                    );
                                  },
                                );
                              },
                            ).then((onValue) {
                              getProvince('');
                            })
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 12.w),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelInputWidget(
                      title: district,
                      // isRequired: true,
                    ),
                    BlocListener<ProvinceMasterBloc, ProvinceMasterState>(
                      listener: (context, state) {
                        if (state.districtsMasterStatus == DistrictsMasterStatus.success) {
                          if (state.districtsMaster != null && state.districtsMaster!.isNotEmpty) {
                            _district = state.districtsMaster!;
                          } else {
                            _district = [];
                          }
                        }
                      },
                      child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                        },
                        child: DropdownInputCustomWidget(
                          label: "Text Input 1",
                          hint: district,
                          controller: districtController,
                          isDisable: districtDisable,
                          focusNode: districtFocusNode,
                          onTap: () => {
                            FocusScope.of(context).unfocus(),
                            if (!districtDisable)
                              {
                                showModalBottomSheet(
                                  backgroundColor: Theme.of(context).colorScheme.surface,
                                  context: context,
                                  isScrollControlled: true,
                                  constraints: BoxConstraints(
                                    minWidth: MediaQuery.of(context).size.width,
                                  ),
                                  builder: (BuildContext context) {
                                    return DraggableScrollableSheet(
                                      initialChildSize: 0.6,
                                      minChildSize: 0.6,
                                      maxChildSize: 0.8,
                                      expand: false,
                                      builder: (BuildContext context, ScrollController scrollController) {
                                        return CustomModalBottomSheet2(
                                          data_list: _district!,
                                          scrollController: scrollController,
                                          title: district,
                                          label: 'disctrictMasterData',
                                          onSelectItem: onSelectItem,
                                          keyRelation: provinceId,
                                          onClose: (result) {
                                            Navigator.pop(context, result);
                                          },
                                        );
                                      },
                                    );
                                  },
                                ).then((onValue) {
                                  getDistrictMaster('');
                                })
                              }
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 12.w),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelInputWidget(
                      title: subDistrict,
                      // isRequired: true,
                    ),
                    BlocListener<ProvinceMasterBloc, ProvinceMasterState>(
                      listener: (context, state) {
                        if (state.subDistrictsMasterStatus == SubDistrictsMasterStatus.success) {
                          if (state.subDistrictsMaster != null && state.subDistrictsMaster!.isNotEmpty) {
                            _subDistrict = state.subDistrictsMaster!;
                          } else {
                            _subDistrict = [];
                          }
                        }
                      },
                      child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                        },
                        child: DropdownInputCustomWidget(
                          label: "Text Input 1",
                          hint: subDistrict,
                          controller: subdistrictController,
                          isDisable: subDistrictDisable,
                          focusNode: subdistrictFocusNode,
                          onTap: () => {
                            FocusScope.of(context).unfocus(),
                            if (!subDistrictDisable)
                              {
                                showModalBottomSheet(
                                  backgroundColor: Theme.of(context).colorScheme.surface,
                                  context: context,
                                  isScrollControlled: true,
                                  constraints: BoxConstraints(
                                    minWidth: MediaQuery.of(context).size.width,
                                  ),
                                  builder: (BuildContext context) {
                                    return DraggableScrollableSheet(
                                      initialChildSize: 0.6,
                                      minChildSize: 0.6,
                                      maxChildSize: 0.8,
                                      expand: false,
                                      builder: (BuildContext context, ScrollController scrollController) {
                                        return CustomModalBottomSheet2(
                                          data_list: _subDistrict!,
                                          scrollController: scrollController,
                                          title: subDistrict,
                                          label: 'subDisctrictMasterData',
                                          onSelectItem: onSelectItem,
                                          keyRelation: districtId,
                                          onClose: (result) {
                                            Navigator.pop(context, result);
                                          },
                                        );
                                      },
                                    );
                                  },
                                ).then((onValue) {
                                  getSubDistrictMaster('');
                                })
                              }
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 12.w),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabelInputWidget(
                        title: witnessPhoneNumber,
                        // isRequired: true,
                      ),
                      TextInputWidget(
                        label: witnessPhoneNumber,
                        hint: witnessPhoneNumber,
                        controller: witnessPhoneNumberController,
                        focusNode: witnessPhoneNumberFocusNode,
                        onTextChange: onTextChange,
                        keyBoardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      color: Theme.of(context).colorScheme.surface,
                      padding: EdgeInsets.symmetric(horizontal: 18.h, vertical: 12.h),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextButton(
                              onPressed: () {
                                onStepFormBack();
                              },
                              child: Text(
                                'ย้อนกลับ',
                                style: AppTextStyle.title18bold(color: Theme.of(context).colorScheme.primary),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: CustomeButton(
                              text: 'ต่อไป >',
                              onPressed: () {
                                setState(() {
                                  validateForm();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: 80.0.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
