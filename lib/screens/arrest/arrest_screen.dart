import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../app/routes/routes.dart';
import '../../blocs/establish/establish_bloc.dart';
import '../../blocs/weight_unit/weight_unit_bloc.dart';
import '../../data/models/establish/establish_weight_car_req.dart';
import '../../data/models/establish/mobile_car_model.dart';
import '../../local_storage.dart';
import '../../service/token_refresh.service.dart';
import '../../utils/constants/color_app.dart';
import '../../utils/constants/key_localstorage.dart';
import '../../utils/constants/text_style.dart';
import '../../utils/widgets/custom_loading_pagination.dart';
import '../../utils/widgets/skeletion_widgets/skeletion_container_widget.dart';
import '../establish/establish_unit/widgets/custom_bottom_sheet_widget.dart';
import '../weight_unit_screen/weight_unit_detail_screen/widgets/car_item_widget.dart';
import '../widgets/empty_widget.dart';
import '../widgets/success_screen.dart';
import 'widgets/title_top_widget.dart';

class ArrestScreen extends StatefulWidget {
  final String title;
  const ArrestScreen({super.key, required this.title});

  @override
  State<ArrestScreen> createState() => _ArrestScreenState();
}

class _ArrestScreenState extends State<ArrestScreen> {
  final LocalStorage storage = LocalStorage();
  ScrollController? _scrollController;

  final FocusNode focusNode = FocusNode();

  bool showAppBar = true;

  int page = 1;
  int pageSize = 20;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  String tId = '';

  String search = '';
  String isOverWeight = '1';
  bool isLoadmore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController?.addListener(_scrollListener);

