import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wts_bloc/utils/constants/color_app.dart';

import '../../../../blocs/arrest/arrest_bloc.dart';
import '../../../../data/models/arrest/arrest_form/arrest_form_step_three.dart';
import '../../../../data/models/arrest/arrest_log_detail_model_res.dart';
import '../../../../data/models/establish/mobile_car_model.dart';
import '../../../../main.dart';
import '../../../../utils/constants/text_style.dart';
import '../../../../utils/libs/string_helper.dart';
import '../../../../utils/widgets/custom_button.dart';
import '../../../../utils/widgets/inputs/label_input_widget.dart';
import '../../../../utils/widgets/inputs/text_input_widget.dart';
import '../../../../utils/widgets/titles/title_svg_widget.dart';

class FormStepthreeWidget extends StatefulWidget {
  const FormStepthreeWidget({
    super.key,
    required this.onStepSubmitForm,
    required this.onStepFormBack,
    required this.item,
  });

  final Function(String) onStepSubmitForm;
  final Function(String) onStepFormBack;
  final MobileCarModel item;

  @override
  State<FormStepthreeWidget> createState() => _FormStepthreeWidgetState();
}

class _FormStepthreeWidgetState extends State<FormStepthreeWidget> {
  final newFormKey = GlobalKey<FormState>();
  final TextEditingController truckTotalWeightController = TextEditingController();
  final FocusNode truckTotalWeightFocusNode = FocusNode();
  final TextEditingController truckLegalWeightController = TextEditingController();
  final FocusNode truckLegalWeightFocusNode = FocusNode();
  final TextEditingController truckOverWeightController = TextEditingController();
  final FocusNode truckOverWeightFocusNode = FocusNode();
  final TextEditingController truckAnnounceNoController = TextEditingController();
  final FocusNode truckAnnounceNoFocusNode = FocusNode();
  final TextEditingController truckRegistrationPlateController = TextEditingController();
  final FocusNode truckRegistrationPlateFocusNode = FocusNode();
  final TextEditingController truckRegistrationPlateCopyController = TextEditingController();
  final FocusNode truckRegistrationPlateCopyFocusNode = FocusNode();
  final TextEditingController truckLicenseTypeController = TextEditingController();
  final FocusNode truckLicenseTypeFocusNode = FocusNode();
  final TextEditingController splicWeightFromCompanyController = TextEditingController();
  final FocusNode splicWeightFromCompanyFocusNode = FocusNode();
  final TextEditingController splictWeightFromWeightUnitController = TextEditingController();
  final FocusNode splictWeightFromWeightUnitFocusNode = FocusNode();

  // ข้อมูลรถบรรทุก
  String truckTotalWeight = 'น้ำหนักรวมรถบรรทุก';
  String truckLegalWeight = 'น้ำหนักบรรทุกเกินกว่าอัตราที่กฎหมายกำหนดไว้ที่';
  String truckOverWeight = 'จึงเกินกว่าอัตราที่กฎหมายกำหนดไว้';
  String truckAnnounceNo = 'ตามประกาศของผู้อำนวยการทางหลวงชนบทฯ ข้อที่';
  // โดยมีพยานหลักฐานในการกระทำความผิด ดังนี้
  String truckRegistrationPlate = '๑. รถบรรทุก หมายเลขทะเบียน';
  String truckRegistrationPlateCopy = '๒.สำเนาทะเบียนรถ';
  String truckLicenseType = '๓.ใบขับขี่ประเภท';
  String splicWeightFromCompany = '๔.ใบชั่งน้ำหนักจากบริษัท';
  String splictWeightFromWeightUnit = '๕.ใบชั่งน้ำหนักจากหน่วยตรวจสอบน้ำหนักยานพาหนะ/สถานีตรวจสอบน้ำหนักยานพาหนะ';

