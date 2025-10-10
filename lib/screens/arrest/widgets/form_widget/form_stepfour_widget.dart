import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../blocs/arrest/arrest_bloc.dart';
import '../../../../blocs/master_data/province_master/province_master_bloc.dart';
import '../../../../data/models/arrest/arrest_form/arrest_form_step_four.dart';
import '../../../../data/models/arrest/arrest_log_detail_model_res.dart';
import '../../../../data/models/master_data/address/districts_model.dart';
import '../../../../data/models/master_data/address/sub_districts_model.dart';
import '../../../../data/models/master_data/province/province_master_data_res.dart';
import '../../../../main.dart';
import '../../../../utils/constants/color_app.dart';
import '../../../../utils/constants/text_style.dart';
import '../../../../utils/libs/convert_date.dart';
import '../../../../utils/libs/string_helper.dart';
import '../../../../utils/widgets/buttom_sheet_widget/custom_province_bottom_sheet2.dart';
import '../../../../utils/widgets/custom_button.dart';
import '../../../../utils/widgets/inputs/dropdown_input_custom_widget.dart';
import '../../../../utils/widgets/inputs/label_input_widget.dart';
import '../../../../utils/widgets/inputs/text_input_widget.dart';
import '../../../../utils/widgets/titles/title_svg_widget.dart';

class FormStepfourWidget extends StatefulWidget {
  const FormStepfourWidget({
    super.key,
    required this.onStepSubmitForm,
    required this.onStepFormBack,
  });

  final Function(String) onStepSubmitForm;
  final Function(String) onStepFormBack;

  @override
  State<FormStepfourWidget> createState() => _FormStepfourWidgetState();
}

class _FormStepfourWidgetState extends State<FormStepfourWidget> {
  final newFormKey = GlobalKey<FormState>();

  final TextEditingController localeDuralRoadNoController = TextEditingController();
  final FocusNode localeDuralRoadNoFocusNode = FocusNode();
  final TextEditingController localeKmController = TextEditingController();
  final FocusNode localeKmFocusNode = FocusNode();
  final TextEditingController localeDateController = TextEditingController();
  final FocusNode localeDateFocusNode = FocusNode();
  final TextEditingController localeTimeController = TextEditingController();
  final FocusNode localeTimeFocusNode = FocusNode();

  final TextEditingController subdistrictController = TextEditingController();
  final FocusNode subdistrictFocusNode = FocusNode();
  final TextEditingController districtController = TextEditingController();
  final FocusNode districtFocusNode = FocusNode();
  final TextEditingController provinceController = TextEditingController();
  final FocusNode provinceFocusNode = FocusNode();

  final TextEditingController confessionDescController = TextEditingController();
  final FocusNode confessionDescFocusNode = FocusNode();
  final TextEditingController isTellLawProsecutorEmailController = TextEditingController();
  final FocusNode isTellLawProsecutorEmailFocusNode = FocusNode();
  final TextEditingController isTellLawProsecutorDateController = TextEditingController();
  final FocusNode isTellLawProsecutorDateFocusNode = FocusNode();

  final TextEditingController isTellLawProsecutorTimeController = TextEditingController();
  final FocusNode isTellLawProsecutorTimeFocusNode = FocusNode();

  final TextEditingController isTellLawProvincialAdminEmailController = TextEditingController();
  final FocusNode isTellLawProvincialAdminEmailFocusNode = FocusNode();
  final TextEditingController isTellLawProvincialAdminDateController = TextEditingController();
  final FocusNode isTellLawProvincialAdminDateFocusNode = FocusNode();

  final TextEditingController isTellLawProvincialAdminTimeController = TextEditingController();
  final FocusNode isTellLawProvincialAdminTimeFocusNode = FocusNode();

  final TextEditingController isNotRecordImageAndSoundDescController = TextEditingController();
  final FocusNode isNotRecordImageAndSoundDescFocusNode = FocusNode();
  final TextEditingController policeStationController = TextEditingController();
  final FocusNode policeStationFocusNode = FocusNode();
  final TextEditingController employerOwnerController = TextEditingController();
  final FocusNode employerOwnerFocusNode = FocusNode();
  final TextEditingController truckOwnerController = TextEditingController();
  final FocusNode truckOwnerFocusNode = FocusNode();
  final TextEditingController factoryDataController = TextEditingController();
  final FocusNode factoryDataFocusNode = FocusNode();

  // เหตุเกิดที่
  String localeDuralRoadNo = 'ทางหลวงชนบทหมายเลข';
  String localeKm = 'กม.';

