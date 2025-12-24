import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import '../../../app/routes/routes.dart';
import '../../../blocs/collaborative/collaborative_bloc.dart';
import '../../../blocs/establish/establish_bloc.dart';
import '../../../blocs/ways/ways_bloc.dart';
import '../../../data/models/collaborative/collaborative_res.dart';
import '../../../data/models/establish/establish_add_unit.req.dart';
import '../../../data/models/home/join_weight_unit.dart';
import '../../../data/models/master_data/ways/ways_res.dart';
import '../../../local_storage.dart';
import '../../../main.dart';
import '../../../service/token_refresh.service.dart';
import '../../../utils/constants/color_app.dart';
import '../../../utils/constants/key_localstorage.dart';
import '../../../utils/constants/text_formatter.dart';
import '../../../utils/constants/text_style.dart';
import '../../../utils/libs/convert_date.dart';
import '../../../utils/permission_device/location_device.dart';
import '../../../utils/widgets/buttom_sheet_widget/buttom_sheet_alert_widger.dart';
import '../../../utils/widgets/custom_button.dart';
import '../../../utils/widgets/custom_loading.dart';
import '../../../utils/widgets/inputs/dropdown_input_custom_widget.dart';
import '../../../utils/widgets/inputs/label_input_widget.dart';
import '../../../utils/widgets/inputs/text_input_widget.dart';
import '../../../utils/widgets/inputs/title_widget.dart';
import '../../../utils/widgets/sneckbar_message.dart';
import '../../establish/establish_add_item_screen/widgets/collaborative_list_widget.dart';
import '../../establish/widgets/custom_route_bottom_sheet.dart';
import '../../widgets/success_screen.dart';

class CreateWeightUnitScreen extends StatefulWidget {
  const CreateWeightUnitScreen({super.key});

  @override
  State<CreateWeightUnitScreen> createState() => _CreateWeightUnitScreenState();
}

class _CreateWeightUnitScreenState extends State<CreateWeightUnitScreen> {
  // TODO: new Code
  final newFormKey = GlobalKey<FormState>();
  final TextEditingController nameRouterController = TextEditingController();
  final FocusNode nameRouterFocusNode = FocusNode();

  final TextEditingController addressController = TextEditingController();
  final FocusNode addressFocusNode = FocusNode();

  final TextEditingController routerCodeController = TextEditingController();
  final FocusNode routerCodeFocusNode = FocusNode();

  final TextEditingController collaborativeController = TextEditingController();
  final FocusNode collaborativeFocusNode = FocusNode();

  final TextEditingController routeStartController = TextEditingController();
  final FocusNode routeStartFocusNode = FocusNode();

  final TextEditingController routeEndController = TextEditingController();
  final FocusNode routeEndFocusNode = FocusNode();

  String routerCode = 'รหัสสายทาง';
  String collaborative = 'ผู้ร่วมบูรณาการ';
  String routeName = 'ชื่อสายทาง';
  String routeAddress = 'ที่อยู่';
  String routeStart = 'เริ่ม กม. ที่';
  String routeEnd = 'ถึง กม. ที่';

  int page = 1;
  int pageSize = 20;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  List<CollaborativeRes>? collaborativeList = [];
  List<WaysRes>? ways = [];

  double? currentLatitude;
  double? currentLongitude;
  bool isLoadingLocation = false;
  String? locationError;

  // TODO: old code
  bool disableButton = false;
  final GlobalKey<FormState> formKey = GlobalKey();

  bool isValidateImageTraffic = false;
  bool isValidateImageOfficer = false;
  File? _imageTraffic;
  File? _imageOfficer;
  final ImagePicker _picker = ImagePicker();

  final GlobalKey _routeCodeKey = GlobalKey();

  final FocusNode _routeCodeFocusNode = FocusNode();
  final FocusNode _startKMFocusNode = FocusNode();
  final FocusNode _toKMFocusNode = FocusNode();