  @override
  void initState() {
    super.initState();

    setState(() {
      truckTotalWeightController.text = StringHleper.convertStringToKilo(widget.item.isOverWeight == 'Y' ? widget.item.grossWeight : widget.item.grossWeightOver);
      truckLegalWeightController.text = StringHleper.convertStringToKilo(widget.item.legalWeight);
      truckOverWeightController.text = StringHleper.convertStringToKilo(widget.item.grossWeightOver);
    });

    onTextChange('update', 'update');

    updateData();
  }

  void updateData() async {
    if (context.read<ArrestBloc>().state.arrestLogDetail != null && context.read<ArrestBloc>().state.arrestLogDetail!.overWeight != null) {
      ArrestLogDetailModelRes itemUpdate = context.read<ArrestBloc>().state.arrestLogDetail!;

      truckAnnounceNoController.text = itemUpdate.annoucementNo ?? '';
      truckRegistrationPlateController.text = itemUpdate.truckRegistrationPlate ?? '';
      truckRegistrationPlateCopyController.text = itemUpdate.truckRegistrationPlateCopy ?? '';
      truckLicenseTypeController.text = itemUpdate.truckLicenseType ?? '';
      splicWeightFromCompanyController.text = itemUpdate.slipWeightFromCompany ?? '';
      splictWeightFromWeightUnitController.text = itemUpdate.slipWeightFromWeightUnit ?? '';
      setState(() {});
      onTextChange('subdistrictController.text', 'subDistrict');
    }
  }

  void validateForm() {
    // if (newFormKey.currentState!.validate()) {
    //   widget.onStepSubmitForm('step_three');
    // }
    widget.onStepSubmitForm('step_three');
  }

  void onStepFormBack() {
    widget.onStepFormBack('step_three');
  }

  void onTextChange(String? value, nameInput) {
    var payload = ArrestFormStepThreeReq(
      truckTotalWeight: truckTotalWeightController.text,
      legalWeight: truckLegalWeightController.text,
      overWeight: truckOverWeightController.text,
      annoucementNo: truckAnnounceNoController.text,
      truckRegistrationPlate: truckRegistrationPlateController.text,
      truckRegistrationPlateCopy: truckRegistrationPlateCopyController.text,
      truckLicenseType: truckLicenseTypeController.text,
      slipWeightFromCompany: splicWeightFromCompanyController.text,
      slipWeightFromWeightUnit: splictWeightFromWeightUnitController.text,
    );

    logger.i(payload.toJson());

    context.read<ArrestBloc>().add(StepThreeFormEvent(payload));
  }

