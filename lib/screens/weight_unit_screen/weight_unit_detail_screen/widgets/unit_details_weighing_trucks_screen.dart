import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:wts_bloc/blocs/establish/establish_bloc.dart';
import 'package:wts_bloc/blocs/weight_car/weight_car_bloc.dart';
import 'package:wts_bloc/data/models/master_data/material/material_model_req.dart';
import 'package:wts_bloc/data/models/master_data/material/material_model_res.dart';
import 'package:wts_bloc/data/models/weight_add_car/weight_add_car_model_req.dart';

import '../../../../blocs/materials/materials_bloc.dart';
import '../../../../blocs/profile/profile_bloc.dart';
import '../../../../blocs/province/province_bloc.dart';
import '../../../../blocs/vehicle_car/vehicle_car_bloc.dart';
import '../../../../blocs/weight_unit/weight_unit_bloc.dart';
import '../../../../data/models/establish/car_detail_model_res.dart';
import '../../../../data/models/establish/car_detali_image_model.res.dart';
import '../../../../data/models/establish/establish_weight_car_req.dart';
import '../../../../data/models/master_data/province/province_res.dart';
import '../../../../data/models/master_data/vehicles/vehicle_req.dart';
import '../../../../data/models/master_data/vehicles/vehicle_res.dart';
import '../../../../main.dart';
import '../../../../service/token_refresh.service.dart';
import '../../../../utils/constants/color_app.dart';
import '../../../../utils/constants/text_style.dart';
import '../../../../utils/libs/role_permission.dart';
import '../../../../utils/libs/string_helper.dart';
import '../../../../utils/libs/weight_unit.dart';
import '../../../../utils/widgets/buttom_sheet_widget/buttom_sheet_alert_widger.dart';
import '../../../../utils/widgets/custom_button.dart';
import '../../../../utils/widgets/inputs/dropdown_input_custom_widget.dart';
import '../../../../utils/widgets/inputs/input_image_update_widget.dart';
import '../../../../utils/widgets/inputs/label_input_widget.dart';
import '../../../../utils/widgets/inputs/text_input_widget.dart';
import '../../../../utils/widgets/inputs/title_widget.dart';
import '../../../../utils/widgets/sneckbar_message.dart';
import '../../../establish/establish_unit/widgets/custom_province_bottom_sheet.dart';
import '../../../widgets/success_screen.dart';
import 'input_shaft_type_widget/shart_type2_widget.dart';
import 'input_shaft_type_widget/shart_type3_12_widget.dart';
import 'input_shaft_type_widget/shart_type3_s_widget.dart';
import 'input_shaft_type_widget/shart_type3_widget.dart';
import 'input_shaft_type_widget/shart_type4_all_widget.dart';
import 'input_shaft_type_widget/shart_type4_s_widget.dart';
import 'input_shaft_type_widget/shart_type4_widget.dart';
import 'input_shaft_type_widget/shart_type5_345_widget.dart';
import 'input_shaft_type_widget/shart_type5_widget.dart';
import 'input_shaft_type_widget/shart_type6_12_34_56_widget.dart';
import 'input_shaft_type_widget/shart_type6_23_56_widget.dart';
import 'input_shaft_type_widget/shart_type6_widget.dart';
import 'input_shaft_type_widget/shart_type7_s_widget.dart';

class UnitDetailsWeighingTrucksScreen extends StatefulWidget {
  const UnitDetailsWeighingTrucksScreen({
    super.key,
    required this.tid,
    required this.tdId,
    required this.isEdit,
  });

  final String tid;
  final String tdId;
  final bool isEdit;

  @override
  State<UnitDetailsWeighingTrucksScreen> createState() =>
      _UnitDetailsWeighingTrucksScreenState();
}

