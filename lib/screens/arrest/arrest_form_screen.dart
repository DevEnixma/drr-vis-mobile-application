import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wts_bloc/blocs/arrest/arrest_bloc.dart';

import '../../blocs/weight_unit/weight_unit_bloc.dart';
import '../../data/models/establish/establish_weight_car_req.dart';
import '../../data/models/establish/mobile_car_model.dart';
import '../../utils/constants/text_style.dart';
import '../../utils/libs/string_helper.dart';
import '../../utils/widgets/custom_loading_pagination.dart';
import '../../utils/widgets/sneckbar_message.dart';
import '../establish/establish_unit/widgets/custom_bottom_sheet_widget.dart';
import '../widgets/success_screen.dart';
import 'widgets/form_widget/form_stepfour_widget.dart';
import 'widgets/form_widget/form_stepone_widget.dart';
import 'widgets/form_widget/form_stepthree_widget.dart';
import 'widgets/form_widget/form_steptwo_widget.dart';

class ArrestFormScreen extends StatefulWidget {
  const ArrestFormScreen({
    super.key,
    required this.item,
  });

  final MobileCarModel item;

  @override
  State<ArrestFormScreen> createState() => _ArrestFormScreenState();
}

class _ArrestFormScreenState extends State<ArrestFormScreen> {
  int selectedStep = 0;
  bool isSelectedStep1 = true;
  bool isSelectedStep2 = false;
  bool isSelectedStep3 = false;
  bool isSelectedStep4 = false;
  PageController pageController = PageController();
  int initialPage = 0;