  String localeDate = 'เมื่อวันที่';
  String localeTime = 'เวลา';

  DateTime? selectedLocalDate;
  DateTime? selectedTellLawProsecutorDate;
  DateTime? selectedTellLawProvincialAdminDate;

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

  bool isConfession = true;
  int isConfessionType = 1;
  String confessionDesc = 'อื่นๆ';

  bool isEvidence = false;
  bool isTorture = false;
  bool isTellLawProsecutor = false;
  String isTellLawProsecutorEmail = 'E-mail';
  String isTellLawProsecutorDate = 'เมื่อวันที่';

  bool isTellLawProvincialAdmin = false;
  String isTellLawProvincialAdminEmail = 'กรมการปกครอง';
  String isTellLawProvincialAdminDate = 'กรมการปกครอง เมื่อวันที่';

  bool isNotRecordImageAndSound = false;
  String isNotRecordImageAndSoundDesc = 'มีเหตุสุดวิสัย';

  String policeStation = 'สภ.';
  String employerOwner = 'ตรวจสอบข้อมูลของผู้ว่าจ้างขนส่ง';
  String truckOwner = 'ตรวจสอบข้อมูลของผู้ประกอบการขนส่งหรือเจ้าของรถ';
  String factoryData = 'ตรวจสอบข้อมูลโรงงานที่เป็นแหล่งวัสดุต่าง';

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
    if (context.read<ArrestBloc>().state.arrestLogDetail != null && context.read<ArrestBloc>().state.arrestLogDetail!.localeRuralRoadNo != null) {
      ArrestLogDetailModelRes itemUpdate = context.read<ArrestBloc>().state.arrestLogDetail!;

      localeDuralRoadNoController.text = itemUpdate.localeRuralRoadNo ?? '';
      localeKmController.text = itemUpdate.localeKm ?? '';

      subdistrictController.text = itemUpdate.localeSubDistrict ?? '';
      districtController.text = itemUpdate.localeDistrict ?? '';
      provinceController.text = itemUpdate.localeProvince ?? '';

      isConfessionType = itemUpdate.confesstion == 'อื่นๆ'
          ? 3
          : itemUpdate.confesstion == 'ผู้ต้องหาปฏิเสธข้อกล่าวหา'
              ? 2
              : 1;

      confessionDescController.text = itemUpdate.confesstionOther ?? '';
      isEvidence = itemUpdate.evidence == 1 ? true : false;
      isTorture = itemUpdate.torture == 1 ? true : false;
      isTellLawProsecutor = itemUpdate.tellLaw == 1 ? true : false;

      isTellLawProsecutorEmailController.text = itemUpdate.tellLawEmail ?? '';

      isTellLawProvincialAdmin = itemUpdate.tellLawProsecutor == 1 ? true : false;
      isTellLawProvincialAdminEmailController.text = itemUpdate.tellLawProsecutorEmail ?? '';

      isNotRecordImageAndSound = itemUpdate.provincialAdmin == 1 ? true : false;
      isNotRecordImageAndSoundDescController.text = itemUpdate.isNotRecord ?? '';

      policeStationController.text = itemUpdate.policeStation ?? '';
      employerOwnerController.text = itemUpdate.employerOwner ?? '';
      truckOwnerController.text = itemUpdate.truckOwner ?? '';
      factoryDataController.text = itemUpdate.factoryData ?? '';

      List<String> timeSave = StringHleper.splitData(itemUpdate.localeTime.toString(), ':');
      localeTimeController.text = '${timeSave[0]}:${timeSave[1]}';
      selectedLocalDate = ConvertDate.stringToDateYYYYMMDD(itemUpdate.recordDate.toString());
      localeDateController.text = ConvertDate.convertDateToDDMMMMYYYY(ConvertDate.stringToDateYYYYMMDD(itemUpdate.recordDate.toString()));

      List<String> timeSave2 = StringHleper.splitData(itemUpdate.tellLawTime.toString(), ':');
      isTellLawProsecutorTimeController.text = '${timeSave2[0]}:${timeSave2[1]}';
      selectedTellLawProvincialAdminDate = ConvertDate.stringToDateYYYYMMDD(itemUpdate.tellLawProsecutorDate.toString());
      isTellLawProsecutorDateController.text = ConvertDate.convertDateToDDMMMMYYYY(ConvertDate.stringToDateYYYYMMDD(itemUpdate.tellLawProsecutorDate.toString()));

      List<String> timeSave3 = StringHleper.splitData(itemUpdate.tellLawProsecutorTime.toString(), ':');
      isTellLawProvincialAdminTimeController.text = '${timeSave3[0]}:${timeSave3[1]}';
      selectedTellLawProsecutorDate = ConvertDate.stringToDateYYYYMMDD(itemUpdate.tellLawDate.toString());
      isTellLawProvincialAdminDateController.text = ConvertDate.convertDateToDDMMMMYYYY(ConvertDate.stringToDateYYYYMMDD(itemUpdate.tellLawDate.toString()));

      setState(() {});
      onTextChange('update', 'update');
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

  void onTextChange(String? value, nameInput) {
    var payload = ArrestFormStepFourReq(
      localeRuralRoadNo: localeDuralRoadNoController.text,
      localeKm: localeKmController.text,
      localeSubDistrict: subDistrictId != '' ? int.parse(subDistrictId) : null,
      localeDistrict: districtId != '' ? int.parse(districtId) : null,
      localeProvince: provinceId != '' ? int.parse(provinceId) : null,
      localeDate: selectedLocalDate != null ? ConvertDate.convertDateToYYYYDDMM(selectedLocalDate!) : '',
      localeTime: localeTimeController.text != '' ? '${localeTimeController.text}:00' : '',
      confesstion: isConfessionType,
      confesstionOther: confessionDescController.text,
      evidence: isEvidence ? 1 : 0,
      torture: isTorture ? 1 : 0,
      tellLaw: isTellLawProsecutor ? 1 : 0,
      tellLawEmail: isTellLawProsecutorEmailController.text,
      tellLawDate: selectedTellLawProsecutorDate != null ? ConvertDate.convertDateToYYYYDDMM(selectedTellLawProsecutorDate!) : '',
      tellLawTime: isTellLawProsecutorTimeController.text != '' ? '${isTellLawProsecutorTimeController.text}:00' : '',
      tellLawProsecutor: isTellLawProvincialAdmin ? 1 : 0,
      tellLawProsecutorEmail: isTellLawProvincialAdminEmailController.text,
      tellLawProsecutorDate: selectedTellLawProvincialAdminDate != null ? ConvertDate.convertDateToYYYYDDMM(selectedTellLawProvincialAdminDate!) : '',
      tellLawProsecutorTime: isTellLawProvincialAdminTimeController.text != '' ? '${isTellLawProvincialAdminTimeController.text}:00' : '',
      provincialAdmin: isNotRecordImageAndSound ? 1 : 0,
      isNotRecord: isNotRecordImageAndSoundDescController.text,
      policeStation: policeStationController.text,
      employerOwner: employerOwnerController.text,
      truckOwner: truckOwnerController.text,
      factoryData: factoryDataController.text,
    );

    logger.i(payload.toJson());

    context.read<ArrestBloc>().add(StepFourFormEvent(payload));
  }

  void typeWeightUnit(int value) {
    setState(() {
      confessionDescController.text = '';
    });
    setState(() {
      isConfession = value == 1 ? true : false;
      isConfessionType = value;
    });

    onTextChange('confesstion', 'confesstion');
  }

  void isCheckBox(int value) {
    if (value == 1) {
      setState(() {
        isEvidence = !isEvidence;
      });
    }
    if (value == 2) {
      setState(() {
        isTorture = !isTorture;
      });
    }
    if (value == 3) {
      setState(() {
        isTellLawProsecutor = !isTellLawProsecutor;
      });
    }
    if (value == 4) {
      setState(() {
        isTellLawProvincialAdmin = !isTellLawProvincialAdmin;
      });
    }

    if (value == 5) {
      setState(() {
        isNotRecordImageAndSound = !isNotRecordImageAndSound;
      });
    }

    onTextChange('checkbox', 'checkbox');
  }

  void validateForm() {
    // if (newFormKey.currentState!.validate()) {
    //   widget.onStepSubmitForm('step_four');
    // }
    widget.onStepSubmitForm('step_four');
  }

  void onStepFormBack() {
    widget.onStepFormBack('step_four');
  }

  @override
  void dispose() {
    super.dispose();

    localeDuralRoadNoController.dispose();
    localeDuralRoadNoFocusNode.dispose();
    localeKmController.dispose();
    localeKmFocusNode.dispose();
    localeDateController.dispose();
    localeDateFocusNode.dispose();
    localeTimeController.dispose();
    localeTimeFocusNode.dispose();

    subdistrictController.dispose();
    subdistrictFocusNode.dispose();
    districtController.dispose();
    districtFocusNode.dispose();
    provinceController.dispose();
    provinceFocusNode.dispose();

    confessionDescController.dispose();
    confessionDescFocusNode.dispose();
    isTellLawProsecutorEmailController.dispose();
    isTellLawProsecutorEmailFocusNode.dispose();
    isTellLawProsecutorDateController.dispose();
    isTellLawProsecutorDateFocusNode.dispose();

    isTellLawProsecutorTimeController.dispose();
    isTellLawProsecutorTimeFocusNode.dispose();

    isTellLawProvincialAdminEmailController.dispose();
    isTellLawProvincialAdminEmailFocusNode.dispose();
    isTellLawProvincialAdminDateController.dispose();
    isTellLawProvincialAdminDateFocusNode.dispose();

    isTellLawProvincialAdminTimeController.dispose();
    isTellLawProvincialAdminTimeFocusNode.dispose();

    isNotRecordImageAndSoundDescController.dispose();
    isNotRecordImageAndSoundDescFocusNode.dispose();
    policeStationController.dispose();
    policeStationFocusNode.dispose();
    employerOwnerController.dispose();
    employerOwnerFocusNode.dispose();
    truckOwnerController.dispose();
    truckOwnerFocusNode.dispose();
    factoryDataController.dispose();
    factoryDataFocusNode.dispose();
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
          padding: EdgeInsets.all(12),
          child: Form(
              key: newFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleSvgWidget(
                    title: 'เหตุเกิดที่',
                    imageSvg: 'assets/svg/truck_icon.svg',
                  ),
                  SizedBox(height: 10.0.h),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LabelInputWidget(
                          title: localeDuralRoadNo,
                          // isRequired: true,
                        ),
                        TextInputWidget(
                          label: localeDuralRoadNo,
                          hint: localeDuralRoadNo,
                          controller: localeDuralRoadNoController,
                          focusNode: localeDuralRoadNoFocusNode,
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
                          title: localeKm,
                          // isRequired: true,
                        ),
                        TextInputWidget(
                          label: localeKm,
                          hint: localeKm,
                          controller: localeKmController,
                          focusNode: localeKmFocusNode,
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
                          title: localeDate,
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
                                selectedLocalDate = pickedDate;
                                localeDateController.text = ConvertDate.convertDateToDDMMMMYYYY(pickedDate);
                              });
                              onTextChange(pickedDate.toString(), localeDate);
                            }
                          },
                          child: TextInputWidget(
                            label: localeDate,
                            hint: localeDate,
                            controller: localeDateController,
                            focusNode: localeDateFocusNode,
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
                          title: localeTime,
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
                                localeTimeController.text = "${timePicked.hour.toString().padLeft(2, '0')}:${timePicked.minute.toString().padLeft(2, '0')}";
                              });
                              onTextChange('${timePicked.hour.toString().padLeft(2, '0')}:${timePicked.minute.toString().padLeft(2, '0')}', localeTime);
                            }
                          },
                          child: TextInputWidget(
                            label: localeTime,
                            hint: localeTime,
                            controller: localeTimeController,
                            focusNode: localeTimeFocusNode,
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
                    'ในการจับกุมครั้งนี้เจ้าพนักงานทางหลวงผู้จับกุมได้แจ้งข้อ หาให้ผู้ต้องหาและแจ้งสิทธิตามมาตรา ๘๓ วรรคที่สองแห่ง ประมวลกฎหมายความอาญาให้ทราบแล้วผู้ต้องหาให้การ ดังนี้',
                    style: AppTextStyle.title14normal(),
                  ),
                  AutoSizeText(
                    '๑. สิทธิที่จะไม่ให้การหรือให้การก็ได้',
                    style: AppTextStyle.title14normal(),
                  ),
                  AutoSizeText(
                    '๒.ถ้อยคำของผู้ต้องหานั้นอาจใช้เป็นพยานหลักฐานในการ พิจารณาคดีได้',
                    style: AppTextStyle.title14normal(),
                  ),
                  AutoSizeText(
                    '๓.สิทธิที่จะพบและปรึกษาทนายความหรือผู้ซึ่งจะเป็นทนายความ',
                    style: AppTextStyle.title14normal(),
                  ),
                  AutoSizeText(
                    '๔.สิทธิที่จะแจ้งให้ญาติหรือคนที่ไว้วางใจทราบถึงผู้จับกุม มิได้ทำหรือจัดให้ทำการใด ซึ่งเป็นการให้ คำมั่นสัญญา จงใจ ขู่เข็ญ หลอกหลวง ทรมาน ใช้กําลังบังคับ',
                    style: AppTextStyle.title14normal(),
                  ),
                  GestureDetector(
                    onTap: () => typeWeightUnit(1),
                    child: Container(
                      margin: EdgeInsets.only(top: 10, bottom: 5),
                      child: Row(
                        children: [
                          Icon(isConfessionType == 1 ? Icons.radio_button_checked_sharp : Icons.radio_button_unchecked, color: isConfessionType == 1 ? ColorApps.colorMain : ColorApps.colorGray),
                          SizedBox(width: 8.w),
                          Text(
                            'ผู้ต้องหารับสารภาพตลอดข้อกล่าวหา',
                            style: AppTextStyle.title16bold(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => typeWeightUnit(2),
                    child: Container(
                      margin: EdgeInsets.only(top: 10, bottom: 5),
                      child: Row(
                        children: [
                          Icon(isConfessionType == 2 ? Icons.radio_button_checked_sharp : Icons.radio_button_unchecked, color: isConfessionType == 2 ? ColorApps.colorMain : ColorApps.colorGray),
                          SizedBox(width: 8.w),
                          Text(
                            'ผู้ต้องหาปฏิเสธข้อกล่าวหา',
                            style: AppTextStyle.title16bold(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => typeWeightUnit(3),
                    child: Container(
                      margin: EdgeInsets.only(top: 10, bottom: 5),
                      child: Row(
                        children: [
                          Icon(isConfessionType == 3 ? Icons.radio_button_checked_sharp : Icons.radio_button_unchecked, color: isConfessionType == 3 ? ColorApps.colorMain : ColorApps.colorGray),
                          SizedBox(width: 8.w),
                          AutoSizeText(
                            confessionDesc,
                            style: AppTextStyle.title16bold(),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: TextInputWidget(
                              label: confessionDesc,
                              hint: confessionDesc,
                              controller: confessionDescController,
                              focusNode: isConfessionType == 3 ? confessionDescFocusNode : null,
                              isDisable: isConfessionType != 3 ? true : null,
                              onTextChange: onTextChange,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => isCheckBox(1),
                          child: Icon(isEvidence ? Icons.check_box : Icons.check_box_outline_blank, color: isEvidence ? ColorApps.colorMain : ColorApps.colorGray),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: AutoSizeText(
                            'ในการควบคุมตัวผู้ถูกจับกุม เจ้าหน้าที่ผู้จับกุมได้ทำ การบันทึกภาพและเสียงอย่างต่อเพื่อเพื่อเรื่องในขณะ จับและควบคุมตัวผู้ถูกจับในชั้นจับกุม จนกระทั่งส่งตัวพนักงานสอบสวน ตามมาตรา ๒๒ วรรคหนึ่ง แห่ง พ.ร.บ.ป้องกันและปราบปรามการพรมานและการ กระทำให้สูญหาย พ.ศ. ๒๕๖๕',
                            style: AppTextStyle.title16bold(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => isCheckBox(2),
                          child: Icon(isTorture ? Icons.check_box : Icons.check_box_outline_blank, color: isTorture ? ColorApps.colorMain : ColorApps.colorGray),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: AutoSizeText(
                            'เจ้าหน้าที่ผู้จับกุมไม่ได้กระทำการใดๆอันเป็นการ ทรมาน การทำที่โหดร้าย ไร้มนุษยธรรม หรือย้ำยี ศักดิ์ศรีความเป็นมนุษย์หรือกระทำให้บุคคลสูญหาย แต่อย่างใด',
                            style: AppTextStyle.title16bold(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => isCheckBox(3),
                          child: Icon(isTellLawProsecutor ? Icons.check_box : Icons.check_box_outline_blank, color: isTellLawProsecutor ? ColorApps.colorMain : ColorApps.colorGray),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                'เจ้าหน้าที่ผู้จับกุมได้แจ้งข้อมูลเกี่ยวกับผู้ถูกควบคุมตัว ตามมาตรา 22 วรรคสอง แห่ง พ.ร.บ. ป้องกัน และปราบปรามการทรมานและการกระทําให้สูญหาย พ.ศ. ๒๕๖๕ ไปยังผู้อำนวยการสำนักการสอบสวน สำนักงานอัยการสูงสุด E-mail',
                                style: AppTextStyle.title16bold(),
                              ),
                              SizedBox(height: 5.0.h),
                              AutoSizeText(
                                'E-mail ที่',
                                style: AppTextStyle.title16bold(),
                              ),
                              SizedBox(height: 5.0.h),
                              TextInputWidget(
                                label: isTellLawProsecutorEmail,
                                hint: isTellLawProsecutorEmail,
                                controller: isTellLawProsecutorEmailController,
                                focusNode: isTellLawProsecutor ? isTellLawProsecutorEmailFocusNode : null,
                                isDisable: isTellLawProsecutor ? null : true,
                                onTextChange: onTextChange,
                              ),
                              SizedBox(height: 5.0.h),
                              AutoSizeText(
                                'เมื่อวันที่',
                                style: AppTextStyle.title16bold(),
                              ),
                              SizedBox(height: 5.0.h),
                              GestureDetector(
                                onTap: () async {
                                  if (isTellLawProsecutor) {
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
                                        selectedTellLawProsecutorDate = pickedDate;
                                        isTellLawProsecutorDateController.text = ConvertDate.convertDateToDDMMMMYYYY(pickedDate);
                                      });
                                      onTextChange(pickedDate.toString(), isTellLawProsecutorDate);
                                    }
                                  }
                                },
                                child: TextInputWidget(
                                  label: isTellLawProsecutorDate,
                                  hint: isTellLawProsecutorDate,
                                  controller: isTellLawProsecutorDateController,
                                  focusNode: isTellLawProsecutor ? isTellLawProsecutorDateFocusNode : null,
                                  isDisable: true,
                                  onTextChange: onTextChange,
                                  isShowIconError2: true,
                                  isSuffixIcon: true,
                                  iconName: Icons.calendar_today,
                                  iconColor: ColorApps.colorGray,
                                  isDisableBgColor: ColorApps.colorBackground,
                                ),
                              ),
                              SizedBox(height: 5.0.h),
                              AutoSizeText(
                                'เวลา',
                                style: AppTextStyle.title16bold(),
                              ),
                              SizedBox(height: 5.0.h),
                              GestureDetector(
                                onTap: () async {
                                  if (isTellLawProsecutor) {
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
                                        isTellLawProsecutorTimeController.text = "${timePicked.hour.toString().padLeft(2, '0')}:${timePicked.minute.toString().padLeft(2, '0')}";
                                      });
                                      onTextChange('${timePicked.hour.toString().padLeft(2, '0')}:${timePicked.minute.toString().padLeft(2, '0')}', 'เวลา');
                                    }
                                  }
                                },
                                child: TextInputWidget(
                                  label: 'เวลา',
                                  hint: 'เวลา',
                                  controller: isTellLawProsecutorTimeController,
                                  focusNode: isTellLawProsecutorTimeFocusNode,
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
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => isCheckBox(4),
                          child: Icon(isTellLawProvincialAdmin ? Icons.check_box : Icons.check_box_outline_blank, color: isTellLawProvincialAdmin ? ColorApps.colorMain : ColorApps.colorGray),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                'เจ้าหน้าที่ผู้จับกุมได้แจ้งข้อมูลเกี่ยวกับผู้ถูกควบคุมตัว ตามมาตรา 22 วรรคสอง แห่ง พ.ร.บ.ป้องกัน และปราบปรามการทรมานและการกระทําให้สูญหาย พ.ศ. ๒๕๖๕ ไปยังผู้อำนวยการสำนักการสอบสวน และนิติกร',
                                style: AppTextStyle.title16bold(),
                              ),
                              SizedBox(height: 5.0.h),
                              AutoSizeText(
                                'กรมการปกครอง ที่',
                                style: AppTextStyle.title16bold(),
                              ),
                              SizedBox(height: 5.0.h),
                              TextInputWidget(
                                label: isTellLawProvincialAdminEmail,
                                hint: isTellLawProvincialAdminEmail,
                                controller: isTellLawProvincialAdminEmailController,
                                focusNode: isTellLawProvincialAdmin ? isTellLawProvincialAdminEmailFocusNode : null,
                                isDisable: isTellLawProvincialAdmin ? null : true,
                                onTextChange: onTextChange,
                              ),
                              SizedBox(height: 5.0.h),
                              AutoSizeText(
                                'เมื่อวันที่',
                                style: AppTextStyle.title16bold(),
                              ),
                              SizedBox(height: 5.0.h),
                              GestureDetector(
                                onTap: () async {
                                  if (isTellLawProvincialAdmin) {
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
                                        selectedTellLawProvincialAdminDate = pickedDate;
                                        isTellLawProvincialAdminDateController.text = ConvertDate.convertDateToDDMMMMYYYY(pickedDate);
                                      });
                                      onTextChange(pickedDate.toString(), isTellLawProsecutorDate);
                                    }
                                  }
                                },
                                child: TextInputWidget(
                                  label: isTellLawProvincialAdminDate,
                                  hint: isTellLawProvincialAdminDate,
                                  controller: isTellLawProvincialAdminDateController,
                                  focusNode: isTellLawProvincialAdmin ? isTellLawProvincialAdminDateFocusNode : null,
                                  isDisable: true,
                                  isShowIconError2: true,
                                  isSuffixIcon: true,
                                  iconName: Icons.calendar_today,
                                  iconColor: ColorApps.colorGray,
                                  isDisableBgColor: ColorApps.colorBackground,
                                ),
                              ),
                              SizedBox(height: 5.0.h),
                              AutoSizeText(
                                'เวลา',
                                style: AppTextStyle.title16bold(),
                              ),
                              SizedBox(height: 5.0.h),
                              GestureDetector(
                                onTap: () async {
                                  if (isTellLawProvincialAdmin) {
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
                                        isTellLawProvincialAdminTimeController.text = "${timePicked.hour.toString().padLeft(2, '0')}:${timePicked.minute.toString().padLeft(2, '0')}";
                                      });
                                      onTextChange('${timePicked.hour.toString().padLeft(2, '0')}:${timePicked.minute.toString().padLeft(2, '0')}', 'เวลา');
                                    }
                                  }
                                },
                                child: TextInputWidget(
                                  label: 'เวลา',
                                  hint: 'เวลา',
                                  controller: isTellLawProvincialAdminTimeController,
                                  focusNode: isTellLawProvincialAdminTimeFocusNode,
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
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => isCheckBox(5),
                          child: Icon(isNotRecordImageAndSound ? Icons.check_box : Icons.check_box_outline_blank, color: isNotRecordImageAndSound ? ColorApps.colorMain : ColorApps.colorGray),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                'มีเหตุสุดวิสัยที่ไม่สามารถบันทึกภาพและเสียง ตาม มาตรา 22 วรรคหนึ่ง แห่ง พ.ร.บ. ป้องกัน และ ปราบปรามการทรมานและการกระทําให้สูญหาย พ.ศ. 2565 เนื่องจาก',
                                style: AppTextStyle.title16bold(),
                              ),
                              SizedBox(height: 5.0.h),
                              TextInputWidget(
                                label: isNotRecordImageAndSoundDesc,
                                hint: isNotRecordImageAndSoundDesc,
                                controller: isNotRecordImageAndSoundDescController,
                                focusNode: isNotRecordImageAndSound ? isNotRecordImageAndSoundDescFocusNode : null,
                                isDisable: isNotRecordImageAndSound ? null : true,
                                onTextChange: onTextChange,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0.h),
                  AutoSizeText(
                    '      อนึ่งในการจับกุมครั้งนี้ เจ้าพนักงานทุกคนได้กระทําไปตาม อํานาจหน้าที่โดยชอบ มิได้ทําหรือจัดให้ทําการใดซึ่งเป็นการ ให้คํามั่นสัญญา จูงใจ หลอกลวง บังคับขู่เข็ญทําร้ายร่างกาย หรือจิตใจผู้ต้องหาหรือกระทําการโดยมิชอบประการใดที่ เกี่ยวกับการจับกุมมิได้เรียกรับหรือยอมจะรับทรัพย์สิน',
                    style: AppTextStyle.title14normal(),
                  ),
                  AutoSizeText(
                    '      หรือประโยชน์อื่นใดสําหรับตนเองหรือผู้อื่นโดยมิชอบและ มิได้ทําให้เสียหายทําลาย ซ่อนเร้นเอาไปเสียทําให้สูญหายหรือ ไร้ประโยชน์ซึ่งทรัพย์สินอันเป็นพยานหลักฐานแต่อย่างใด',
                    style: AppTextStyle.title14normal(),
                  ),
                  AutoSizeText(
                    'พร้อมทั้งได้นําผู้ต้องหาพร้อมเอกสารหลักฐานและของกลาง ส่งพนักงานสอบสวน',
                    style: AppTextStyle.title14normal(),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LabelInputWidget(
                          title: policeStation,
                          // isRequired: true,
                        ),
                        TextInputWidget(
                          label: policeStation,
                          hint: policeStation,
                          controller: policeStationController,
                          focusNode: policeStationFocusNode,
                          onTextChange: onTextChange,
                        ),
                      ],
                    ),
                  ),
                  AutoSizeText(
                    'เพื่อดำเนินคดีตามกฎหมายต่อไป โดยขอให้ เจ้าพนักงานสอบ สวนตรวจสอบในพฤติการณ์เพิ่มเติมของผู้ต้องหา ดังนี้',
                    style: AppTextStyle.title14normal(),
                  ),
                  AutoSizeText(
                    '๑. ตรวจสอบข้อมูลของผู้ว่าจ้างขนส่ง คือ ห้างหุ้นส่วนจำกัด/บริษัทจำกัด/นาย/นาง/นางสาว',
                    style: AppTextStyle.title14normal(),
                  ),
                  SizedBox(height: 5.0.h),
                  TextInputWidget(
                    label: employerOwner,
                    hint: employerOwner,
                    controller: employerOwnerController,
                    focusNode: employerOwnerFocusNode,
                    onTextChange: onTextChange,
                  ),
                  SizedBox(height: 5.0.h),
                  AutoSizeText(
                    'ว่ารู้เห็นเป็นใจใจการกระทำความผิดนี้หรือไม่',
                    style: AppTextStyle.title14normal(),
                  ),
                  AutoSizeText(
                    '๒.ตรวจสอบข้อมูลของผู้ประกอบการขนส่งหรือเจ้าของรถ คือ ห้างหุ้นส่วนจำกัด/บริษัทจำกัด/นาย/นาง/นางสาว',
                    style: AppTextStyle.title14normal(),
                  ),
                  SizedBox(height: 5.0.h),
                  TextInputWidget(
                    label: truckOwner,
                    hint: truckOwner,
                    controller: truckOwnerController,
                    focusNode: truckOwnerFocusNode,
                    onTextChange: onTextChange,
                  ),
                  SizedBox(height: 5.0.h),
                  AutoSizeText(
                    'ซึ่งเป็นผู้ขนส่งสินค้า ว่ารู้เห็นเป็นใจในการกระทำความผิดนี้หรือไม่',
                    style: AppTextStyle.title14normal(),
                  ),
                  SizedBox(height: 5.0.h),
                  AutoSizeText(
                    '๓. ตรวจสอบข้อมูลโรงงานที่เป็นแหล่งวัสดุต่างๆตามกฎหมายโรงงาน หรือกฎหมายอื่น ๆ ที่เกี่ยวข้อง คือ ห้่างหุ้นส่วน จำกัด/บริษัทจำกัด/นาย/นาง/นางสาว',
                    style: AppTextStyle.title14normal(),
                  ),
                  SizedBox(height: 5.0.h),
                  TextInputWidget(
                    label: factoryData,
                    hint: factoryData,
                    controller: factoryDataController,
                    focusNode: factoryDataFocusNode,
                    onTextChange: onTextChange,
                  ),
                  SizedBox(height: 5.0.h),
                  AutoSizeText(
                    'ว่ารู้เห็นเป็นใจใจการกระทำความผิดนี้หรือไม่',
                    style: AppTextStyle.title14normal(),
                  ),
                  SizedBox(height: 5.0.h),
                  AutoSizeText(
                    '๔. ขอให้พิจารณาถึงข้อกฎหมาย อื่น ๆ ที่เกี่ยวข้องเพิ่มเติม ด้วย เช่น พ.ร.บ. โรงงานฯ, พ.ร.บ.เหมืองแร่ฯ รวมถึงข้อ สัญญาที่ไม่เป็นธรรมอื่น ๆ อันป็นแรงจูงใจให้เกิดการกระทำ ความผิดนี้ ฯลฯ',
                    style: AppTextStyle.title14normal(),
                  ),
                  AutoSizeText(
                    '๕. หากทางพนักงานสอบสวนได้สรุปสํานวนคดีต่าง ๆ เสร็จ สิ้นกระบวนการแล้ว ขอความอนุเคราะห์แจ้งผลให้สํานักงาน บํารุงทาง กรมทางหลวงชนบท ทราบด้วยเบอร์โทรศัพท์ ๐๒๕๕๑ ๕๒๑๐ เพื่อประโยชน์ในการติดตามผลการดำเนิน คดีตามกฎหมายต่อไป',
                    style: AppTextStyle.title14normal(),
                  ),
                  AutoSizeText(
                    '           เจ้าพนักงานผู้จับกุมได้อ่านบันทึกให้ผู้ถูกจับกุมฟังแล้ว และผู้ถูกจับกุมได้อ่านด้วยตนเองแล้ว รับว่าถูกต้องมีการ ดําเนินการตาม พ.ร.บ. ป้องกันและปราบปรามการทรมาน และการกระทำให้สูญหาย พ.ศ.๒๕๖๕ มาตรา​ ๒๒ และได้มอบ สำเนาบันทึกการจับกุมให้แก่ผู้ถูกจับกุมเรียบร้อยจึงได้ลง ลายชื่อไว้เป็นหลักฐาน',
                    style: AppTextStyle.title14normal(),
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
                                text: 'บันทึกการจับกุม',
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
              )),
        ),
      ),
    );
  }
}