  @override
  void dispose() {
    super.dispose();

    truckTotalWeightController.dispose();
    truckTotalWeightFocusNode.dispose();
    truckLegalWeightController.dispose();
    truckLegalWeightFocusNode.dispose();
    truckOverWeightController.dispose();
    truckOverWeightFocusNode.dispose();
    truckAnnounceNoController.dispose();
    truckAnnounceNoFocusNode.dispose();
    truckRegistrationPlateController.dispose();
    truckRegistrationPlateFocusNode.dispose();
    truckRegistrationPlateCopyController.dispose();
    truckRegistrationPlateCopyFocusNode.dispose();
    truckLicenseTypeController.dispose();
    truckLicenseTypeFocusNode.dispose();
    splicWeightFromCompanyController.dispose();
    splicWeightFromCompanyFocusNode.dispose();
    splictWeightFromWeightUnitController.dispose();
    splictWeightFromWeightUnitFocusNode.dispose();
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
                  title: 'ข้อมูลรถบรรทุก',
                  imageSvg: 'assets/svg/truck_icon.svg',
                ),
                SizedBox(height: 10.0.h),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabelInputWidget(
                        title: truckTotalWeight,
                        // isRequired: true,
                      ),
                      TextInputWidget(
                        label: truckTotalWeight,
                        hint: truckTotalWeight,
                        controller: truckTotalWeightController,
                        focusNode: truckTotalWeightFocusNode,
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
                        title: truckLegalWeight,
                        // isRequired: true,
                      ),
                      TextInputWidget(
                        label: truckLegalWeight,
                        hint: truckLegalWeight,
                        controller: truckLegalWeightController,
                        focusNode: truckLegalWeightFocusNode,
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
                        title: truckOverWeight,
                        // isRequired: true,
                      ),
                      TextInputWidget(
                        label: truckOverWeight,
                        hint: truckOverWeight,
                        controller: truckOverWeightController,
                        focusNode: truckOverWeightFocusNode,
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
                        title: truckAnnounceNo,
                        // isRequired: true,
                      ),
                      TextInputWidget(
                        label: truckAnnounceNo,
                        hint: truckAnnounceNo,
                        controller: truckAnnounceNoController,
                        focusNode: truckAnnounceNoFocusNode,
                        onTextChange: onTextChange,
                      ),
                    ],
                  ),
                ),
                AutoSizeText(
                  'โดยมีพยานหลักฐานในการกระทำความผิด ดังนี้',
                  style: AppTextStyle.title14normal(),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabelInputWidget(
                        title: truckRegistrationPlate,
                        // isRequired: true,
                      ),
                      TextInputWidget(
                        label: truckRegistrationPlate,
                        hint: truckRegistrationPlate,
                        controller: truckRegistrationPlateController,
                        focusNode: truckRegistrationPlateFocusNode,
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
                        title: truckRegistrationPlateCopy,
                        // isRequired: true,
                      ),
                      TextInputWidget(
                        label: truckRegistrationPlateCopy,
                        hint: truckRegistrationPlateCopy,
                        controller: truckRegistrationPlateCopyController,
                        focusNode: truckRegistrationPlateCopyFocusNode,
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
                        title: truckLicenseType,
                        // isRequired: true,
                      ),
                      TextInputWidget(
                        label: truckLicenseType,
                        hint: truckLicenseType,
                        controller: truckLicenseTypeController,
                        focusNode: truckLicenseTypeFocusNode,
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
                        title: splicWeightFromCompany,
                        // isRequired: true,
                      ),
                      TextInputWidget(
                        label: splicWeightFromCompany,
                        hint: splicWeightFromCompany,
                        controller: splicWeightFromCompanyController,
                        focusNode: splicWeightFromCompanyFocusNode,
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
                        title: splictWeightFromWeightUnit,
                        // isRequired: true,
                      ),
                      TextInputWidget(
                        label: splictWeightFromWeightUnit,
                        hint: splictWeightFromWeightUnit,
                        controller: splictWeightFromWeightUnitController,
                        focusNode: splictWeightFromWeightUnitFocusNode,
                        onTextChange: onTextChange,
                      ),
                    ],
                  ),
                ),
                Divider(color: ColorApps.colorGray),
                AutoSizeText(
                  'จึงแจ้งข้อกล่าวหาให้ผู้ถูกจับกุมทราบว่า กระทําความผิดฐาน ใช้ยานพาหนะที่มีน้ำหนักบรรทุกหรือน้ำหนักลงเพลาเกินกว่า ที่ผู้อํานวยการทางหลวงชนบทกำหนดอันเป็นความผิดตาม พระราชบัญญัติทางหลวง พ.ศ. ๒๕๓๘ แก้ไขเพิ่มเติมโดยพระราชบัญญัติทางหลวง (ฉบับที่ ๒) พ.ศ. ๒๕๔๙ มาตรา ๖๑  มาตรา ๗๓/๒ มีข้อความตามที่ จะกล่าวต่อไปนี้',
                  style: AppTextStyle.title14normal(),
                ),
                AutoSizeText(
                  '             เหตุที่เจ้าพนักงานทางหลวงจับโดยไม่มีหมายจับ เพราะเมื่อบุคคลนั้นได้กระทำความผิดซึ่งหน้าดังได้บัญญัติ ไว้ในประมวลกฎหมายวิธีพิจารณาความอาญา มาตรา ๘๐',
                  style: AppTextStyle.title14normal(),
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