class _UnitDetailsWeighingTrucksScreenState
    extends State<UnitDetailsWeighingTrucksScreen> {
  final newFormKey = GlobalKey<FormState>();

  final TextEditingController carLicenseController = TextEditingController();
  final FocusNode carLicenseFocusNode = FocusNode();

  final TextEditingController carLicenseProvinceController =
      TextEditingController();
  final FocusNode carLicenseProvinceFocusNode = FocusNode();

  final TextEditingController carLicenseTailController =
      TextEditingController();

  final TextEditingController carLicenseTailProvinceController =
      TextEditingController();

  final TextEditingController carTypeController = TextEditingController();
  final FocusNode carTypeFocusNode = FocusNode();

  final TextEditingController carDriveShaftTotalController =
      TextEditingController();
  final FocusNode carDriveShaftTotalFocusNode = FocusNode();

  final TextEditingController carWeightLawController = TextEditingController();
  final FocusNode carWeightLawFocusNode = FocusNode();

  final TextEditingController carTruckMaterialController =
      TextEditingController();

  final TextEditingController carWeightTotalController =
      TextEditingController();
  final FocusNode carWeightTotalFocusNode = FocusNode();

  final TextEditingController carWeightStatusController =
      TextEditingController();
  final FocusNode carWeightStatusFocusNode = FocusNode();

  List<TextEditingController> carDriveShaftController = [];
  List<FocusNode> carDriveShaftFocusNode = [];

  List<double> carWeigthDriveShaftOvers = [];

  String carLicense = 'ทะเบียนรถ';
  String carLicenseProvince = 'จังหวัด';
  String carLicenseTail = 'ทะเบียนรถหางลาก';
  String carLicenseTailProvince = 'จังหวัดหางลาก';
  String carType = 'ประเภทรถบรรทุก';
  String carDriveShaftTotal = 'จำนวนเพลา';
  String carWeightLaw = 'น้ำหนักตามกฎหมาย';
  String carTruckMaterial = 'สิ่งของบรรทุก';
  String carDriveShaft = 'น้ำหนักเพลาที่';
  String carWeightTotal = 'น้ำหนักรวม';
  String carWeightStatus = 'สถานะ';

  bool isUpdate = false;
  bool isUpdateInitVehicle = false;
  int licentProvinceId = 0;
  int tailProvinceId = 0;

  bool isSave = false;

  // TextController

  File? _imageFront;
  File? _imageBack;
  File? _imageLeft;
  File? _imageRight;
  File? _weightSlip;
  File? _license;
  final ImagePicker _picker = ImagePicker();

  List<VehicleRes> vehicleCar = [];

  List<ProvinceModelRes> province = [];

  List<MaterialModelRes> materials = [];

  int driveShaft = 2;

  String materialSearch = '';
  int materialPage = 1;
  int materialPageSize = 20;
  bool isLoadingMore = false;
  bool hasMoreData = true;

  int vehicleClassId = 0;
  bool isCarOverLoad = false;
  Color isCarOverLoadColor = ColorApps.colorText;

  double ds1 = 0;
  double ds2 = 0;
  double ds3 = 0;
  double ds4 = 0;
  double ds5 = 0;
  double ds6 = 0;
  double ds7 = 0;

  CarDetailModelRes? itemCarDetail;

  VehicleRes? selectVehicleType;
  bool isShowIconError2 = false;

  @override
  void initState() {
    super.initState();
    initScreen();
  }

  void initScreen() async {
    getVehicleCarBloc();

    if (widget.tdId.isNotEmpty) {
      getCarUnitDetail();
      getCarImate();
    }

    getProvince();
    getMaterialBloc();

    genControllersWeightShafts(0);
    genWeightShaftsOver(0, 99999999999.0);
  }

  void setDataUpdate(CarDetailModelRes? carDetail) async {
    if (carDetail == null) return;

    logger.i(carDetail.toJson());
    logger.i(
        '============[test]=======0=vehicleClassId: $vehicleClassId==> ${carDetail.toJson()}');

    try {
      setState(() {
        itemCarDetail = carDetail;
      });

      carLicenseController.text = carDetail.lpHeadNo ?? '';
      carLicenseProvinceController.text = carDetail.lpHeadProvinceName ?? '';
      carLicenseTailController.text = carDetail.lpTailNo ?? '';
      carLicenseTailProvinceController.text =
          carDetail.lpTailProvinceName ?? '';
      carTypeController.text = carDetail.vehicleClassDesc ?? '';
      carDriveShaftTotalController.text =
          carDetail.vehicleClassLegalDriveShaftRef ?? '';
      carWeightLawController.text =
          StringHleper.convertStringToKilo(carDetail.legalWeight);
      carTruckMaterialController.text = carDetail.masterialName ?? '';
      carWeightStatusController.text = carDetail.isOverWeightDesc ?? '';

      if (carDetail.grossWeight != null) {
        final grossWeight = StringHleper.stringToDouble(carDetail.grossWeight);
        if (carDetail.isOverWeight == 'Y') {
          carWeightTotalController.text = StringHleper.numberAddComma(
                  WeightUnit.tonToKilo(grossWeight).toString())
              .split('.')[0];
        } else {
          carWeightTotalController.text = StringHleper.numberAddComma(
                  WeightUnit.tonToKilo(grossWeight).toString())
              .split('.')[0];
        }
      }

      carWeightStatusController.text = carDetail.isOverWeightDesc ?? '';

      licentProvinceId = carDetail.lpHeadProvinceId != null
          ? int.tryParse(carDetail.lpHeadProvinceId.toString()) ?? 0
          : 0;
      tailProvinceId = carDetail.lpTailProvinceId != null
          ? int.tryParse(carDetail.lpTailProvinceId.toString()) ?? 0
          : 0;

      if (carDetail.vehicleClassIdRef != null) {
        vehicleClassId =
            int.tryParse(carDetail.vehicleClassIdRef.toString()) ?? 0;
      }

      if (carDetail.isOverWeight == 'N') {
        isCarOverLoadColor = ColorApps.colorGreen;
      } else {
        isCarOverLoadColor = ColorApps.colorRed;
      }

      if (carDetail.vehicleClassLegalDriveShaftRef != null &&
          carDetail.legalWeight != null) {
        final shaftCount =
            int.tryParse(carDetail.vehicleClassLegalDriveShaftRef!) ?? 0;
        final legalWeight = double.tryParse(carDetail.legalWeight!) ?? 0.0;

        if (shaftCount > 0 && legalWeight > 0) {
          await genControllersWeightShafts(shaftCount);
          await genWeightShaftsOver(shaftCount, legalWeight);
        }
      }

      setState(() {});

      List<String> carDetails = [
        carDetail.ds1 != null
            ? WeightUnit.tonToKilo(StringHleper.stringToDouble(carDetail.ds1))
                .toString()
            : '0',
        carDetail.ds2 != null
            ? WeightUnit.tonToKilo(StringHleper.stringToDouble(carDetail.ds2))
                .toString()
            : '0',
        carDetail.ds3 != null
            ? WeightUnit.tonToKilo(StringHleper.stringToDouble(carDetail.ds3))
                .toString()
            : '0',
        carDetail.ds4 != null
            ? WeightUnit.tonToKilo(StringHleper.stringToDouble(carDetail.ds4))
                .toString()
            : '0',
        carDetail.ds5 != null
            ? WeightUnit.tonToKilo(StringHleper.stringToDouble(carDetail.ds5))
                .toString()
            : '0',
        carDetail.ds6 != null
            ? WeightUnit.tonToKilo(StringHleper.stringToDouble(carDetail.ds6))
                .toString()
            : '0',
        carDetail.ds7 != null
            ? WeightUnit.tonToKilo(StringHleper.stringToDouble(carDetail.ds7))
                .toString()
            : '0',
      ];

      setState(() {
        for (int i = 0;
            i < carDriveShaftController.length && i < carDetails.length;
            i++) {
          if (carDetails[i].isNotEmpty && carDetails[i] != '0') {
            carDriveShaftController[i].text = carDetails[i].split('.')[0];
          }
        }
      });

      setState(() {
        ds1 = carDetail.ds1 != null
            ? WeightUnit.tonToKilo(StringHleper.stringToDouble(carDetail.ds1))
            : 0;
        ds2 = carDetail.ds2 != null
            ? WeightUnit.tonToKilo(StringHleper.stringToDouble(carDetail.ds2))
            : 0;
        ds3 = carDetail.ds3 != null
            ? WeightUnit.tonToKilo(StringHleper.stringToDouble(carDetail.ds3))
            : 0;
        ds4 = carDetail.ds4 != null
            ? WeightUnit.tonToKilo(StringHleper.stringToDouble(carDetail.ds4))
            : 0;
        ds5 = carDetail.ds5 != null
            ? WeightUnit.tonToKilo(StringHleper.stringToDouble(carDetail.ds5))
            : 0;
        ds6 = carDetail.ds6 != null
            ? WeightUnit.tonToKilo(StringHleper.stringToDouble(carDetail.ds6))
            : 0;
        ds7 = carDetail.ds7 != null
            ? WeightUnit.tonToKilo(StringHleper.stringToDouble(carDetail.ds7))
            : 0;
      });
    } catch (e) {
      logger.e('=======[update set data error]=====> $e');
    }
  }

  void setDataUpdateImage(CarDetailModelImageRes? carDatailImage) {
    setState(() {
      isUpdate = true;
    });
  }

  void isSelectVehicleType(VehicleRes? selectVehicle) {
    try {
      logger
          .i('=====[isSelectVehicleType]====1====> ${selectVehicle?.toJson()}');

      if (selectVehicle != null) {
        final driveShaftRef = selectVehicle.driveShaftRef;
        final legalWeight = selectVehicle.legalWeight;
        final vehicleClassDesc = selectVehicle.vehicleClassDesc;
        final vehicleClassIdRef = selectVehicle.vehicleClassIdRef;

        if (driveShaftRef != null && legalWeight != null) {
          final shaftCount = int.tryParse(driveShaftRef) ?? 0;
          final weight = double.tryParse(legalWeight) ?? 0.0;

          if (shaftCount > 0 && weight > 0) {
            genWeightShaftsOver(shaftCount, weight);
            genControllersWeightShafts(shaftCount);

            driveShaft = shaftCount;
            carDriveShaftTotalController.text = driveShaftRef;
            carWeightLawController.text =
                StringHleper.convertStringToKilo(legalWeight);
          }
        }

        if (vehicleClassDesc != null) {
          carTypeController.text = vehicleClassDesc;
        }

        if (vehicleClassIdRef != null) {
          vehicleClassId = vehicleClassIdRef;
        }

        selectVehicleType = selectVehicle;
      }
    } catch (e) {
      logger.e('=====[isSelectVehicleType]===error=====> $e');
    }
  }

  void getVehicleCarBloc() {
    var payload = VehicleReq(
      page: 1,
      pageSize: 50,
    );
    context.read<VehicleCarBloc>().add(GetVehicleCarEvent(payload));
  }

  void getProvince() {
    context.read<ProvinceBloc>().add(GetProvince(''));
  }

  void getCarUnitDetail() {
    context.read<EstablishBloc>().add(GetCarDetailEvent(widget.tdId));
  }

  void getCarImate() {
    context
        .read<EstablishBloc>()
        .add(GetCarDetailImageEvent(widget.tid, widget.tdId));
  }

  void getMaterialBloc({bool isLoadMore = false}) {
    if (isLoadMore) {
      materialPage++;
    } else {
      materialPage = 1;
    }

    var payload = MaterialModelReq(
      search: materialSearch,
      page: materialPage,
      pageSize: materialPageSize,
    );
    context.read<MaterialsBloc>().add(GetMaterialsEvent(payload));
  }

  void inputDriveShaft(String? value, nameInput) {
    setState(() {
      isShowIconError2 = true;
    });
    try {
      double total = 0;
      for (var controller in carDriveShaftController) {
        if (controller.text.isNotEmpty) {
          total += double.tryParse(controller.text) ?? 0;
        }
      }

      final legalWeight = double.tryParse(
              StringHleper.numberStringCutComma(carWeightLawController.text)) ??
          0;

      if (total > legalWeight) {
        isCarOverLoad = true;
        carWeightStatusController.text = 'เกินกำหนด';
        isCarOverLoadColor = ColorApps.colorRed;
      } else {
        isCarOverLoad = false;
        carWeightStatusController.text = 'ไม่เกินกำหนด';
        isCarOverLoadColor = ColorApps.colorGreen;
      }

      carWeightTotalController.text =
          StringHleper.doubleToStringComma(total.toString());

      double parsedValue = double.tryParse(value ?? '0') ?? 0;

      switch (nameInput) {
        case 'ds_1':
          ds1 = parsedValue;
          break;
        case 'ds_2':
          ds2 = parsedValue;
          break;
        case 'ds_3':
          ds3 = parsedValue;
          break;
        case 'ds_4':
          ds4 = parsedValue;
          break;
        case 'ds_5':
          ds5 = parsedValue;
          break;
        case 'ds_6':
          ds6 = parsedValue;
          break;
        case 'ds_7':
          ds7 = parsedValue;
          break;
        default:
          logger.i('Unrecognized input name: $nameInput');
      }

      setState(() {});
    } catch (e) {
      logger.e('Error in inputDriveShaft: $e');
    }
  }

  void inputDriveShaft2(String? value, nameInput, bool isOverShaft) {
    try {
      double total = 0;
      for (var controller in carDriveShaftController) {
        if (controller.text.isNotEmpty) {
          total += double.tryParse(controller.text) ?? 0;
        }
      }

      if (isOverShaft) {
        isCarOverLoad = true;
        carWeightStatusController.text = 'เกินเพลา';
        isCarOverLoadColor = ColorApps.contentColorOrenge;
      } else {
        final legalWeight = double.tryParse(StringHleper.numberStringCutComma(
                carWeightLawController.text)) ??
            0;
        if (total > legalWeight) {
          isCarOverLoad = true;
          carWeightStatusController.text = 'เกินกำหนด';
          isCarOverLoadColor = ColorApps.colorRed;
        } else {
          isCarOverLoad = false;
          carWeightStatusController.text = 'ไม่เกินกำหนด';
          isCarOverLoadColor = ColorApps.colorGreen;
        }
      }

      carWeightTotalController.text =
          StringHleper.doubleToStringComma(total.toString());

      double parsedValue = double.tryParse(value ?? '0') ?? 0;

      switch (nameInput) {
        case 'ds_1':
          ds1 = parsedValue;
          break;
        case 'ds_2':
          ds2 = parsedValue;
          break;
        case 'ds_3':
          ds3 = parsedValue;
          break;
        case 'ds_4':
          ds4 = parsedValue;
          break;
        case 'ds_5':
          ds5 = parsedValue;
          break;
        case 'ds_6':
          ds6 = parsedValue;
          break;
        case 'ds_7':
          ds7 = parsedValue;
          break;
        default:
          logger.i('Unrecognized input name: $nameInput');
      }

      setState(() {});
    } catch (e) {
      logger.e('Error in inputDriveShaft2: $e');
    }
  }

  String? getValueFromKey(CarDetailModelRes model, String key) {
    switch (key) {
      case 'ds7':
        return model.ds7;
      case 'ds6':
        return model.ds6;
      case 'ds5':
        return model.ds5;
      case 'ds4':
        return model.ds4;
      case 'ds3':
        return model.ds3;
      case 'ds2':
        return model.ds2;
      case 'ds1':
        return model.ds1;
      default:
        return null;
    }
  }

  double vehicleDs(double ds, String key) {
    double data = ds;

    if (data == 0) {
      if (itemCarDetail != null) {
        final String? value = getValueFromKey(itemCarDetail!, key);
        if (value != null && value.isNotEmpty) {
          data = double.tryParse(value) ?? 0;
        } else {
          data = 0;
        }
      } else {
        data = 0;
      }
    }
    if (data > 0) {
      return WeightUnit.kiloToTon(data);
    } else {
      return 0.0;
    }
  }

  void submitForm() async {
    try {
      setState(() {
        isSave = true;
      });
      var payload = WeightAddCarModelReq(
        tId: widget.tid,
        lpHeadNo: carLicenseController.text.trim(),
        lpHeadProvinceId: licentProvinceId,
        lpTailNo: carLicenseTailController.text.trim(),
        lpTailProvinceId: tailProvinceId,
        vehicleClassId: vehicleClassId,
        materialName: carTruckMaterialController.text.trim(),
        ds1: vehicleDs(ds1, 'ds1'),
        ds2: vehicleDs(ds2, 'ds2'),
        ds3: vehicleDs(ds3, 'ds3'),
        ds4: vehicleDs(ds4, 'ds4'),
        ds5: vehicleDs(ds5, 'ds5'),
        ds6: vehicleDs(ds6, 'ds6'),
        ds7: vehicleDs(ds7, 'ds7'),
        frontImage: _imageFront?.path ?? '',
        backImage: _imageBack?.path ?? '',
        leftImage: _imageLeft?.path ?? '',
        rightImage: _imageRight?.path ?? '',
        slipImage: _weightSlip?.path ?? '',
        licenseImage: _license?.path ?? '',
        tdId: widget.tdId,
      );
      logger.e('=======[submitForm]========');
      logger.e(payload.toJson());

      if (widget.tdId.isNotEmpty) {
        context.read<WeightCarBloc>().add(PutWeightCarEvent(payload));
      } else {
        context.read<WeightCarBloc>().add(PostWeightCarEvent(payload));
      }
    } catch (e) {
      logger.e('=======[submitForm]======> $e');
    }
  }

  void newValidateForm() {
    final List<Map<String, dynamic>> fields = [
      {
        'controller': carLicenseController,
        'focusNode': carLicenseFocusNode,
        'label': 'หมายเลขทะเบียนรถ'
      },
      {
        'controller': carTypeController,
        'focusNode': carTypeFocusNode,
        'label': 'ประเภทของรถ'
      },
      {
        'controller': carDriveShaftTotalController,
        'focusNode': carDriveShaftTotalFocusNode,
        'label': 'จำนวนเพลาขับเคลื่อน'
      },
      {
        'controller': carWeightLawController,
        'focusNode': carWeightLawFocusNode,
        'label': 'น้ำหนักตามกฎหมาย'
      },
      {
        'controller': carWeightTotalController,
        'focusNode': carWeightTotalFocusNode,
        'label': 'น้ำหนักรวม'
      },
      {
        'controller': carWeightStatusController,
        'focusNode': carWeightStatusFocusNode,
        'label': 'สถานะน้ำหนัก'
      },
    ];

    for (int i = 0; i < carDriveShaftController.length; i++) {
      if (i < carDriveShaftFocusNode.length) {
        fields.add({
          'controller': carDriveShaftController[i],
          'focusNode': carDriveShaftFocusNode[i],
          'label': 'เพลาขับเคลื่อน #${i + 1}'
        });
      }
    }

    for (var field in fields) {
      final controller = field['controller'] as TextEditingController?;
      final focusNode = field['focusNode'] as FocusNode?;
      final label = field['label'] as String;

      if (controller != null && controller.text.isEmpty) {
        if (focusNode != null) {
          FocusScope.of(context).requestFocus(focusNode);
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$label กรุณากรอกข้อมูล'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    if (newFormKey.currentState?.validate() == true) {
      submitForm();
    }
  }

  Future<void> _pickImage(String type, ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        setState(() {
          switch (type) {
            case 'front':
              _imageFront = File(image.path);
              break;
            case 'back':
              _imageBack = File(image.path);
              break;
            case 'left':
              _imageLeft = File(image.path);
              break;
            case 'right':
              _imageRight = File(image.path);
              break;
            case 'weight':
              _weightSlip = File(image.path);
              break;
            case 'license':
              _license = File(image.path);
              break;
          }
        });
      }
    } on PlatformException catch (e) {
      if (e.code == 'camera_access_denied') {
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return ButtomSheetAlertWidger(
              titleText: 'กรุณาเปิดการเข้าถึงกล้อง',
              descText:
                  'เพื่ออนุญาตให้ VIS เข้าถึงกล้องเพื่อถ่ายภาพ\nกรุณาไปที่การตั้งค่ามือถือ',
              btnText: 'ไปยังหน้าตั้งค่า',
              iconName: Icons.refresh,
              iconRolate: 90,
              colors: ColorApps.colorDary,
              onTapActions: onTapActions,
              titleIcon: 'icon_camera',
            );
          },
        );
      } else if (e.code == 'photo_access_denied') {
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return ButtomSheetAlertWidger(
              titleText: 'กรุณาเปิดการเข้าถึงรูปภาพ',
              descText:
                  'เพื่ออนุญาตให้ VIS เข้าถึงรูปภาพ\nกรุณาไปที่การตั้งค่ามือถือ',
              btnText: 'ไปยังหน้าตั้งค่า',
              iconName: Icons.refresh,
              iconRolate: 90,
              colors: ColorApps.colorDary,
              onTapActions: onTapActions,
              titleIcon: 'icon_gallary',
            );
          },
        );
      }
    } catch (e) {
      logger.e('Error picking image: $e');
    }
  }

  Future<void> _pickImage2(String type, String? source) async {
    try {
      if (source != null) {
        setState(() {
          switch (type) {
            case 'front':
              _imageFront = File(source);
              break;
            case 'back':
              _imageBack = File(source);
              break;
            case 'left':
              _imageLeft = File(source);
              break;
            case 'right':
              _imageRight = File(source);
              break;
            case 'weight':
              _weightSlip = File(source);
              break;
            case 'license':
              _license = File(source);
              break;
          }
        });
      }
    } on PlatformException catch (e) {
      if (e.code == 'camera_access_denied') {
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return ButtomSheetAlertWidger(
              titleText: 'กรุณาเปิดการเข้าถึงกล้อง',
              descText:
                  'เพื่ออนุญาตให้ VIS เข้าถึงกล้องเพื่อถ่ายภาพ\nกรุณาไปที่การตั้งค่ามือถือ',
              btnText: 'ไปยังหน้าตั้งค่า',
              iconName: Icons.refresh,
              iconRolate: 90,
              colors: ColorApps.colorDary,
              onTapActions: onTapActions,
              titleIcon: 'icon_camera',
            );
          },
        );
      } else if (e.code == 'photo_access_denied') {
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return ButtomSheetAlertWidger(
              titleText: 'กรุณาเปิดการเข้าถึงรูปภาพ',
              descText:
                  'เพื่ออนุญาตให้ VIS เข้าถึงรูปภาพ\nกรุณาไปที่การตั้งค่ามือถือ',
              btnText: 'ไปยังหน้าตั้งค่า',
              iconName: Icons.refresh,
              iconRolate: 90,
              colors: ColorApps.colorDary,
              onTapActions: onTapActions,
              titleIcon: 'icon_gallary',
            );
          },
        );
      }
    } catch (e) {
      logger.e('Error picking image: $e');
    }
  }

  void onTapActions(String value) {
    Navigator.pop(context);
    openAppSettings();
  }

  Future<void> genControllersWeightShafts(int value) async {
    if (value != 0) {
      setState(() {
        carDriveShaftController =
            List.generate(value, (index) => TextEditingController());
        carDriveShaftFocusNode = List.generate(value, (index) => FocusNode());
      });
    }
  }

  Future<void> genWeightShaftsOver(int driveShaft, double legalWeight) async {
    int value = driveShaft;
    double avgShaft = legalWeight;
    int amountShaft = driveShaft;

    double shaft = (avgShaft / amountShaft) * 1000;

    if (shaft.isInfinite || shaft.isNaN) {
      if (value == 0) {
        value = 7;
      }
      setState(() {
        carWeigthDriveShaftOvers = List.generate(value, (index) => 0);
      });
    } else {
      if (value == 0) {
        value = 7;
      }
      setState(() {
        carWeigthDriveShaftOvers = List.generate(value, (index) => shaft);
      });
    }
  }

  void clearForm() async {
    setState(() {
      isSave = false;
    });
    await clearFormInput();
    context.read<ProvinceBloc>().add(ClearSelectProvince());
    context.read<ProvinceBloc>().add(ClearSelectProvinceTail());
    context.read<VehicleCarBloc>().add(ClearSelectVehicleCarEvent());
    context.read<MaterialsBloc>().add(ClearSelectMaterialsEvent());

    getWeightUnitCars();
    getWeightUnitDetail();
  }

  @override
  void dispose() {
    super.dispose();

    carLicenseController.dispose();
    carLicenseFocusNode.dispose();
    carLicenseProvinceController.dispose();
    carLicenseProvinceFocusNode.dispose();
    carLicenseTailController.dispose();
    carLicenseTailProvinceController.dispose();
    carTypeController.dispose();
    carTypeFocusNode.dispose();
    carDriveShaftTotalController.dispose();
    carDriveShaftTotalFocusNode.dispose();
    carWeightLawController.dispose();
    carWeightLawFocusNode.dispose();
    carTruckMaterialController.dispose();
    carWeightTotalController.dispose();
    carWeightTotalFocusNode.dispose();
    carWeightStatusController.dispose();
    carWeightStatusFocusNode.dispose();

    for (var carController in carDriveShaftController) {
      carController.dispose();
    }
    for (var carFocusNode in carDriveShaftFocusNode) {
      carFocusNode.dispose();
    }
  }

  Future<void> clearFormInput() async {
    try {
      carLicenseController.clear();
      carLicenseProvinceController.clear();
      carLicenseTailController.clear();
      carLicenseTailProvinceController.clear();
      carTypeController.clear();
      carDriveShaftTotalController.clear();
      carWeightLawController.clear();
      carTruckMaterialController.clear();
      carWeightTotalController.clear();
      carWeightStatusController.clear();

      FocusScope.of(context).unfocus();
      Navigator.pop(context);
    } catch (e) {
      logger.e('Error clearing form: $e');
    }
  }

  void getWeightUnitCars() {
    var payload = EstablishWeightCarRes(
      tid: widget.tid,
      page: 1,
      pageSize: 20,
      search: '',
      isOverWeight: '',
    );

    context.read<WeightUnitBloc>().add(GetWeightUnitCars(payload));
  }

  void getWeightUnitDetail() {
    context
        .read<EstablishBloc>()
        .add(MobileMasterDepartmentFetchEvent(tid: widget.tid));
  }

  @override
  Widget build(BuildContext context) {
    final profileState = context.read<ProfileBloc>().state;
    var role = profileState.profile?.deptType;
    Provider.of<TokenRefreshService>(context, listen: false)
        .startTokenRefreshTimer();

    Widget buildShaftWidget() {
      switch (vehicleClassId) {
        case 1:
          return ShartType2Widget(
            hint: 'กิโลกรัม',
            carDriveShaftController: carDriveShaftController,
            carDriveShaftFocusNode: carDriveShaftFocusNode,
            onTextChange: inputDriveShaft2,
            shaft1: 2500,
            shaft2: 7000,
            isDisable: RolePermission.checkRoleViewer(role) && widget.isEdit
                ? null
                : true,
          );
        case 2:
          return ShartType2Widget(
            hint: 'กิโลกรัม',
            carDriveShaftController: carDriveShaftController,
            carDriveShaftFocusNode: carDriveShaftFocusNode,
            onTextChange: inputDriveShaft2,
            shaft1: 4000,
            shaft2: 11000,
            isDisable: RolePermission.checkRoleViewer(role) && widget.isEdit
                ? null
                : true,
          );
        case 3:
          return ShartType3Widget(
            hint: 'กิโลกรัม',
            carDriveShaftController: carDriveShaftController,
            carDriveShaftFocusNode: carDriveShaftFocusNode,
            onTextChange: inputDriveShaft2,
            shaft1: 5000,
            shaft23: 13000,
            isDisable: RolePermission.checkRoleViewer(role) && widget.isEdit
                ? null
                : true,
          );
        case 4:
          return ShartType3Widget(
            hint: 'กิโลกรัม',
            carDriveShaftController: carDriveShaftController,
            carDriveShaftFocusNode: carDriveShaftFocusNode,
            onTextChange: inputDriveShaft2,
            shaft1: 5000,
            shaft23: 16500,
            isDisable: RolePermission.checkRoleViewer(role) && widget.isEdit
                ? null
                : true,
          );
        case 5:
          return ShartType3Widget(
            hint: 'กิโลกรัม',
            carDriveShaftController: carDriveShaftController,
            carDriveShaftFocusNode: carDriveShaftFocusNode,
            onTextChange: inputDriveShaft2,
            shaft1: 5000,
            shaft23: 20000,
            isDisable: RolePermission.checkRoleViewer(role) && widget.isEdit
                ? null
                : true,
          );
        case 6:
          return ShartType3sWidget(
            hint: 'กิโลกรัม',
            carDriveShaftController: carDriveShaftController,
            carDriveShaftFocusNode: carDriveShaftFocusNode,
            onTextChange: inputDriveShaft2,
            shaft1: 3000,
            shaft2: 7000,
            shaft3: 11000,
            isDisable: RolePermission.checkRoleViewer(role) && widget.isEdit
                ? null
                : true,
          );
        case 7:
          return ShartType4Widget(
            hint: 'กิโลกรัม',
            carDriveShaftController: carDriveShaftController,
            carDriveShaftFocusNode: carDriveShaftFocusNode,
            onTextChange: inputDriveShaft2,
            shaft12: 10000,
            shaft34: 13000,
            isDisable: RolePermission.checkRoleViewer(role) && widget.isEdit
                ? null
                : true,
          );
        case 8:
          return ShartType4Widget(
            hint: 'กิโลกรัม',
            carDriveShaftController: carDriveShaftController,
            carDriveShaftFocusNode: carDriveShaftFocusNode,
            onTextChange: inputDriveShaft2,
            shaft12: 10000,
            shaft34: 20000,
            isDisable: RolePermission.checkRoleViewer(role) && widget.isEdit
                ? null
                : true,
          );
        case 9:
          return ShartType4sWidget(
            hint: 'กิโลกรัม',
            carDriveShaftController: carDriveShaftController,
            carDriveShaftFocusNode: carDriveShaftFocusNode,
            onTextChange: inputDriveShaft2,
            shaft1: 4000,
            shaft2: 11000,
            shaft34: 20000,
            isDisable: RolePermission.checkRoleViewer(role) && widget.isEdit
                ? null
                : true,
          );
        case 10:
          return ShartType5Widget(
            hint: 'กิโลกรัม',
            carDriveShaftController: carDriveShaftController,
            carDriveShaftFocusNode: carDriveShaftFocusNode,
            onTextChange: inputDriveShaft2,
            shaft1: 5000,
            shaft23: 20000,
            shaft45: 20000,
            isDisable: RolePermission.checkRoleViewer(role) && widget.isEdit
                ? null
                : true,
          );
        case 11:
          return ShartType6Widget(
            hint: 'กิโลกรัม',
            carDriveShaftController: carDriveShaftController,
            carDriveShaftFocusNode: carDriveShaftFocusNode,
            onTextChange: inputDriveShaft2,
            shaft1: 0,
            shaft23: 20000,
            shaft456: 25500,
            isDisable: RolePermission.checkRoleViewer(role) && widget.isEdit
                ? null
                : true,
          );
        case 15:
          return ShartType7SWidget(
            hint: 'กิโลกรัม',
            carDriveShaftController: carDriveShaftController,
            carDriveShaftFocusNode: carDriveShaftFocusNode,
            onTextChange: inputDriveShaft2,
            shaft12: 2500,
            shaft34: 20000,
            shaft567: 25500,
            isDisable: RolePermission.checkRoleViewer(role) && widget.isEdit
                ? null
                : true,
          );
        case 16:
          return ShartType62356Widget(
            hint: 'กิโลกรัม',
            carDriveShaftController: carDriveShaftController,
            carDriveShaftFocusNode: carDriveShaftFocusNode,
            onTextChange: inputDriveShaft2,
            shaft1: 2500,
            shaft23: 20000,
            shaft4: 10000,
            shaft56: 18000,
            isDisable: RolePermission.checkRoleViewer(role) && widget.isEdit
                ? null
                : true,
          );
        case 17:
          return ShartType312Widget(
            hint: 'กิโลกรัม',
            carDriveShaftController: carDriveShaftController,
            carDriveShaftFocusNode: carDriveShaftFocusNode,
            onTextChange: inputDriveShaft2,
            shaft12: 1000,
            shaft3: 11000,
            isDisable: RolePermission.checkRoleViewer(role) && widget.isEdit
                ? null
                : true,
          );
        case 18:
          return ShartType4AllWidget(
            hint: 'กิโลกรัม',
            carDriveShaftController: carDriveShaftController,
            carDriveShaftFocusNode: carDriveShaftFocusNode,
            onTextChange: inputDriveShaft2,
            shaft1: 4000,
            shaft2: 11000,
            shaft3: 11000,
            shaft4: 11000,
            isDisable: RolePermission.checkRoleViewer(role) && widget.isEdit
                ? null
                : true,
          );
        case 19:
          return ShartType4AllWidget(
            hint: 'กิโลกรัม',
            carDriveShaftController: carDriveShaftController,
            carDriveShaftFocusNode: carDriveShaftFocusNode,
            onTextChange: inputDriveShaft2,
            shaft1: 4000,
            shaft2: 11000,
            shaft3: 7000,
            shaft4: 7000,
            isDisable: RolePermission.checkRoleViewer(role) && widget.isEdit
                ? null
                : true,
          );
        case 20:
          return ShartType6123456Widget(
            hint: 'กิโลกรัม',
            carDriveShaftController: carDriveShaftController,
            carDriveShaftFocusNode: carDriveShaftFocusNode,
            onTextChange: inputDriveShaft2,
            shaft12: 1000,
            shaft34: 20000,
            shaft56: 20000,
            isDisable: RolePermission.checkRoleViewer(role) && widget.isEdit
                ? null
                : true,
          );
        case 21:
          return ShartType5345Widget(
            hint: 'กิโลกรัม',
            carDriveShaftController: carDriveShaftController,
            carDriveShaftFocusNode: carDriveShaftFocusNode,
            onTextChange: inputDriveShaft2,
            shaft1: 4000,
            shaft2: 11000,
            shaft345: 25500,
            isDisable: RolePermission.checkRoleViewer(role) && widget.isEdit
                ? null
                : true,
          );
        case 22:
          return ShartType4AllWidget(
            hint: 'กิโลกรัม',
            carDriveShaftController: carDriveShaftController,
            carDriveShaftFocusNode: carDriveShaftFocusNode,
            onTextChange: inputDriveShaft2,
            shaft1: 4000,
            shaft2: 11000,
            shaft3: 7000,
            shaft4: 7000,
            isDisable: RolePermission.checkRoleViewer(role) && widget.isEdit
                ? null
                : true,
          );
        case 23:
          return ShartType6123456Widget(
            hint: 'กิโลกรัม',
            carDriveShaftController: carDriveShaftController,
            carDriveShaftFocusNode: carDriveShaftFocusNode,
            onTextChange: inputDriveShaft2,
            shaft12: 1000,
            shaft34: 20000,
            shaft56: 20000,
            isDisable: RolePermission.checkRoleViewer(role) && widget.isEdit
                ? null
                : true,
          );
        case 24:
          return ShartType5345Widget(
            hint: 'กิโลกรัม',
            carDriveShaftController: carDriveShaftController,
            carDriveShaftFocusNode: carDriveShaftFocusNode,
            onTextChange: inputDriveShaft2,
            shaft1: 4000,
            shaft2: 11000,
            shaft345: 25500,
            isDisable: RolePermission.checkRoleViewer(role) && widget.isEdit
                ? null
                : true,
          );
        default:
          return Wrap(
            spacing: 26.w,
            runSpacing: 12.w,
            children: List.generate(carDriveShaftController.length, (index) {
              return ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 150,
                  maxWidth: MediaQuery.of(context).size.width / 2 - 32,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelInputWidget(
                      title: '${carDriveShaft} ${index + 1}',
                      isRequired: true,
                    ),
                    TextInputWidget(
                      label: 'ds_${index + 1}',
                      hint: 'กิโลกรัม',
                      controller: carDriveShaftController[index],
                      focusNode: carDriveShaftFocusNode[index],
                      onTextChange: inputDriveShaft,
                      keyBoardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      isSuffixIcon: true,
                      isCalDriveShaft: index < carWeigthDriveShaftOvers.length
                          ? carWeigthDriveShaftOvers[index]
                          : 0,
                      isDs: true,
                      isShowIconError2: isShowIconError2,
                      isDisable:
                          RolePermission.checkRoleViewer(role) && widget.isEdit
                              ? null
                              : true,
                    ),
                  ],
                ),
              );
            }),
          );
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Theme.of(context).colorScheme.surface,
            size: 22.h,
          ),
          onPressed: () {
            clearForm();
          },
        ),
        title: Text(
          'การเข้าชั่งน้ำหนัก',
          textAlign: TextAlign.center,
          style: AppTextStyle.title18bold(
              color: Theme.of(context).colorScheme.surface),
        ),
      ),
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
                BlocListener<EstablishBloc, EstablishState>(
                  listener: (context, state) {
                    if (state.carDetailStatus ==
                        CarInUnitDetailStatus.success) {
                      if (state.carDetail != null &&
                          state.carDetail?.lpHeadNo != null) {
                        setDataUpdate(state.carDetail);
                      }
                    }
                    if (state.carDetailStatus == CarInUnitDetailStatus.error &&
                        state.carDetailError == '') {
                      showSnackbarBottom(
                          context, state.carDetailError.toString());
                    }
                  },
                  child: const SizedBox.shrink(),
                ),
                BlocListener<EstablishBloc, EstablishState>(
                  listener: (context, state) {
                    if (state.carInUnitDetailImageStatus ==
                        CarInUnitDetailImageStatus.success) {
                      if (state.carDatailImage != null) {
                        setDataUpdateImage(state.carDatailImage);
                      }
                    }
                    if (state.carInUnitDetailImageStatus ==
                            CarInUnitDetailImageStatus.error &&
                        state.carDetailError == '') {
                      showSnackbarBottom(
                          context, state.carDetailError.toString());
                    }
                  },
                  child: const SizedBox.shrink(),
                ),
                BlocListener<WeightCarBloc, WeightCarState>(
                  listener: (context, state) {
                    if (state.weightCarStatus == WeightCarStatus.loading) {
                      isSave = true;
                    }
                    if (state.weightCarStatus == WeightCarStatus.success) {
                      clearForm();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SuccessScreen(
                            icon:
                                'assets/svg/ant-design_check-circle-filled.svg',
                            titleBT: 'กลับหน้าแรก',
                            title: 'บันทึกการเข้าชั่งสำเร็จ',
                            message:
                                'สามารถเข้าดูรายละเอียดที่หน้า "รายงานรถเข้าชั่ง"',
                            onConfirm: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      );
                    }
                    if (state.weightCarStatus == WeightCarStatus.error &&
                        state.weightCarError.isNotEmpty) {
                      showSnackbarBottom(
                          context, state.weightCarError.toString());
                    }
                  },
                  child: const SizedBox.shrink(),
                ),
                TitleWidget(
                  title: 'รายละเอียดรถบรรทุก',
                  icon: Icons.location_on,
                ),
                SizedBox(height: 12.0.h),
                LabelInputWidget(
                  title: carLicense,
                  isRequired: true,
                ),
                TextInputWidget(
                  label: carLicense,
                  hint: carLicense,
                  controller: carLicenseController,
                  focusNode: carLicenseFocusNode,
                  keyBoardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  isDisable:
                      RolePermission.checkRoleViewer(role) && widget.isEdit
                          ? null
                          : true,
                ),
                SizedBox(height: 12.0.h),
                LabelInputWidget(
                  title: carLicenseProvince,
                  isRequired: true,
                ),
                BlocListener<ProvinceBloc, ProvinceState>(
                  listener: (context, state) {
                    if (state.provinceStatus == ProvinceStatus.success) {
                      province = state.province ?? [];
                    }
                    if (state.selectProvince != null) {
                      final selectedProvince = state.selectProvince!;
                      if (selectedProvince.id != null &&
                          selectedProvince.name != null) {
                        licentProvinceId = selectedProvince.id!;
                        carLicenseProvinceController.text =
                            selectedProvince.name!;
                      }
                    }
                  },
                  child: DropdownInputCustomWidget(
                    label: "Text Input 1",
                    hint: carLicenseProvince,
                    controller: carLicenseProvinceController,
                    isDisable:
                        RolePermission.checkRoleViewer(role) && widget.isEdit
                            ? null
                            : true,
                    onTap: () => {
                      if (RolePermission.checkRoleViewer(role) && widget.isEdit)
                        {
                          showModalBottomSheet(
                            backgroundColor:
                                Theme.of(context).colorScheme.surface,
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
                                builder: (BuildContext context,
                                    ScrollController scrollController) {
                                  return CustomModalBottomSheet(
                                    data_list: province,
                                    scrollController: scrollController,
                                    title: carLicenseProvince,
                                    onClose: (result) {
                                      Navigator.pop(context, result);
                                    },
                                  );
                                },
                              );
                            },
                          ).then((onValue) {
                            getProvince();
                          })
                        }
                    },
                  ),
                ),
                SizedBox(height: 12.0.h),
                LabelInputWidget(
                  title: carLicenseTail,
                ),
                TextInputWidget(
                  label: "Text Input 1",
                  hint: carLicenseTail,
                  controller: carLicenseTailController,
                  keyBoardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  isDisable:
                      RolePermission.checkRoleViewer(role) && widget.isEdit
                          ? null
                          : true,
                ),
                SizedBox(height: 12.0.h),
                LabelInputWidget(
                  title: carLicenseTailProvince,
                ),
                BlocListener<ProvinceBloc, ProvinceState>(
                  listener: (context, state) {
                    if (state.selectProvinceTail != null) {
                      final selectedProvinceTail = state.selectProvinceTail!;
                      if (selectedProvinceTail.id != null &&
                          selectedProvinceTail.name != null) {
                        tailProvinceId = selectedProvinceTail.id!;
                        carLicenseTailProvinceController.text =
                            selectedProvinceTail.name!;
                      }
                    }
                  },
                  child: DropdownInputCustomWidget(
                    label: "Text Input 1",
                    hint: carLicenseTailProvince,
                    controller: carLicenseTailProvinceController,
                    isDisable:
                        RolePermission.checkRoleViewer(role) && widget.isEdit
                            ? null
                            : true,
                    onTap: () => {
                      if (RolePermission.checkRoleViewer(role) && widget.isEdit)
                        {
                          showModalBottomSheet(
                            backgroundColor:
                                Theme.of(context).colorScheme.surface,
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
                                builder: (BuildContext context,
                                    ScrollController scrollController) {
                                  return CustomModalBottomSheet(
                                    data_list: province,
                                    scrollController: scrollController,
                                    title: carLicenseTailProvince,
                                    onClose: (result) {
                                      Navigator.pop(context, result);
                                    },
                                  );
                                },
                              );
                            },
                          ).then((onValue) {
                            getProvince();
                          })
                        }
                    },
                  ),
                ),
                SizedBox(height: 12.0.h),
                LabelInputWidget(
                  title: carType,
                  isRequired: true,
                ),
                BlocListener<VehicleCarBloc, VehicleCarState>(
                  listener: (context, state) {
                    if (state.vehicleCarStatus == VehicleCarStatus.success) {
                      vehicleCar = state.vehicleCar ?? [];
                    }
                    if (state.selectVehicle != null) {
                      isSelectVehicleType(state.selectVehicle);
                    }
                  },
                  child: DropdownInputCustomWidget(
                    label: "Text Input 1",
                    hint: carType,
                    controller: carTypeController,
                    isDisable:
                        RolePermission.checkRoleViewer(role) && widget.isEdit
                            ? null
                            : true,
                    onTap: () => {
                      if (RolePermission.checkRoleViewer(role) && widget.isEdit)
                        {
                          showModalBottomSheet(
                            backgroundColor:
                                Theme.of(context).colorScheme.surface,
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
                                builder: (BuildContext context,
                                    ScrollController scrollController) {
                                  return CustomModalBottomSheet(
                                    data_list: vehicleCar,
                                    scrollController: scrollController,
                                    title: carType,
                                    isUseSearch: false,
                                    onClose: (result) {
                                      Navigator.pop(context, result);
                                    },
                                  );
                                },
                              );
                            },
                          ).then((onValue) {
                            getVehicleCarBloc();
                          })
                        }
                    },
                  ),
                ),
                SizedBox(height: 12.w),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LabelInputWidget(
                            title: carDriveShaftTotal,
                            isRequired: true,
                          ),
                          TextInputWidget(
                            label: "Text Input 1",
                            hint: carDriveShaftTotal,
                            controller: carDriveShaftTotalController,
                            isDisable: true,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LabelInputWidget(
                            title: carWeightLaw,
                            isRequired: true,
                          ),
                          TextInputWidget(
                            label: "Text Input 1",
                            hint: carWeightLaw,
                            controller: carWeightLawController,
                            isDisable: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.0),
                LabelInputWidget(
                  title: carTruckMaterial,
                ),
                BlocListener<MaterialsBloc, MaterialsState>(
                  listener: (context, state) {
                    if (state.materialStatus == MaterialsStatus.success) {
                      materials = state.materials ?? [];

                      // อัพเดทสถานะ pagination
                      if (state.materials != null &&
                          state.materials.length < materialPageSize) {
                        hasMoreData = false;
                      }
                    }

                    if (state.loadMore == false) {
                      setState(() {
                        isLoadingMore = false;
                      });
                    }

                    if (state.material?.goodsName != null) {
                      carTruckMaterialController.text =
                          state.material!.goodsName!;
                    }
                  },
                  child: DropdownInputCustomWidget(
                    label: "Text Input 1",
                    hint: carTruckMaterial,
                    controller: carTruckMaterialController,
                    isDisable:
                        RolePermission.checkRoleViewer(role) && widget.isEdit
                            ? null
                            : true,
                    onTap: () {
                      if (RolePermission.checkRoleViewer(role) &&
                          widget.isEdit) {
                        // รีเซ็ตค่า pagination ก่อนเปิด modal
                        setState(() {
                          materialPage = 1;
                          hasMoreData = true;
                          isLoadingMore = false;
                        });

                        showModalBottomSheet(
                          backgroundColor:
                              Theme.of(context).colorScheme.surface,
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
                              builder: (BuildContext context,
                                  ScrollController scrollController) {
                                // เพิ่ม scroll listener สำหรับ pagination
                                scrollController.addListener(() {
                                  if (scrollController.position.pixels >=
                                      scrollController
                                              .position.maxScrollExtent -
                                          200) {
                                    if (!isLoadingMore && hasMoreData) {
                                      setState(() {
                                        isLoadingMore = true;
                                      });
                                      getMaterialBloc(isLoadMore: true);
                                    }
                                  }
                                });

                                return BlocBuilder<MaterialsBloc,
                                    MaterialsState>(
                                  builder: (context, state) {
                                    return Column(
                                      children: [
                                        Expanded(
                                          child: CustomModalBottomSheet(
                                            data_list: materials,
                                            scrollController: scrollController,
                                            title: carTruckMaterial,
                                            onClose: (result) {
                                              Navigator.pop(context, result);
                                            },
                                          ),
                                        ),
                                        // แสดง loading indicator เมื่อกำลังโหลดข้อมูลเพิ่ม
                                        if (state.loadMore == true)
                                          Container(
                                            padding: EdgeInsets.all(16.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 16.0,
                                                  height: 16.0,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 2.0,
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                            Color>(
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .primary,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 12.0),
                                                Text(
                                                  'กำลังโหลดข้อมูลเพิ่มเติม...',
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurface,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ).then((onValue) {
                          setState(() {
                            materialPage = 1;
                            hasMoreData = true;
                            isLoadingMore = false;
                          });
                          getMaterialBloc();
                        });
                      }
                    },
                  ),
                ),
                SizedBox(height: 12.w),
                buildShaftWidget(),
                SizedBox(height: 12.w),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LabelInputWidget(
                            title: carWeightTotal,
                            isRequired: true,
                          ),
                          TextInputWidget(
                            label: "Text Input 1",
                            hint: carWeightTotal,
                            controller: carWeightTotalController,
                            isDisable: true,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LabelInputWidget(
                            title: carWeightStatus,
                            isRequired: true,
                          ),
                          TextInputWidget(
                            label: "Text Input 1",
                            hint: carWeightStatus,
                            controller: carWeightStatusController,
                            isDisable: true,
                            isCustomStyleColorText: true,
                            customStyleColorText: isCarOverLoadColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 18.0),
                TitleWidget(
                  title: 'รูปการจัดตั้งหน่วยชั่ง',
                  icon: Icons.photo_size_select_actual_outlined,
                ),
                SizedBox(height: 12.w),
                if (isUpdate)
                  Wrap(
                    spacing: 26.w,
                    runSpacing: 12.w,
                    children: [
                      BlocBuilder<EstablishBloc, EstablishState>(
                        builder: (context, state) {
                          if (state.carInUnitDetailImageStatus ==
                              CarInUnitDetailImageStatus.success) {
                            if (state.carDatailImage != null) {
                              return InputImageUpdateWidget(
                                  imageUrl:
                                      state.carDatailImage!.imagePath1 ?? '',
                                  label: 'ด้านหน้า',
                                  keyName: 'front',
                                  isDisable: widget.isEdit,
                                  onSelectImage: (type, source) {
                                    _pickImage2(type, source);
                                  });
                            }
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                      BlocBuilder<EstablishBloc, EstablishState>(
                        builder: (context, state) {
                          if (state.carInUnitDetailImageStatus ==
                              CarInUnitDetailImageStatus.success) {
                            if (state.carDatailImage != null) {
                              return InputImageUpdateWidget(
                                  imageUrl:
                                      state.carDatailImage!.imagePath2 ?? '',
                                  label: 'ด้านหลัง',
                                  keyName: 'back',
                                  isDisable: widget.isEdit,
                                  onSelectImage: (type, source) {
                                    _pickImage2(type, source);
                                  });
                            }
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                      BlocBuilder<EstablishBloc, EstablishState>(
                        builder: (context, state) {
                          if (state.carInUnitDetailImageStatus ==
                              CarInUnitDetailImageStatus.success) {
                            if (state.carDatailImage != null) {
                              return InputImageUpdateWidget(
                                  imageUrl:
                                      state.carDatailImage!.imagePath3 ?? '',
                                  label: 'ด้านซ้าย',
                                  keyName: 'left',
                                  isDisable: widget.isEdit,
                                  onSelectImage: (type, source) {
                                    _pickImage2(type, source);
                                  });
                            }
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                      BlocBuilder<EstablishBloc, EstablishState>(
                        builder: (context, state) {
                          if (state.carInUnitDetailImageStatus ==
                              CarInUnitDetailImageStatus.success) {
                            if (state.carDatailImage != null) {
                              return InputImageUpdateWidget(
                                  imageUrl:
                                      state.carDatailImage!.imagePath4 ?? '',
                                  label: 'ด้านขวา',
                                  keyName: 'right',
                                  isDisable: widget.isEdit,
                                  onSelectImage: (type, source) {
                                    _pickImage2(type, source);
                                  });
                            }
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                      BlocBuilder<EstablishBloc, EstablishState>(
                        builder: (context, state) {
                          if (state.carInUnitDetailImageStatus ==
                              CarInUnitDetailImageStatus.success) {
                            if (state.carDatailImage != null) {
                              return InputImageUpdateWidget(
                                  imageUrl:
                                      state.carDatailImage!.imagePath5 ?? '',
                                  label: 'สลิปน้ำหนัก',
                                  keyName: 'weight',
                                  isDisable: widget.isEdit,
                                  onSelectImage: (type, source) {
                                    _pickImage2(type, source);
                                  });
                            }
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                      BlocBuilder<EstablishBloc, EstablishState>(
                        builder: (context, state) {
                          if (state.carInUnitDetailImageStatus ==
                              CarInUnitDetailImageStatus.success) {
                            if (state.carDatailImage != null) {
                              return InputImageUpdateWidget(
                                  imageUrl:
                                      state.carDatailImage!.imagePath6 ?? '',
                                  label: 'ใบขับขี่',
                                  keyName: 'license',
                                  isDisable: widget.isEdit,
                                  onSelectImage: (String, source) {
                                    _pickImage2(String, source);
                                  });
                            }
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                if (!isUpdate)
                  Wrap(
                    spacing: 26.w,
                    runSpacing: 12.w,
                    children: [
                      _buildImagePicker('ด้านหน้า', _imageFront, 'front', role),
                      _buildImagePicker('ด้านหลัง', _imageBack, 'back', role),
                      _buildImagePicker('ด้านซ้าย', _imageLeft, 'left', role),
                      _buildImagePicker('ด้านขวา', _imageRight, 'right', role),
                      _buildImagePicker(
                          'สลิปน้ำหนัก', _weightSlip, 'weight', role),
                      _buildImagePicker('ใบขับขี่', _license, 'license', role),
                    ],
                  ),
                SizedBox(height: 12.w),
                if (RolePermission.checkRoleViewer(role) && widget.isEdit)
                  CustomeButton(
                    text: 'บันทึกการเข้าชั่ง',
                    onPressed: newValidateForm,
                    disable: isSave,
                  ),
                SizedBox(height: 22.w),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker(
      String label, File? imageFile, String type, int? role) {
    return GestureDetector(
      onTap: () {
        select_photo_bottom_sheet(
          context,
          () {
            _pickImage(type, ImageSource.camera);
            Navigator.pop(context);
          },
          () {
            _pickImage(type, ImageSource.gallery);
            Navigator.pop(context);
          },
        );
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 150,
          maxWidth: MediaQuery.of(context).size.width / 2 - 32,
        ),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 10),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.title16bold(),
                ),
              ],
            ),
            imageFile == null
                ? Container(
                    margin: EdgeInsets.all(8),
                    height: 150.w,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      border: Border.all(color: ColorApps.grayBorder),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Icon(Icons.add),
                  )
                : GestureDetector(
                    onTap: () {
                      showPreviewImage(context, imageFile);
                    },
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.all(8),
                          height: 150.w,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            border: Border.all(color: ColorApps.grayBorder),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: Image.file(imageFile, fit: BoxFit.cover),
                          ),
                        ),
                        Positioned(
                          top: 2,
                          right: 2,
                          child: IconButton(
                            icon: const Icon(
                              Icons.image,
                              color: ColorApps.colorText,
                            ),
                            tooltip: '',
                            onPressed: () {
                              select_photo_bottom_sheet(
                                context,
                                () {
                                  _pickImage(type, ImageSource.camera);
                                  Navigator.pop(context);
                                },
                                () {
                                  _pickImage(type, ImageSource.gallery);
                                  Navigator.pop(context);
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showPreviewImage(BuildContext context, File image) {
    return showDialog<dynamic>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          elevation: 0,
          content: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.file(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> select_photo_bottom_sheet(
      BuildContext context, Function() tab_camera, Function() tab_gallery) {
    return showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.surface,
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width,
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 16.0,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: tab_camera,
                child: Row(
                  children: [
                    Container(
                        height: 32.h,
                        width: 32.h,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(90.r)),
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: Theme.of(context).colorScheme.surface,
                          size: 20.h,
                        )),
                    SizedBox(width: 12.w),
                    Text(
                      'เปิดกล้องถ่ายรูป',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.title18bold(
                          color: Theme.of(context).colorScheme.primary),
                    )
                  ],
                ),
              ),
              Divider(),
              InkWell(
                onTap: tab_gallery,
                child: Row(
                  children: [
                    Container(
                        height: 32.h,
                        width: 32.h,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(90.r)),
                        child: Icon(
                          Icons.photo_size_select_actual_outlined,
                          color: Theme.of(context).colorScheme.surface,
                          size: 20.h,
                        )),
                    SizedBox(width: 12.w),
                    Text(
                      'เลือกรูปจากคลังภาพ',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.title18bold(
                          color: Theme.of(context).colorScheme.primary),
                    )
                  ],
                ),
              ),
              SizedBox(height: 40.h),
            ],
          ),
        );
      },
    );
  }
}