    initScreen();
  }

  void initScreen() async {
    var localTId = await storage.getValueString(KeyLocalStorage.weightUnitId);
    setState(() {
      tId = localTId.toString();
    });

    if (tId != '') {
      getWeightUnitDetail(tId);
      getWeightUnitCars(tId);
    }
  }

  void getWeightUnitDetail(String tid) {
    context
        .read<EstablishBloc>()
        .add(MobileMasterDepartmentFetchEvent(tid: tid));
  }

  void getWeightUnitCars(String tid) {
    var payload = EstablishWeightCarRes(
      tid: tid,
      page: page,
      pageSize: pageSize,
      search: search,
      isOverWeight: isOverWeight,
    );

    context.read<WeightUnitBloc>().add(GetWeightUnitCars(payload));
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_scrollListener);
    _scrollController?.dispose();

    focusNode.dispose();
    super.dispose();
  }

  void unfocusTextField() {
    if (focusNode.hasFocus) {
      focusNode.unfocus(); // ยกเลิกการโฟกัส TextField
    }
  }

  void _scrollListener() {
    if (_scrollController!.offset > 50 && showAppBar) {
      setState(() {
        showAppBar = false;
        print(_scrollController);
      });
    } else if (_scrollController!.offset <= 50 && !showAppBar) {
      setState(() {
        showAppBar = true;
        print(_scrollController);
      });
    }

    if (_scrollController!.position.pixels ==
        _scrollController!.position.maxScrollExtent) {
      loadMore();
    }
  }

  void loadMore() async {
    setState(() {
      page = page + 1;
      isLoadmore = true;
      getWeightUnitCars(tId);
    });
  }

  Future<void> refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      page = 1;
    });
    getWeightUnitCars(tId);
  }

  void goToArrestLogDetail(MobileCarModel item) {
    Routes.gotoArrestFormScreen(context: context, item: item);
  }

  void onChangedText(String value) {
    setState(() {
      search = value;
      page = 1;
    });
    getWeightUnitCars(tId);
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<TokenRefreshService>(context, listen: false)
        .startTokenRefreshTimer();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: tId != ''
            ? BlocBuilder<EstablishBloc, EstablishState>(
                builder: (context, state) {
                  if (state.establishMobileMasterDepartmentStatus ==
                      EstablishMobileMasterDepartmentStatus.loading) {
                    return const Center(child: CustomLoadingPagination());
                  }
                  if (state.establishMobileMasterDepartmentStatus ==
                      EstablishMobileMasterDepartmentStatus.success) {
                    if (state.mobileMasterDepartmentData != null) {
                      return LayoutBuilder(builder: (context, constraints) {
                        return CustomScrollView(
                          controller: _scrollController,
                          slivers: <Widget>[
                            SliverAppBar(
                              expandedHeight: constraints.maxWidth > 400 &&
                                      constraints.maxWidth < 600
                                  ? 200.h
                                  : 200.h,
                              toolbarHeight:
                                  constraints.maxWidth > 600 ? 30.h : 32.h,
                              pinned: true,
                              flexibleSpace: FlexibleSpaceBar(
                                collapseMode: CollapseMode.parallax,
                                background: TitleTopWidget(
                                  constraints: constraints,
                                  item: state.mobileMasterDepartmentData!,
                                  topWidget: 10,
                                ),
                              ),
                            ),
                            SliverList(
                              delegate: SliverChildListDelegate(
                                [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 18.h, vertical: 10.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('รายการการจับกุม',
                                            style: AppTextStyle.title16bold()),
                                        BlocBuilder<WeightUnitBloc,
                                            WeightUnitState>(
                                          builder: (context, state) {
                                            if (state.weightUnitCarsStatus ==
                                                WeightUnitCarsStatus.success) {
                                              return Text(
                                                  '${state.weightUnitCarsTotal} รายการ',
                                                  style:
                                                      AppTextStyle.title16bold(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .onTertiary));
                                            }
                                            return SizedBox.shrink();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 12.h),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.h, vertical: 4.h),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onTertiaryContainer,
                                      borderRadius: BorderRadius.circular(30.r),
                                    ),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svg/ri_search-line.svg',
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: TextField(
                                            focusNode: focusNode,
                                            onChanged: onChangedText,
                                            style: AppTextStyle.title18normal(),
                                            decoration: InputDecoration(
                                              isDense: true,
                                              hintText: 'ค้นหาทะเบียนรถบรรทุก',
                                              hintStyle:
                                                  AppTextStyle.title16normal(
                                                      color:
                                                          ColorApps.colorGray),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            BlocBuilder<WeightUnitBloc, WeightUnitState>(
                              builder: (context, state) {
                                if (state.weightUnitCarsStatus ==
                                    WeightUnitCarsStatus.loading) {
                                  return SliverFillRemaining(
                                    child: Center(
                                      child: SkeletionContainerWidget(
                                        height: 80.h,
                                        width: 300.w,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                      ),
                                    ),
                                  );
                                }

                                if (state.weightUnitCarsStatus ==
                                    WeightUnitCarsStatus.success) {
                                  isLoadmore = false;
                                  if (state.weightUnitsCars != null &&
                                      state.weightUnitsCars!.isEmpty) {
                                    return SliverFillRemaining(
                                      child: EmptyWidget(
                                        title: 'ไม่พบรายการการจับกุม',
                                        label: 'กรุณาเพิ่มรายการรถเข้าชั่ง',
                                      ),
                                    );
                                  }

                                  return SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                      (BuildContext context, int index) {
                                        final carItem =
                                            state.weightUnitsCars![index];
                                        return GestureDetector(
                                          onTap: () {
                                            goToArrestLogDetail(carItem);
                                            FocusScope.of(context).unfocus();
                                          },
                                          child: CarItemWidget(
                                            item: carItem,
                                            isShowArrest: true,
                                          ),
                                        );
                                      },
                                      childCount:
                                          state.weightUnitsCars?.length ?? 0,
                                    ),
                                  );
                                }

                                return SliverFillRemaining(
                                  child: const SizedBox.shrink(),
                                );
                              },
                            ),
                            if (isLoadmore)
                              SliverList(
                                delegate: SliverChildListDelegate(
                                  [
                                    const Center(
                                        child: CustomLoadingPagination()),
                                  ],
                                ),
                              ),
                            SliverList(
                              delegate: SliverChildListDelegate(
                                [
                                  SizedBox(height: 100.h),
                                ],
                              ),
                            )
                          ],
                        );
                      });
                    } else {
                      return const Center(
                        child: EmptyWidget(
                            title: 'ไม่พบรายการรถเข้าชั่ง',
                            label: 'กรุณาเพิ่มรายการรถเข้าชั่ง'),
                      );
                    }
                  }
                  return SizedBox.shrink();
                },
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EmptyWidget(
                      title: 'ไม่พบรายการรถเข้าชั่ง',
                      label: 'กรุณาเพิ่มรายการรถเข้าชั่ง'),
                ],
              ),
      ),
    );
  }

  void showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width,
      ),
      builder: (BuildContext context) {
        return CustomBottomSheetWidget(
          icon: 'exclamation_icon_shadow',
          title: 'สิ้นสุดการจัดตั้งหน่วย',
          message: 'ท่านต้องการสิ้นสุดการจัดตั้งหน่วยหรือไม่ ?',
          onConfirm: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SuccessScreen(
                  icon: 'assets/svg/ant-design_check-circle-filled.svg',
                  titleBT: 'กลับหน้าแรก',
                  title: 'สิ้นสุดการจัดหน่วยสำเร็จ',
                  message: 'สามารถเริ่มการจัดตั้งหน่วยใหม่ได้',
                  onConfirm: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                ),
              ),
            );
          },
          onCancel: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
