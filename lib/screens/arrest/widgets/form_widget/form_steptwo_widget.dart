import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wts_bloc/utils/constants/color_app.dart';

import '../../../../blocs/arrest/arrest_bloc.dart';
import '../../../../blocs/master_data/province_master/province_master_bloc.dart';
import '../../../../blocs/materials/materials_bloc.dart';
import '../../../../data/models/arrest/arrest_form/arrest_form_step_two.dart';
import '../../../../data/models/arrest/arrest_log_detail_model_res.dart';
import '../../../../data/models/establish/mobile_car_model.dart';
import '../../../../data/models/master_data/material/material_model_req.dart';
import '../../../../data/models/master_data/material/material_model_res.dart';
import '../../../../data/models/master_data/province/province_master_data_res.dart';
import '../../../../main.dart';
import '../../../../utils/constants/text_style.dart';
import '../../../../utils/widgets/buttom_sheet_widget/custom_province_bottom_sheet2.dart';
import '../../../../utils/widgets/custom_button.dart';
import '../../../../utils/widgets/inputs/dropdown_input_custom_widget.dart';
import '../../../../utils/widgets/inputs/label_input_widget.dart';
import '../../../../utils/widgets/inputs/text_input_widget.dart';
import '../../../../utils/widgets/inputs/title_widget.dart';
import '../../../establish/establish_unit/widgets/custom_province_bottom_sheet.dart';

class FormSteptwoWidget extends StatefulWidget {
  const FormSteptwoWidget({
    super.key,
    required this.item,
    required this.onStepSubmitForm,
    required this.onStepFormBack,
  });

  final Function(String) onStepSubmitForm;
  final Function(String) onStepFormBack;
  final MobileCarModel item;

  @override
  State<FormSteptwoWidget> createState() => _FormSteptwoWidgetState();
}

class _FormSteptwoWidgetState extends State<FormSteptwoWidget> {
  final newFormKey = GlobalKey<FormState>();
  final TextEditingController employerFullNameController = TextEditingController();
  final FocusNode employerFullNameFocusNode = FocusNode();

  final TextEditingController truckBrandController = TextEditingController();
  final FocusNode truckBrandFocusNode = FocusNode();
  final TextEditingController vehicleRegistrationPlateController = TextEditingController();
  final FocusNode vehicleRegistrationPlateFocusNode = FocusNode();
  final TextEditingController vehicleTypeController = TextEditingController();
  final FocusNode vehicleTypeFocusNode = FocusNode();
  final TextEditingController vehicleAxleController = TextEditingController();
  final FocusNode vehicleAxleFocusNode = FocusNode();
  final TextEditingController vehicleRubberController = TextEditingController();
  final FocusNode vehicleRubberFocusNode = FocusNode();
  final TextEditingController distanceKingPinController = TextEditingController();
  final FocusNode distanceKingPinFocusNode = FocusNode();
  final TextEditingController truckCarrierTypeController = TextEditingController();
  final FocusNode truckCarrierTypeFocusNode = FocusNode();
  final TextEditingController followRuralRoadNumberController = TextEditingController();
  final FocusNode followRuralRoadNumberFocusNode = FocusNode();

  final TextEditingController vehicleTowRegistrationTailPlateController = TextEditingController();
  final FocusNode vehicleTowRegistrationTailPlateFocusNode = FocusNode();
  final TextEditingController vehicleTowTypeController = TextEditingController();
  final FocusNode vehicleTowTypeFocusNode = FocusNode();
  final TextEditingController vehicleTowAxleController = TextEditingController();
  final FocusNode vehicleTowAxleFocusNode = FocusNode();
  final TextEditingController vehicleTowRubberController = TextEditingController();
  final FocusNode vehicleTowRubberFocusNode = FocusNode();

  final TextEditingController weightStationController = TextEditingController();
  final FocusNode weightStationFocusNode = FocusNode();

  final TextEditingController weightSportCheckController = TextEditingController();
  final FocusNode weightSportCheckFocusNode = FocusNode();