  @override
  void initState() {
    selectedStep = initialPage;
    pageController = PageController(initialPage: initialPage);
    super.initState();

    initScreen();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void initScreen() {
    if (widget.item.arrestId != null) {
      getArrestLogDetailBloc(widget.item.arrestId.toString());
    }
  }

  void onSubmitForm() {
    if (widget.item.arrestId != null) {
      context
          .read<ArrestBloc>()
          .add(PutArrestFormEvent(int.parse(widget.item.tdId!)));
    } else {
      context
          .read<ArrestBloc>()
          .add(PostArrestFormEvent(int.parse(widget.item.tdId!)));
    }
  }

  void onClearForm() {
    context.read<ArrestBloc>().add(ClearFomrArrestEvent());
  }

  void getWeightUnitCars() {
    var payload = EstablishWeightCarRes(
      tid: widget.item.tId,
      page: 1,
      pageSize: 20,
      search: '',
      isOverWeight: '1',
    );

    context.read<WeightUnitBloc>().add(GetWeightUnitCars(payload));
  }

  void updateIsArrestStatus(String arrestFormPostId) {
    context
        .read<WeightUnitBloc>()
        .add(UpdateIsArrestUnitsEvent(widget.item.tdId!, arrestFormPostId));
  }

  void onBackPage(String arrestFormPostId) {
    onClearForm();
    updateIsArrestStatus(arrestFormPostId);
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  void getArrestLogDetailBloc(String arrestId) {
    context.read<ArrestBloc>().add(GetArrestLogDetail(arrestId.toString()));
  }

  void onStepSubmitForm(String value) {
    setState(() {
      if (selectedStep == 0) {
        isSelectedStep2 = true;
        pageController.animateToPage(1,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut);
      } else if (selectedStep == 1) {
        isSelectedStep3 = true;
        pageController.animateToPage(2,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut);
      } else if (selectedStep == 2) {
        isSelectedStep4 = true;
        pageController.animateToPage(3,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut);
      } else if (selectedStep == 3) {
        showCustomBottomSheetConfirm(context);
      }
    });
  }

  void onStepFormBack(String value) {
    setState(() {
      if (selectedStep == 0) {
        _showCustomBottomSheetConfirmBack(context);
      } else if (selectedStep == 1) {
        isSelectedStep2 = false;
        pageController.animateToPage(0,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut);
      } else if (selectedStep == 2) {
        isSelectedStep3 = false;
        pageController.animateToPage(1,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut);
      } else if (selectedStep == 3) {
        isSelectedStep4 = false;
        pageController.animateToPage(2,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    MobileCarModel item = widget.item;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Theme.of(context).colorScheme.surface,
          ),
          onPressed: () {
            onClearForm();
            Navigator.pop(context);
            FocusScope.of(context).unfocus();
          },
        ),
        title: Text(
          'การจับกุม',
          textAlign: TextAlign.center,
          style: AppTextStyle.title18bold(
              color: Theme.of(context).colorScheme.surface),
        ),
      ),
      body: Stack(
        children: [
          MultiBlocListener(
            listeners: [
              // Listener สำหรับ ArrestForm Submit
              BlocListener<ArrestBloc, ArrestState>(
                listenWhen: (previous, current) =>
                    previous.arrestFormStatus != current.arrestFormStatus,
                listener: (context, state) {
                  if (state.arrestFormStatus == ArrestFormStatus.success) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SuccessScreen(
                          icon: 'assets/svg/ant-design_check-circle-filled.svg',
                          titleBT: 'กลับหน้าแรก',
                          title: 'บันทึกการจับกุมสำเร็จ',
                          message: '',
                          onConfirm: () {
                            onBackPage(state.arrestFormPostId);
                          },
                        ),
                      ),
                    );
                  }

                  if (state.arrestFormStatus == ArrestFormStatus.error &&
                      state.arrestError != null &&
                      state.arrestError!.isNotEmpty) {
                    showSnackbarBottom(context, state.arrestError!);
                  }
                },
              ),

              BlocListener<ArrestBloc, ArrestState>(
                listenWhen: (previous, current) =>
                    previous.arrestLogDetailStatus !=
                    current.arrestLogDetailStatus,
                listener: (context, state) {
                  if (state.arrestLogDetailStatus ==
                          ArrestLogDetailStatus.error &&
                      state.arrestLogDetailError != null &&
                      state.arrestLogDetailError!.isNotEmpty) {
                    showSnackbarBottom(context, state.arrestLogDetailError!);
                  }
                },
              ),
            ],
            child: const SizedBox.shrink(),
          ),
          GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  color: Color(0xFF5671EE),
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    'รายละเอียดรถบรรทุก ${StringHleper.checkString(item.lpHeadNo)} ${StringHleper.checkString(item.lpHeadProvinceName)}',
                    style: AppTextStyle.title16normal(
                        color: Theme.of(context).colorScheme.surface),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: (isSelectedStep1)
                                    ? _buildselectedStep(context,
                                        textStep: '1',
                                        textUnder: 'ข้อมูลคนขับรถ',
                                        active: true)
                                    : _buildselectedStep(context,
                                        textStep: '1',
                                        textUnder: 'ข้อมูลการจำคุก',
                                        active: false),
                              ),
                              Expanded(
                                child: (isSelectedStep2)
                                    ? _buildselectedStep(context,
                                        textStep: '2',
                                        textUnder: 'ข้อมูลรถบรรทุก',
                                        active: true)
                                    : _buildselectedStep(context,
                                        textStep: '2',
                                        textUnder: 'ข้อมูลรถบรรทุก',
                                        active: false),
                              ),
                              Expanded(
                                child: (isSelectedStep3)
                                    ? _buildselectedStep(context,
                                        textStep: '3',
                                        textUnder: 'ข้อมูลการจับกุม',
                                        active: true)
                                    : _buildselectedStep(context,
                                        textStep: '3',
                                        textUnder: 'ข้อมูลการจับกุม',
                                        active: false),
                              ),
                              Expanded(
                                child: (isSelectedStep4)
                                    ? _buildselectedStep(context,
                                        textStep: '4',
                                        textUnder: 'ข้อมูลการจำคุก',
                                        active: true)
                                    : _buildselectedStep(context,
                                        textStep: '4',
                                        textUnder: 'ข้อมูลการจำคุก',
                                        active: false),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: 15.h),
                              Container(
                                margin: EdgeInsets.only(top: 10.h),
                                height: 5.h,
                                width: 30.w,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10.h),
                                height: 5.h,
                                width: 30.w,
                                decoration: BoxDecoration(
                                  color: (isSelectedStep2 && isSelectedStep3)
                                      ? Theme.of(context).colorScheme.primary
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10.h),
                                height: 5.h,
                                width: 30.w,
                                decoration: BoxDecoration(
                                  color: (isSelectedStep2 &&
                                          isSelectedStep3 &&
                                          isSelectedStep4)
                                      ? Theme.of(context).colorScheme.primary
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                              SizedBox(width: 15.h),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView(
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (value) => setState(() {
                      selectedStep = value;
                    }),
                    children: <Widget>[
                      // Step 1
                      BlocBuilder<ArrestBloc, ArrestState>(
                        builder: (context, state) {
                          // Loading state
                          if (state.arrestLogDetailStatus ==
                              ArrestLogDetailStatus.loading) {
                            return const Center(
                                child: CustomLoadingPagination());
                          }

                          if (state.arrestLogDetailStatus ==
                              ArrestLogDetailStatus.error) {
                            return Center(
                              child: Padding(
                                padding: EdgeInsets.all(24.h),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.error_outline,
                                      size: 64.h,
                                      color:
                                          Theme.of(context).colorScheme.error,
                                    ),
                                    SizedBox(height: 16.h),
                                    Text(
                                      'เกิดข้อผิดพลาด',
                                      style: AppTextStyle.title18bold(),
                                    ),
                                    SizedBox(height: 8.h),
                                    Text(
                                      state.arrestLogDetailError ??
                                          'ไม่สามารถโหลดข้อมูลได้',
                                      style: AppTextStyle.title14normal(),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 24.h),
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        if (widget.item.arrestId != null) {
                                          getArrestLogDetailBloc(
                                              widget.item.arrestId.toString());
                                        }
                                      },
                                      icon: Icon(Icons.refresh),
                                      label: Text('ลองอีกครั้ง'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        foregroundColor: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 24.w,
                                          vertical: 12.h,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }

                          // Success or initial state
                          return FormSteponeWidget(
                              item: item,
                              onStepSubmitForm: onStepSubmitForm,
                              onStepFormBack: onStepFormBack);
                        },
                      ),

                      // Step 2
                      BlocBuilder<ArrestBloc, ArrestState>(
                        builder: (context, state) {
                          if (state.arrestLogDetailStatus ==
                                  ArrestLogDetailStatus.success ||
                              state.arrestLogDetailStatus ==
                                  ArrestLogDetailStatus.initial) {
                            return FormSteptwoWidget(
                                item: item,
                                onStepSubmitForm: onStepSubmitForm,
                                onStepFormBack: onStepFormBack);
                          }

                          return const SizedBox.shrink();
                        },
                      ),

                      // Step 3
                      BlocBuilder<ArrestBloc, ArrestState>(
                        builder: (context, state) {
                          if (state.arrestLogDetailStatus ==
                                  ArrestLogDetailStatus.success ||
                              state.arrestLogDetailStatus ==
                                  ArrestLogDetailStatus.initial) {
                            return FormStepthreeWidget(
                                item: item,
                                onStepSubmitForm: onStepSubmitForm,
                                onStepFormBack: onStepFormBack);
                          }

                          return const SizedBox.shrink();
                        },
                      ),

                      // Step 4
                      BlocBuilder<ArrestBloc, ArrestState>(
                        builder: (context, state) {
                          if (state.arrestLogDetailStatus ==
                                  ArrestLogDetailStatus.success ||
                              state.arrestLogDetailStatus ==
                                  ArrestLogDetailStatus.initial) {
                            return FormStepfourWidget(
                                onStepSubmitForm: onStepSubmitForm,
                                onStepFormBack: onStepFormBack);
                          }

                          return const SizedBox.shrink();
                        },
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

  void _showCustomBottomSheetConfirmBack(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width,
      ),
      builder: (BuildContext context) {
        return CustomBottomSheetWidget(
          icon: 'question_icon_shadow',
          title: 'กลับหน้าหลัก',
          message:
              'ถ้ากลับหน้าหลักข้อมูลหน้านี้จะหายไป \nคุณต้องการ กลับหน้าหลัก ใช่หรือไม่  ?',
          onConfirm: () {
            onClearForm();
            Navigator.popUntil(context, (route) => route.isFirst);
          },
          onCancel: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void showCustomBottomSheetConfirm(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width,
      ),
      builder: (BuildContext context) {
        return CustomBottomSheetWidget(
          icon: 'question_icon_shadow',
          title: 'ยืนยันการจับกุม',
          message: 'ท่านยืนยันที่จะบันทึกการจับกุมใช่หรือไม่ ?',
          onConfirm: () {
            onSubmitForm();
          },
          onCancel: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }
}

Widget _buildselectedStep(context,
    {required String textStep,
    required String textUnder,
    required bool active}) {
  return Container(
    margin: EdgeInsets.only(bottom: 5.h),
    padding: EdgeInsets.all(5.h),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
          width: 2,
          color: active
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onTertiary),
      color: Theme.of(context).colorScheme.surface,
    ),
    child: Center(
      child: Text(textStep,
          style: AppTextStyle.title14bold(
              color: active
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onTertiary)),
    ),
  );
}