  TextEditingController _routeCodeControl = TextEditingController();
  TextEditingController collaburativeText = TextEditingController();
  TextEditingController _nameRouteCodeControl = TextEditingController();
  TextEditingController _addressControl = TextEditingController();
  TextEditingController _startKMControl = TextEditingController();
  TextEditingController _toKMControl = TextEditingController();

  List partnersSelectList = [];

  final LocalStorage storage = LocalStorage();

  @override
  void initState() {
    super.initState();
    initScreen();
    _loadExistingLocation();
    _getCurrentLocation();
  }

  void initScreen() async {
    getCollaborativeBloc();
  }

  Future<void> _loadExistingLocation() async {
    try {
      double? lat = await storage.getValueDouble(KeyLocalStorage.lat);
      double? lng = await storage.getValueDouble(KeyLocalStorage.lng);

      if (lat != null && lng != null) {
        setState(() {
          currentLatitude = lat;
          currentLongitude = lng;
        });
        logger
            .i('Loaded existing location: $currentLatitude, $currentLongitude');
      }
    } catch (e) {
      logger.e('Error loading existing location: $e');
    }
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      isLoadingLocation = true;
      locationError = null;
    });

    try {
      await getCurrentLocation();

      double? lat = await storage.getValueDouble(KeyLocalStorage.lat);
      double? lng = await storage.getValueDouble(KeyLocalStorage.lng);

      setState(() {
        currentLatitude = lat;
        currentLongitude = lng;
        isLoadingLocation = false;
      });

      logger.i(
          'Retrieved location from storage: $currentLatitude, $currentLongitude');
    } catch (e) {
      setState(() {
        isLoadingLocation = false;
        locationError = e.toString();
      });
      logger.e('Error getting location: $e');

      if (mounted) {
        showSnackbarBottom(
            context, 'ไม่สามารถดึงตำแหน่งปัจจุบันได้: ${e.toString()}');
      }
    }
  }

  Future<void> _refreshLocation() async {
    await _getCurrentLocation();
  }

  void getCollaborativeBloc() {
    context.read<CollaborativeBloc>().add(const GetCollaborativeEvent());
  }

  void confirmCollaborativeBloc() {
    context.read<CollaborativeBloc>().add(const ConfirmCollaborativeEvent());
  }

  void submitForm() async {
    var payload = EstablishAddUnitReq(
      wid: context.read<WaysBloc>().state.selectedWay!.id,
      collaboration: collaborativeController.text,
      kmFrom: routeStartController.text,
      kmTo: routeEndController.text,
      file1: _imageTraffic?.path,
      file2: _imageOfficer?.path,
      latitude: currentLatitude,
      longitude: currentLongitude,
    );
    logger.i(payload.toJson());

    context.read<EstablishBloc>().add(CreateUnitWeight(payload));
  }

  void newValidateForm() {
    if (_imageTraffic == null || _imageOfficer == null) {
      showSnackbarBottom(context, 'กรุณาเพิ่มรูปภาพให้ครบ');
      return;
    }

    if (currentLatitude == null || currentLongitude == null) {
      showSnackbarBottom(
          context, 'กรุณารอการดึงตำแหน่งปัจจุบัน หรือลองดึงใหม่อีกครั้ง');
      return;
    }

    if (newFormKey.currentState!.validate()) {
      submitForm();
    }
  }

  void createUnitSuccess() async {
    context.read<EstablishBloc>().add(ResetCreateUnitWeight());

    leaveJoinWeightUnit();
  }

  void leaveJoinWeightUnit() async {
    String? username = await storage.getValueString(KeyLocalStorage.username);
    String? weightUnitId =
        await storage.getValueString(KeyLocalStorage.weightUnitId);

    context
        .read<EstablishBloc>()
        .add(DeleteWeightUnitLeaveEvent(weightUnitId!, username ?? ''));
    joinWeightUnit();
  }

  void joinWeightUnit() async {
    String? username = await storage.getValueString(KeyLocalStorage.username);
    String? weightUnitId =
        await storage.getValueString(KeyLocalStorage.weightUnitId);

    var payload = JoinWeightUnitReq(
      tId: int.parse(weightUnitId!),
      username: username ?? '',
    );
    context
        .read<EstablishBloc>()
        .add(PostJoinWeightUnit(payload, 'success_screen'));
  }

  void GetWeightUnitsIsJoinEventBloc() {
    context.read<EstablishBloc>().add(
          GetWeightUnitsIsJoinEvent(
            startDate: ConvertDate.convertDateToYYYYDDMM(
                ConvertDate.dateTimeYearSubstract(startDate, 1)),
            endDate: ConvertDate.convertDateToYYYYDDMM(
                ConvertDate.dateTimeYearAdd(endDate, 1)),
            page: page,
            pageSize: pageSize,
          ),
        );
  }

  void getWeightUnitAll() {
    context.read<EstablishBloc>().add(
          MobileMasterFetchEvent(
            startDate: ConvertDate.convertDateToYYYYDDMM(
                ConvertDate.dateTimeYearSubstract(startDate, 1)),
            endDate: ConvertDate.convertDateToYYYYDDMM(
                ConvertDate.dateTimeYearAdd(endDate, 1)),
            page: page,
            pageSize: pageSize,
          ),
        );
  }

  Widget buildLocationStatus() {
    return Container(
      padding: EdgeInsets.all(12.h),
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: ColorApps.grayBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ตำแหน่งปัจจุบัน',
                      style: AppTextStyle.title14bold(),
                    ),
                    if (isLoadingLocation)
                      Text(
                        'กำลังดึงตำแหน่ง...',
                        style: AppTextStyle.label12normal(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      )
                    else if (currentLatitude != null &&
                        currentLongitude != null)
                      Text(
                        'Lat: ${currentLatitude!.toStringAsFixed(6)}, Lon: ${currentLongitude!.toStringAsFixed(6)}',
                        style: AppTextStyle.label12normal(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      )
                    else if (locationError != null)
                      Text(
                        'ไม่สามารถดึงตำแหน่งได้',
                        style: AppTextStyle.label12normal(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                  ],
                ),
              ),
              if (!isLoadingLocation &&
                  (currentLatitude == null || currentLongitude == null))
                IconButton(
                  onPressed: _refreshLocation,
                  icon: Icon(
                    Icons.refresh,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20.h,
                  ),
                ),
            ],
          ),
          SizedBox(height: 12.h),
          Container(
            height: 200.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: ColorApps.grayBorder),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: isLoadingLocation
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'กำลังดึงตำแหน่ง...',
                            style: AppTextStyle.label12normal(),
                          ),
                        ],
                      ),
                    )
                  : currentLatitude != null && currentLongitude != null
                      ? FlutterMap(
                          options: MapOptions(
                            initialCenter:
                                LatLng(currentLatitude!, currentLongitude!),
                            initialZoom: 15.0,
                            interactionOptions: InteractionOptions(
                              flags: InteractiveFlag.none,
                            ),
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png',
                              subdomains: ['a', 'b', 'c'],
                              userAgentPackageName: 'com.example.app',
                              maxZoom: 19,
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  point: LatLng(
                                      currentLatitude!, currentLongitude!),
                                  width: 30.w,
                                  height: 30.h,
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                    size: 30.h,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.5),
                                        blurRadius: 4,
                                        offset: Offset(1, 1),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Container(
                          color: Colors.grey[200],
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_off,
                                  color: Theme.of(context).colorScheme.error,
                                  size: 32.h,
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  'ไม่สามารถแสดงตำแหน่งได้',
                                  style: AppTextStyle.label12normal(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                TextButton(
                                  onPressed: _refreshLocation,
                                  child: Text(
                                    'ลองใหม่',
                                    style: AppTextStyle.label12bold(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _routeCodeFocusNode.dispose();
    _startKMFocusNode.dispose();
    _toKMFocusNode.dispose();
    nameRouterController.dispose();
    nameRouterFocusNode.dispose();
    addressController.dispose();
    addressFocusNode.dispose();

    routerCodeController.dispose();
    routerCodeFocusNode.dispose();

    collaborativeController.dispose();
    collaborativeFocusNode.dispose();

    routeStartController.dispose();
    routeStartFocusNode.dispose();
    routeEndController.dispose();
    routeEndFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<TokenRefreshService>(context, listen: false)
        .startTokenRefreshTimer();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        _routeCodeFocusNode.unfocus();
        _startKMFocusNode.unfocus();
        _toKMFocusNode.unfocus();
        nameRouterFocusNode.unfocus();
        addressFocusNode.unfocus();
        routerCodeFocusNode.unfocus();
        collaborativeFocusNode.unfocus();
        routeStartFocusNode.unfocus();
        routeEndFocusNode.unfocus();
      },
      child: Scaffold(
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
              Navigator.pop(context);
            },
          ),
          title: Text(
            'จัดตั้งหน่วย',
            textAlign: TextAlign.center,
            style: AppTextStyle.title18bold(
                color: Theme.of(context).colorScheme.surface),
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 12.h),
                child: Form(
                  key: newFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleWidget(
                        title: 'ที่ตั้งหน่วย',
                        icon: Icons.location_on,
                      ),
                      SizedBox(height: 12.w),
                      buildLocationStatus(),
                      LabelInputWidget(
                        title: routerCode,
                        isRequired: true,
                      ),
                      BlocListener<WaysBloc, WaysState>(
                        listener: (context, state) {
                          if (state.waysStatus == WaysStatus.success) {
                            if (state.ways != null && state.ways!.isNotEmpty) {
                              ways = state.ways!;
                            } else {
                              ways = [];
                            }
                          }
                          if (state.selectedWay!.id != null) {
                            routerCodeController.text =
                                state.selectedWay!.wayCode ?? '';
                          }
                        },
                        child: DropdownInputCustomWidget(
                          label: "Text Input 1",
                          hint: routerCode,
                          controller: routerCodeController,
                          focusNode: routerCodeFocusNode,
                          onTap: () => {
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
                                    return CustomRouteBottomSheet(
                                      scrollController: scrollController,
                                      title: routerCode,
                                      onClose: (String result) {
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                );
                              },
                            ).then((onValue) {})
                          },
                        ),
                      ),
                      SizedBox(height: 12.w),
                      LabelInputWidget(
                        title: collaborative,
                      ),
                      BlocListener<CollaborativeBloc, CollaborativeState>(
                        listener: (context, state) {
                          if (state.collaborativeStatus ==
                              CollaborativeStatus.success) {
                            if (state.collaborative != null &&
                                state.collaborative!.isNotEmpty) {
                              collaborativeList = state.collaborative!;
                            } else {
                              collaborativeList = [];
                            }
                          }
                          if (state.isSelectedCollaborativeText != null) {
                            collaborativeController.text =
                                state.isSelectedCollaborativeText!;
                          }
                        },
                        child: DropdownInputCustomWidget(
                          label: "Text Input 1",
                          hint: collaborative,
                          controller: collaborativeController,
                          onTap: () => {
                            showModalBottomSheet(
                              backgroundColor:
                                  Theme.of(context).colorScheme.surface,
                              context: context,
                              isScrollControlled: true,
                              constraints: BoxConstraints(
                                minWidth: MediaQuery.of(context).size.width,
                              ),
                              builder: (BuildContext context) {
                                double initialChildSize = 0.7;
                                return StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setModalState) {
                                  return DraggableScrollableSheet(
                                    initialChildSize: initialChildSize,
                                    minChildSize: 0.7,
                                    maxChildSize: 0.9,
                                    expand: false,
                                    builder: (BuildContext context,
                                        ScrollController scrollController) {
                                      return CollaborativeListWidget(
                                        data_list: collaborativeList!,
                                        scrollController: scrollController,
                                        title: collaborative,
                                        onClose: (result) {
                                          Navigator.pop(context, result);
                                        },
                                        onSearchFocused: (isFocused) {},
                                      );
                                    },
                                  );
                                });
                              },
                            ).then((onValue) {})
                          },
                        ),
                      ),
                      SizedBox(height: 12.w),
                      BlocListener<WaysBloc, WaysState>(
                        listener: (context, state) {
                          if (state.wayDetailStatus ==
                              WayDetailStatus.success) {
                            nameRouterController.text =
                                state.waysDetailRes!.subdistrict ?? '';
                            addressController.text =
                                state.waysDetailRes!.district ?? '';
                          }
                        },
                        child: SizedBox.shrink(),
                      ),
                      LabelInputWidget(
                        title: routeName,
                      ),
                      TextInputWidget(
                        label: "Text Input 1",
                        hint: routeName,
                        controller: nameRouterController,
                        isMultiLine: true,
                        isDisable: true,
                      ),
                      SizedBox(height: 12.w),
                      LabelInputWidget(
                        title: routeAddress,
                      ),
                      TextInputWidget(
                        label: "Text Input 2",
                        hint: routeAddress,
                        controller: addressController,
                        isMultiLine: true,
                        isDisable: true,
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
                                  title: routeStart,
                                  isRequired: true,
                                ),
                                TextInputWidget(
                                  label: "Text Input 1",
                                  hint: routeStart,
                                  controller: routeStartController,
                                  focusNode: routeStartFocusNode,
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
                                  title: routeEnd,
                                  isRequired: true,
                                ),
                                TextInputWidget(
                                  label: "Text Input 1",
                                  hint: routeEnd,
                                  controller: routeEndController,
                                  focusNode: routeEndFocusNode,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 18.w),
                      TitleWidget(
                        title: 'รูปการจัดตั้งหน่วยชั่ง',
                        icon: Icons.photo_size_select_actual_outlined,
                      ),
                      SizedBox(height: 12.w),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LabelInputWidget(
                            title: '1. จัดจราจรตั้งหน่วยชั่ง',
                            isRequired: true,
                          ),
                          _imageTraffic == null
                              ? SizedBox.shrink()
                              : IconButton(
                                  onPressed: () {
                                    select_photo_bottom_sheet(
                                      context,
                                      () {
                                        _pickImageTraffic(ImageSource.camera);
                                        Navigator.pop(context);
                                      },
                                      () {
                                        _pickImageTraffic(ImageSource.gallery);
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                  icon: Icon(
                                    Icons.add_photo_alternate,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    size: 22.h,
                                  ),
                                )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(8.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: isValidateImageTraffic == false
                                  ? ColorApps.grayBorder
                                  : Theme.of(context).colorScheme.error,
                              width: 1,
                            )),
                        height: 130.h,
                        width: double.infinity,
                        child: _imageTraffic == null
                            ? InkWell(
                                onTap: () {
                                  select_photo_bottom_sheet(
                                    context,
                                    () {
                                      _pickImageTraffic(ImageSource.camera);
                                      Navigator.pop(context);
                                    },
                                    () {
                                      _pickImageTraffic(ImageSource.gallery);
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.add),
                                    Text(
                                      'อัปโหลดรูป',
                                      textAlign: TextAlign.center,
                                      style: AppTextStyle.title16bold(),
                                    )
                                  ],
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  showPreviewImage(context, _imageTraffic!);
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: Image.file(
                                    _imageTraffic!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                      ),
                      isValidateImageTraffic == false
                          ? SizedBox.shrink()
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'กรุณา อัปโหลดรูป',
                                style: AppTextStyle.label12bold(
                                    color: Theme.of(context).colorScheme.error),
                              ),
                            ),
                      SizedBox(height: 12.w),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LabelInputWidget(
                            title: '2. เจ้าหน้าที่ร่วมตั้งหน่วยชั่ง',
                            isRequired: true,
                          ),
                          _imageOfficer == null
                              ? SizedBox.shrink()
                              : IconButton(
                                  onPressed: () {
                                    select_photo_bottom_sheet(
                                      context,
                                      () {
                                        _pickImageOfficer(ImageSource.camera);
                                        Navigator.pop(context);
                                      },
                                      () {
                                        _pickImageOfficer(ImageSource.gallery);
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                  icon: Icon(
                                    Icons.add_photo_alternate,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    size: 22.h,
                                  ),
                                ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(8.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: isValidateImageOfficer == false
                                  ? ColorApps.grayBorder
                                  : Theme.of(context).colorScheme.error,
                              width: 1,
                            )),
                        height: 130.h,
                        width: double.infinity,
                        child: _imageOfficer == null
                            ? InkWell(
                                onTap: () {
                                  select_photo_bottom_sheet(
                                    context,
                                    () {
                                      _pickImageOfficer(ImageSource.camera);
                                      Navigator.pop(context);
                                    },
                                    () {
                                      _pickImageOfficer(ImageSource.gallery);
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.add),
                                    Text(
                                      'อัปโหลดรูป',
                                      textAlign: TextAlign.center,
                                      style: AppTextStyle.title16bold(),
                                    )
                                  ],
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  showPreviewImage(context, _imageOfficer!);
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: Image.file(
                                    _imageOfficer!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                      ),
                      isValidateImageOfficer == false
                          ? SizedBox.shrink()
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'กรุณา อัปโหลดรูป',
                                style: AppTextStyle.label12bold(
                                    color: Theme.of(context).colorScheme.error),
                              ),
                            ),
                      SizedBox(height: 22.w),
                      CustomeButton(
                        text: 'จัดตั้งหน่วย',
                        onPressed: newValidateForm,
                      ),
                      BlocListener<EstablishBloc, EstablishState>(
                        listenWhen: (previous, current) =>
                            previous.createEstablishStatus !=
                            current.createEstablishStatus,
                        listener: (context, state) {
                          if (state.createEstablishStatus ==
                              CreateEstablishStatus.loading) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              CustomLoading.showLoadingDialog(context,
                                  Theme.of(context).colorScheme.primary);
                            });
                          }

                          if (state.createEstablishStatus ==
                              CreateEstablishStatus.success) {
                            createUnitSuccess();

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SuccessScreen(
                                  icon:
                                      'assets/svg/ant-design_check-circle-filled.svg',
                                  titleBT: 'ไปยังหน่วย',
                                  title: 'ตั้งหน่วยสำเร็จ',
                                  message: 'สามารถเริ่มการเข้าชั่งน้ำหนัก',
                                  onConfirm: () {
                                    GetWeightUnitsIsJoinEventBloc();
                                    getWeightUnitAll();
                                    Routes.gotoWeightUnitDetailsScreen(
                                        context,
                                        context
                                            .read<EstablishBloc>()
                                            .state
                                            .createEstablishUnit!
                                            .tId
                                            .toString());
                                  },
                                  onCancel: () {
                                    GetWeightUnitsIsJoinEventBloc();
                                    getWeightUnitAll();
                                    Navigator.popUntil(
                                        context, (route) => route.isFirst);
                                  },
                                ),
                              ),
                            );
                          }

                          if (state.createEstablishStatus ==
                              CreateEstablishStatus.error) {
                            if (mounted && Navigator.canPop(context)) {
                              Navigator.pop(context);
                            }
                            if (mounted &&
                                state.createEstablishError != null &&
                                state.createEstablishError!.isNotEmpty) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                showSnackbarBottom(
                                    context, state.createEstablishError!);
                              });
                            }
                          }
                        },
                        child: SizedBox(height: 22.w),
                      ),
                    ],
                  ),
                ),
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
        });
  }

  Future<dynamic> select_photo_bottom_sheet(
      BuildContext context, Function() tab_camera, Function() tab_gallery) {
    _routeCodeFocusNode.unfocus();
    _startKMFocusNode.unfocus();
    _toKMFocusNode.unfocus();
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

  Widget textFormFieldInput(
    TextEditingController controller,
    FocusNode? focus_node,
    Key? key,
  ) {
    return TextFormField(
      key: key,
      focusNode: focus_node,
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [CustomTextInputFormatter()],
      style: AppTextStyle.title18normal(),
      cursorColor: Theme.of(context).colorScheme.onSecondary,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: ColorApps.grayBorder)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onTertiary,
              width: 1,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(
              color: ColorApps.grayBorder,
              width: 1,
            )),
        errorStyle: AppTextStyle.label12bold(
            color: Theme.of(context).colorScheme.error),
      ),
      validator: (value) {
        if (value!.isEmpty || value == '') {
          return 'กรุณากรอกข้อมูล';
        } else {
          return null;
        }
      },
      onChanged: (v) {
        if (formKey.currentState!.validate()) {
          disableButton = true;
        } else {
          disableButton = false;
        }
        setState(() {});
      },
    );
  }

  void openPermission(String value) {
    Navigator.pop(context);
    openAppSettings();
  }

  Future<void> _pickImageTraffic(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        File originalFile = File(pickedFile.path);

        final fileSize = await originalFile.length();

        File finalFile = originalFile;

        if (fileSize > 500 * 1024) {
          logger.i(
              'Traffic image size: ${(fileSize / 1024).toStringAsFixed(2)} KB, compressing...');

          final dir = await getTemporaryDirectory();
          final targetPath = path.join(
            dir.path,
            'traffic_${DateTime.now().millisecondsSinceEpoch}_compressed.jpg',
          );

          var result = await FlutterImageCompress.compressAndGetFile(
            originalFile.absolute.path,
            targetPath,
            quality: 70,
            minWidth: 1024,
            minHeight: 1024,
            format: CompressFormat.jpeg,
          );

          if (result != null) {
            finalFile = File(result.path);
            final compressedSize = await finalFile.length();
            logger.i(
                'Compressed to: ${(compressedSize / 1024).toStringAsFixed(2)} KB');
            logger.i(
                'Saved: ${((fileSize - compressedSize) / fileSize * 100).toStringAsFixed(1)}%');
          }
        }

        setState(() {
          _imageTraffic = finalFile;
          isValidateImageTraffic = false;
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
              onTapActions: openPermission,
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
              onTapActions: openPermission,
              titleIcon: 'icon_gallary',
            );
          },
        );
      }
    } catch (e) {
      logger.e('Error picking traffic image: $e');
    }
  }

  Future<void> _pickImageOfficer(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        File originalFile = File(pickedFile.path);

        final fileSize = await originalFile.length();

        File finalFile = originalFile;

        if (fileSize > 500 * 1024) {
          logger.i(
              'Officer image size: ${(fileSize / 1024).toStringAsFixed(2)} KB, compressing...');

          final dir = await getTemporaryDirectory();
          final targetPath = path.join(
            dir.path,
            'officer_${DateTime.now().millisecondsSinceEpoch}_compressed.jpg',
          );

          var result = await FlutterImageCompress.compressAndGetFile(
            originalFile.absolute.path,
            targetPath,
            quality: 70,
            minWidth: 1024,
            minHeight: 1024,
            format: CompressFormat.jpeg,
          );

          if (result != null) {
            finalFile = File(result.path);
            final compressedSize = await finalFile.length();
            logger.i(
                'Compressed to: ${(compressedSize / 1024).toStringAsFixed(2)} KB');
            logger.i(
                'Saved: ${((fileSize - compressedSize) / fileSize * 100).toStringAsFixed(1)}%');
          }
        }

        setState(() {
          _imageOfficer = finalFile;
          isValidateImageOfficer = false;
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
              onTapActions: openPermission,
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
              onTapActions: openPermission,
              titleIcon: 'icon_gallary',
            );
          },
        );
      }
    } catch (e) {
      logger.e('Error picking officer image: $e');
    }
  }
}