  final TextEditingController sourceProvinceController = TextEditingController();
  final FocusNode sourceProvinceFocusNode = FocusNode();
  final TextEditingController desticationProvinceController = TextEditingController();
  final FocusNode desticationProvinceFocusNode = FocusNode();

  // ข้อมูลนายจ้าง/ผู้ประกอบการขนส่ง
  String employerFullName = 'ชื่อ - นามสกุล';
  String truckBrand = 'รถบรรทุกยี่ห้อ';
  String vehicleRegistrationPlate = 'เลขทะเบียน';
  String vehicleType = 'ชนิด';
  String vehicleAxle = 'เพลา';
  String vehicleRubber = 'ใช้ยาง';
  String vehicleTow = 'และรถบรรทุก';

  String vehicleTowRegistrationTailPlate = 'เลขทะเบียน';
  String vehicleTowType = 'ชนิด';
  String vehicleTowAxle = 'เพลา';
  String vehicleTowRubber = 'ใช้ยาง';

  String distanceKingPin = 'ระยะ King Pin';
  String truckCarrierType = 'บรรทุกสินค้าประเภท';
  String followRuralRoadNumber = 'มาตามทางหลวงชนบทหมายเลข';
  String sourceProvince = 'จากจังหวัด';
  String desticationProvince = 'นำไปส่งจังหวัด';

  bool isWeightStation = true;
  bool isWeightSportCheck = false;
  int isWeightStationType = 2;
  String weightStation = 'สถานีตรวจสอบน้ำหนักยานพาหนะ';
  String weightSportCheck = 'หน่วยตรวจสอบน้ำหนักยานพาหนะ';

  List<MaterialModelRes>? materials = [];

  String materialSearch = '';
  int materialPage = 1;
  int materialPageSize = 20;

  List<ProvinceMasterDataModel>? provinceSource = [];
  List<ProvinceMasterDataModel>? provinceDestication = [];

  String provinceSourceId = '';
  String provinceDesticationId = '';
  int? vehicleTowTypeId;

  int isTrailerSelectId = 1;

  @override
  void initState() {
    super.initState();

    initScreen();
  }

  void initScreen() async {
    getMaterialBloc();
    getProvince('');

    setState(() {
      vehicleRegistrationPlateController.text = widget.item.lpHeadNo ?? '';
    });

    onTextChange('init', 'init');

    updateData();
  }

  void updateData() async {
    if (context.read<ArrestBloc>().state.arrestLogDetail != null && context.read<ArrestBloc>().state.arrestLogDetail!.employerFullname != null) {
      ArrestLogDetailModelRes itemUpdate = context.read<ArrestBloc>().state.arrestLogDetail!;

      employerFullNameController.text = itemUpdate.employerFullname ?? '';
      truckBrandController.text = itemUpdate.truckBrand ?? '';
      vehicleTypeController.text = itemUpdate.vehicleType ?? '';
      vehicleAxleController.text = itemUpdate.vehicleAxle ?? '';
      vehicleRubberController.text = itemUpdate.vehicleRubber ?? '';
      vehicleTowRegistrationTailPlateController.text = itemUpdate.towVehicleRegistrationPlateTail ?? '';
      vehicleTowTypeController.text = itemUpdate.towType ?? '';
      vehicleTowAxleController.text = itemUpdate.towAxle ?? '';
      vehicleTowRubberController.text = itemUpdate.towRubber ?? '';
      distanceKingPinController.text = itemUpdate.distanceKingpin ?? '';
      followRuralRoadNumberController.text = itemUpdate.ruralRoadNumber ?? '';
      truckCarrierTypeController.text = itemUpdate.truckCarrierType ?? '';

      sourceProvinceController.text = itemUpdate.sourceProvince ?? '';
      desticationProvinceController.text = itemUpdate.destinationProvince ?? '';

      isTrailerSelectId = itemUpdate.vehicleTowType == 'พ่วง' ? 1 : 2;

      isWeightStationType = 2;
      weightSportCheckController.text = itemUpdate.explain ?? '';

      setState(() {});
      onTextChange('update', 'update');
    }
  }

  void getMaterialBloc() {
    var payload = MaterialModelReq(
      search: materialSearch,
      page: materialPage,
      pageSize: materialPageSize,
    );
    context.read<MaterialsBloc>().add(GetMaterialsEvent(payload));
  }

  void getProvince(String value) {
    context.read<ProvinceMasterBloc>().add(GetProvinceMaster(value));
  }

  void typeIsTrailer(int value) {
    setState(() {
      isTrailerSelectId = value;
    });
    onTextChange(vehicleTow, vehicleTow);
  }

  void typeWeightUnit(int value) {
    setState(() {
      weightSportCheckController.text = '';
      weightStationController.text = '';
    });
    // if (value == 1) {
    //   setState(() {
    //     isWeightStation = false;
    //     isWeightSportCheck = true;
    //     isWeightStationType = value;
    //   });
    // }

    if (value == 2) {
      setState(() {
        isWeightStation = true;
        isWeightSportCheck = false;
        isWeightStationType = value;
      });
    }

    onTextChange(vehicleTow, vehicleTow);
  }

  void onSelectItemSource(dynamic item, String label) async {
    if (label == 'provinceMasterData') {
      if (item is ProvinceMasterDataModel) {
        setState(() {
          provinceSourceId = item.id.toString();
        });

        sourceProvinceController.text = item.nameTh!;
        onTextChange(sourceProvinceController.text, provinceSource);
      } else {
        logger.e('Item is not of type ProvinceMasterDataModel');
      }
    }
  }

  void onSelectItemDestination(dynamic item, String label) async {
    if (label == 'provinceMasterData') {
      if (item is ProvinceMasterDataModel) {
        setState(() {
          provinceDesticationId = item.id.toString();
        });

        desticationProvinceController.text = item.nameTh!;
        onTextChange(desticationProvinceController.text, provinceDestication);
      } else {
        logger.e('Item is not of type ProvinceMasterDataModel');
      }
    }
  }

  void onSelectItem(dynamic item, String label) async {
    onTextChange(label, label);
  }

  void onTextChange(String? value, nameInput) {
    var payload = ArrestFormStepTwoReq(
      employerFullname: employerFullNameController.text,
      truckBrand: truckBrandController.text,
      vehicleRegistrationPlate: vehicleRegistrationPlateController.text,
      vehicleType: vehicleTypeController.text,
      vehicleAxle: vehicleAxleController.text,
      vehicleRubber: vehicleRubberController.text,
      vehicleTowType: isTrailerSelectId,
      towVehicleRegistrationPlateTail: vehicleTowRegistrationTailPlateController.text,
      towType: vehicleTowTypeController.text,
      towAxle: vehicleTowAxleController.text,
      towRubber: vehicleTowRubberController.text,
      distanceKingpin: distanceKingPinController.text,
      truckCarrierType: vehicleTowTypeId,
      ruralRoadNumber: followRuralRoadNumberController.text,
      sourceProvince: provinceSourceId != '' ? int.parse(provinceSourceId) : null,
      destinationProvince: provinceDesticationId != '' ? int.parse(provinceDesticationId) : null,
      weightStationType: isWeightStationType,
      explain: isWeightStationType == 1 ? weightStationController.text : weightSportCheckController.text,
    );

    logger.i(payload.toJson());

    context.read<ArrestBloc>().add(StepTwoFormEvent(payload));
  }

  void validateForm() {
    // if (newFormKey.currentState!.validate()) {
    //   widget.onStepSubmitForm('step_two');
    // }
    widget.onStepSubmitForm('step_two');
  }

  void onStepFormBack() {
    widget.onStepFormBack('step_two');
  }

  @override
  void dispose() {
    super.dispose();

    employerFullNameController.dispose();
    employerFullNameFocusNode.dispose();

    truckBrandController.dispose();
    truckBrandFocusNode.dispose();
    vehicleRegistrationPlateController.dispose();
    vehicleRegistrationPlateFocusNode.dispose();
    vehicleTypeController.dispose();
    vehicleTypeFocusNode.dispose();
    vehicleAxleController.dispose();
    vehicleAxleFocusNode.dispose();
    vehicleRubberController.dispose();
    vehicleRubberFocusNode.dispose();
    distanceKingPinController.dispose();
    distanceKingPinFocusNode.dispose();
    truckCarrierTypeController.dispose();
    truckCarrierTypeFocusNode.dispose();
    followRuralRoadNumberController.dispose();
    followRuralRoadNumberFocusNode.dispose();

    vehicleTowRegistrationTailPlateController.dispose();
    vehicleTowRegistrationTailPlateFocusNode.dispose();
    vehicleTowTypeController.dispose();
    vehicleTowTypeFocusNode.dispose();
    vehicleTowAxleController.dispose();
    vehicleTowAxleFocusNode.dispose();
    vehicleTowRubberController.dispose();
    vehicleTowRubberFocusNode.dispose();

    weightStationController.dispose();
    weightStationFocusNode.dispose();

    weightSportCheckController.dispose();
    weightSportCheckFocusNode.dispose();

    sourceProvinceController.dispose();
    sourceProvinceFocusNode.dispose();
    desticationProvinceController.dispose();
    desticationProvinceFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MobileCarModel item = widget.item;
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
                TitleWidget(
                  title: 'ข้อมูลนายจ้าง/ผู้ประกอบการขนส่ง',
                  icon: Icons.person,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabelInputWidget(
                        title: employerFullName,
                        // isRequired: true,
                      ),
                      TextInputWidget(
                        label: employerFullName,
                        hint: employerFullName,
                        controller: employerFullNameController,
                        focusNode: employerFullNameFocusNode,
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
                        title: truckBrand,
                        // isRequired: true,
                      ),
                      TextInputWidget(
                        label: truckBrand,
                        hint: truckBrand,
                        controller: truckBrandController,
                        focusNode: truckBrandFocusNode,
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
                        title: vehicleRegistrationPlate,
                        // isRequired: true,
                      ),
                      TextInputWidget(
                        label: vehicleRegistrationPlate,
                        hint: vehicleRegistrationPlate,
                        controller: vehicleRegistrationPlateController,
                        focusNode: vehicleRegistrationPlateFocusNode,
                        onTextChange: onTextChange,
                        isDisable: true,
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
                        title: vehicleType,
                        // isRequired: true,
                      ),
                      TextInputWidget(
                        label: vehicleType,
                        hint: vehicleType,
                        controller: vehicleTypeController,
                        focusNode: vehicleTypeFocusNode,
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
                        title: vehicleAxle,
                        // isRequired: true,
                      ),
                      TextInputWidget(
                        label: vehicleAxle,
                        hint: vehicleAxle,
                        controller: vehicleAxleController,
                        focusNode: vehicleAxleFocusNode,
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
                        title: vehicleRubber,
                        // isRequired: true,
                      ),
                      TextInputWidget(
                        label: vehicleRubber,
                        hint: vehicleRubber,
                        controller: vehicleRubberController,
                        focusNode: vehicleRubberFocusNode,
                        onTextChange: onTextChange,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        vehicleTow,
                        style: AppTextStyle.title16bold(),
                      ),
                      SizedBox(width: 8.w),
                      GestureDetector(
                        onTap: () => typeIsTrailer(1),
                        child: Container(
                          margin: EdgeInsets.only(top: 10, bottom: 5),
                          child: Row(
                            children: [
                              Icon(isTrailerSelectId == 1 ? Icons.radio_button_checked_sharp : Icons.radio_button_unchecked, color: isTrailerSelectId == 1 ? ColorApps.colorMain : ColorApps.colorGray),
                              SizedBox(width: 8.w),
                              Text(
                                'พ่วง',
                                style: AppTextStyle.title16bold(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      GestureDetector(
                        onTap: () => typeIsTrailer(2),
                        child: Container(
                          margin: EdgeInsets.only(top: 10, bottom: 5),
                          child: Row(
                            children: [
                              Icon(isTrailerSelectId == 2 ? Icons.radio_button_checked_sharp : Icons.radio_button_unchecked, color: isTrailerSelectId == 2 ? ColorApps.colorMain : ColorApps.colorGray),
                              SizedBox(width: 8.w),
                              Text(
                                'กึ่งพ่วง',
                                style: AppTextStyle.title16bold(),
                              ),
                            ],
                          ),
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
                        title: vehicleTowRegistrationTailPlate,
                        // isRequired: true,
                      ),
                      TextInputWidget(
                        label: vehicleTowRegistrationTailPlate,
                        hint: vehicleTowRegistrationTailPlate,
                        controller: vehicleTowRegistrationTailPlateController,
                        focusNode: vehicleTowRegistrationTailPlateFocusNode,
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
                        title: vehicleTowType,
                        // isRequired: true,
                      ),
                      TextInputWidget(
                        label: vehicleTowType,
                        hint: vehicleTowType,
                        controller: vehicleTowTypeController,
                        focusNode: vehicleTowTypeFocusNode,
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
                        title: vehicleTowAxle,
                        // isRequired: true,
                      ),
                      TextInputWidget(
                        label: vehicleTowAxle,
                        hint: vehicleTowAxle,
                        controller: vehicleTowAxleController,
                        focusNode: vehicleTowAxleFocusNode,
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
                        title: vehicleTowRubber,
                        // isRequired: true,
                      ),
                      TextInputWidget(
                        label: vehicleTowRubber,
                        hint: vehicleTowRubber,
                        controller: vehicleTowRubberController,
                        focusNode: vehicleTowRubberFocusNode,
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
                        title: distanceKingPin,
                        // isRequired: true,
                      ),
                      TextInputWidget(
                        label: distanceKingPin,
                        hint: distanceKingPin,
                        controller: distanceKingPinController,
                        focusNode: distanceKingPinFocusNode,
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
                        title: truckCarrierType,
                        // isRequired: true,
                      ),
                      BlocListener<MaterialsBloc, MaterialsState>(
                        listener: (context, state) {
                          if (state.materialStatus == MaterialsStatus.success) {
                            if (state.materials.isNotEmpty) {
                              materials = state.materials;
                            } else {
                              materials = [];
                            }
                          }
                          if (state.material != null) {
                            vehicleTowTypeId = state.material!.gid;
                            truckCarrierTypeController.text = state.material!.goodsName ?? '';
                            onTextChange(truckCarrierType, truckCarrierType);
                          }
                        },
                        child: DropdownInputCustomWidget(
                          label: "Text Input 1",
                          hint: truckCarrierType,
                          controller: truckCarrierTypeController,
                          focusNode: truckCarrierTypeFocusNode,
                          onTap: () => {
                            showModalBottomSheet(
                              backgroundColor: Theme.of(context).colorScheme.surface,
                              context: context,
                              isScrollControlled: true,
                              constraints: BoxConstraints(
                                minWidth: MediaQuery.of(context).size.width,
                              ),
                              builder: (BuildContext context) {
                                return DraggableScrollableSheet(
                                  initialChildSize: 0.4,
                                  minChildSize: 0.4,
                                  maxChildSize: 0.8,
                                  expand: false,
                                  builder: (BuildContext context, ScrollController scrollController) {
                                    return CustomModalBottomSheet(
                                      data_list: materials!,
                                      scrollController: scrollController,
                                      title: truckCarrierType,
                                      onSelectItem: onSelectItem,
                                      onClose: (result) {
                                        Navigator.pop(context, result);
                                      },
                                    );
                                  },
                                );
                              },
                            ).then((onValue) {
                              getMaterialBloc();
                            })
                          },
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
                        title: followRuralRoadNumber,
                        // isRequired: true,
                      ),
                      TextInputWidget(
                        label: followRuralRoadNumber,
                        hint: followRuralRoadNumber,
                        controller: followRuralRoadNumberController,
                        focusNode: followRuralRoadNumberFocusNode,
                        onTextChange: onTextChange,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelInputWidget(
                      title: sourceProvince,
                      // isRequired: true,
                    ),
                    BlocListener<ProvinceMasterBloc, ProvinceMasterState>(
                      listener: (context, state) {
                        if (state.provinceMasterStatus == ProvinceMasterStatus.success) {
                          if (state.provinceMaster != null && state.provinceMaster!.isNotEmpty) {
                            provinceSource = state.provinceMaster!;
                          } else {
                            provinceSource = [];
                          }
                        }
                      },
                      child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                        },
                        child: DropdownInputCustomWidget(
                          label: "Text Input 1",
                          hint: sourceProvince,
                          controller: sourceProvinceController,
                          focusNode: sourceProvinceFocusNode,
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
                                      data_list: provinceSource!,
                                      scrollController: scrollController,
                                      title: sourceProvince,
                                      label: 'provinceMasterData',
                                      onSelectItem: onSelectItemSource,
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
                      title: desticationProvince,
                      // isRequired: true,
                    ),
                    BlocListener<ProvinceMasterBloc, ProvinceMasterState>(
                      listener: (context, state) {
                        if (state.provinceMasterStatus == ProvinceMasterStatus.success) {
                          if (state.provinceMaster != null && state.provinceMaster!.isNotEmpty) {
                            provinceDestication = state.provinceMaster!;
                          } else {
                            provinceDestication = [];
                          }
                        }
                      },
                      child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                        },
                        child: DropdownInputCustomWidget(
                          label: "Text Input 1",
                          hint: desticationProvince,
                          controller: desticationProvinceController,
                          focusNode: desticationProvinceFocusNode,
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
                                      data_list: provinceDestication!,
                                      scrollController: scrollController,
                                      title: desticationProvince,
                                      label: 'provinceMasterData',
                                      onSelectItem: onSelectItemDestination,
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
                SizedBox(height: 10.0.h),
                // AutoSizeText(
                //   'ได้เข้าชั่งน้ำหนักโดยเครื่องชั่ง',
                //   style: AppTextStyle.title16bold(),
                // ),
                // GestureDetector(
                //   onTap: () => typeWeightUnit(1),
                //   child: Container(
                //     margin: EdgeInsets.only(top: 10, bottom: 5),
                //     child: Row(
                //       children: [
                //         Icon(isWeightStationType == 1 ? Icons.radio_button_checked_sharp : Icons.radio_button_unchecked, color: isWeightStationType == 1 ? ColorApps.colorMain : ColorApps.colorGray),
                //         SizedBox(width: 8.w),
                //         Text(
                //           weightStation,
                //           style: AppTextStyle.title16bold(),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.only(top: 10, bottom: 5),
                //   padding: EdgeInsets.only(left: 30),
                //   child: TextInputWidget(
                //     label: weightStation,
                //     hint: weightStation,
                //     controller: weightStationController,
                //     focusNode: isWeightStationType == 1 ? weightStationFocusNode : null,
                //     isDisable: isWeightStation ? isWeightStation : null,
                //     onTextChange: onTextChange,
                //   ),
                // ),
                GestureDetector(
                  onTap: () => typeWeightUnit(2),
                  child: Container(
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    child: Row(
                      children: [
                        Icon(isWeightStationType == 2 ? Icons.radio_button_checked_sharp : Icons.radio_button_unchecked, color: isWeightStationType == 2 ? ColorApps.colorMain : ColorApps.colorGray),
                        SizedBox(width: 8.w),
                        Text(
                          'หน่วยตรวจสอบน้ำหนักยานพาหนะ (Sport Check)',
                          style: AppTextStyle.title16bold(),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 5),
                  padding: EdgeInsets.only(left: 30),
                  child: TextInputWidget(
                    label: weightSportCheck,
                    hint: weightSportCheck,
                    controller: weightSportCheckController,
                    focusNode: isWeightStationType == 2 ? weightSportCheckFocusNode : null,
                    // isDisable: isWeightSportCheck ? isWeightSportCheck : null,
                    onTextChange: onTextChange,
                  ),
                ),
                Divider(color: ColorApps.colorGray),
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
