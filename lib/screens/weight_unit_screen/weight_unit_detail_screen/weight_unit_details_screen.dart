import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:wts_bloc/utils/constants/color_app.dart';

import '../../../app/routes/routes.dart';
import '../../../blocs/establish/establish_bloc.dart';
import '../../../blocs/profile/profile_bloc.dart';
import '../../../blocs/weight_unit/weight_unit_bloc.dart';
import '../../../data/models/establish/establish_weight_car_req.dart';
import '../../../data/models/establish/mobile_car_model.dart';
import '../../../local_storage.dart';
import '../../../service/token_refresh.service.dart';
import '../../../utils/constants/key_localstorage.dart';
import '../../../utils/constants/text_style.dart';
import '../../../utils/libs/convert_date.dart';
import '../../../utils/libs/role_permission.dart';
import '../../../utils/widgets/custom_loading_pagination.dart';
import '../../../utils/widgets/skeletion_widgets/skeletion_container_widget.dart';
import '../../../utils/widgets/sneckbar_message.dart';
import '../../arrest/widgets/title_top_widget.dart';
import '../../establish/establish_unit/widgets/custom_bottom_sheet_widget.dart';
import '../../widgets/empty_widget.dart';
import '../../widgets/success_screen.dart';
import 'widgets/car_item_widget.dart';

class WeightUnitDetailsScreen extends StatefulWidget {
  const WeightUnitDetailsScreen({
    super.key,
    required this.tid,
  });

  final String? tid;

  @override
  State<WeightUnitDetailsScreen> createState() => _EstablishUnitDetailsState();
}

class _EstablishUnitDetailsState extends State<WeightUnitDetailsScreen>
    with SingleTickerProviderStateMixin {
  Color appBarBackgroundColor = Colors.blue;

  final FocusNode focusNode = FocusNode();

  late TabController _tabController;

  List<MobileCarModel> mobile_car = [];

  int page = 1;
  int pageSize = 20;
  String isOverWeight = '';
  String search = '';

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  final ScrollController scrollController = ScrollController();

  bool showAppBar = true;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });

    initScreen();
  }

  void initScreen() async {
    if (widget.tid != null) {
      getWeightUnitDetail();
      getWeightUnitCars();
    }
  }

  void getWeightUnitDetail() {
    context
        .read<EstablishBloc>()
        .add(MobileMasterDepartmentFetchEvent(tid: widget.tid!));
  }

  void _handleTabSelection() async {
    if (_tabController.index != _tabController.previousIndex) {
      setState(() {
        page = 1;
        isOverWeight = _tabController.index == 0 ? '' : '1';
      });

      getWeightUnitCars();
    }
  }

  void getWeightUnitCars() {
    var payload = EstablishWeightCarRes(
      tid: widget.tid!,
      page: page,
      pageSize: pageSize,
      search: search,
      isOverWeight: isOverWeight,
    );

    context.read<WeightUnitBloc>().add(GetWeightUnitCars(payload));
  }

  @override
  void dispose() {
    _tabController.dispose();
    scrollController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void unfocusTextField() {
    if (focusNode.hasFocus) {
      focusNode.unfocus();
    }
  }

  void loadMore() async {
    setState(() {
      page = page + 1;
      getWeightUnitCars();
    });
  }

  Future<void> refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      page = 1;
    });
    getWeightUnitCars();
  }

  void closeWeightUnit() async {
    context
        .read<EstablishBloc>()
        .add(PostWeightUnitCloseEvent(widget.tid.toString()));
  }

  void afterCloseUnit() async {
    await ClearUnitID();
    await GetWeightUnitsIsJoinEventBloc();
    await getWeightUnitAll();
    if (mounted) {
      Navigator.popUntil(context, (route) => route.isFirst);
    }
  }

  Future<void> ClearUnitID() async {
    final LocalStorage storage = LocalStorage();
    await storage.setValueString(KeyLocalStorage.weightUnitId, '');
  }

  Future<void> GetWeightUnitsIsJoinEventBloc() async {
    ClearUnitID();
    context.read<EstablishBloc>().add(
          GetWeightUnitsIsJoinEvent(
            start_date: ConvertDate.convertDateToYYYYDDMM(
                ConvertDate.dateTimeYearSubstract(startDate, 1)),
            end_date: ConvertDate.convertDateToYYYYDDMM(
                ConvertDate.dateTimeYearAdd(endDate, 1)),
            page: page,
            pageSize: pageSize,
          ),
        );
  }

  Future<void> getWeightUnitAll() async {
    context.read<EstablishBloc>().add(
          MobileMasterFetchEvent(
            start_date: ConvertDate.convertDateToYYYYDDMM(
                ConvertDate.dateTimeYearSubstract(startDate, 1)),
            end_date: ConvertDate.convertDateToYYYYDDMM(
                ConvertDate.dateTimeYearAdd(endDate, 1)),
            page: page,
            pageSize: pageSize,
          ),
        );
  }

  void onChangedText(String value) {
    setState(() {
      search = value;
      page = 1;
    });
    getWeightUnitCars();
  }

  @override
  Widget build(BuildContext context) {
    var role = context.read<ProfileBloc>().state.profile!.deptType;
    Provider.of<TokenRefreshService>(context, listen: false)
        .startTokenRefreshTimer();
    return Scaffold(
      body: GestureDetector(
        onTap: unfocusTextField,
        behavior: HitTestBehavior.opaque,
        child: MultiBlocListener(
          listeners: [
            BlocListener<EstablishBloc, EstablishState>(
              listenWhen: (previous, current) =>
                  previous.establishMobileMasterDepartmentStatus !=
                  current.establishMobileMasterDepartmentStatus,
              listener: (context, state) {
                if (state.establishMobileMasterDepartmentStatus ==
                        EstablishMobileMasterDepartmentStatus.error &&
                    state.establishMobileMasterDepartmentError != null &&
                    state.establishMobileMasterDepartmentError!.isNotEmpty) {
                  showSnackbarBottom(
                      context, state.establishMobileMasterDepartmentError!);
                }
              },
            ),
            BlocListener<WeightUnitBloc, WeightUnitState>(
              listenWhen: (previous, current) =>
                  previous.weightUnitCarsStatus != current.weightUnitCarsStatus,
              listener: (context, state) {
                if (state.weightUnitCarsStatus == WeightUnitCarsStatus.error &&
                    state.weightUnitsError != null &&
                    state.weightUnitsError!.isNotEmpty) {
                  showSnackbarBottom(context, state.weightUnitsError!);
                }
              },
            ),
          ],
          child: BlocBuilder<EstablishBloc, EstablishState>(
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
                      controller: scrollController,
                      slivers: <Widget>[
                        SliverAppBar(
                          leading: IconButton(
                            onPressed: () {
                              Navigator.popUntil(
                                  context, (route) => route.isFirst);
                            },
                            icon: Icon(Icons.arrow_back),
                          ),
                          actions: [
                            if (RolePermission.checkRole1(role))
                              GestureDetector(
                                onTap: () {
                                  showCustomBottomSheet(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    borderRadius: BorderRadius.circular(32.r),
                                  ),
                                  margin: const EdgeInsets.only(right: 16.0),
                                  padding: EdgeInsets.only(
                                      left: 12, right: 12, top: 5, bottom: 4),
                                  child: Text('สิ้นสุดการจัดตั้งหน่วย',
                                      style: AppTextStyle.title14bold(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary)),
                                ),
                              ),
                          ],
                          backgroundColor: ColorApps.colorMain,
                          expandedHeight: constraints.maxWidth > 400 &&
                                  constraints.maxWidth < 600
                              ? 200.h
                              : 290.h,
                          toolbarHeight:
                              constraints.maxWidth > 600 ? 70.h : 52.h,
                          pinned: true,
                          flexibleSpace: FlexibleSpaceBar(
                            collapseMode: CollapseMode.parallax,
                            background: TitleTopWidget(
                              constraints: constraints,
                              item: state.mobileMasterDepartmentData!,
                            ),
                          ),
                          bottom: TabBar(
                            tabAlignment: TabAlignment.center,
                            dividerColor:
                                Theme.of(context).colorScheme.tertiaryContainer,
                            isScrollable: true,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorColor:
                                Theme.of(context).colorScheme.surface,
                            labelColor: Theme.of(context).colorScheme.surface,
                            unselectedLabelColor:
                                Theme.of(context).colorScheme.onSurface,
                            indicatorWeight: 3,
                            labelStyle: AppTextStyle.title16bold(),
                            controller: _tabController,
                            tabs: [
                              tabCarWeight(
                                  context,
                                  'assets/svg/iconamoon_news-fill.svg',
                                  'รถเข้าชั่ง (${state.mobileMasterDepartmentData!.total.toString()})',
                                  'รถเข้าชั่ง ()'),
                              tabCarWeight(
                                  context,
                                  'assets/svg/truck_icon.svg',
                                  'รถน้ำหนักเกิน (${state.mobileMasterDepartmentData!.totalOver.toString()})',
                                  'รถน้ำหนักเกิน ()'),
                            ],
                          ),
                        ),
                        BlocBuilder<WeightUnitBloc, WeightUnitState>(
                          builder: (context, state) {
                            return SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  if (state.weightUnitCarsStatus ==
                                      WeightUnitCarsStatus.loading) {
                                    return Center(
                                      child: SkeletionContainerWidget(
                                        height: 80.h,
                                        width: 300.w,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                      ),
                                    );
                                  }

                                  if (state.weightUnitCarsStatus ==
                                      WeightUnitCarsStatus.success) {
                                    if (state.weightUnitsCars != null &&
                                        state.weightUnitsCars!.isNotEmpty) {
                                      final carItem =
                                          state.weightUnitsCars![index];
                                      return GestureDetector(
                                        onTap: () {
                                          Routes.gotoUnitDetailsWeighingTrucks(
                                              context,
                                              widget.tid.toString(),
                                              carItem.tdId!,
                                              true);
                                        },
                                        child: CarItemWidget(item: carItem),
                                      );
                                    } else {
                                      return EmptyWidget(
                                          title: 'ไม่พบรายการรถเข้าชั่ง',
                                          label: 'กรุณาเพิ่มรายการรถเข้าชั่ง');
                                    }
                                  }

                                  if (state.weightUnitCarsStatus ==
                                      WeightUnitCarsStatus.error) {
                                    return Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 24.h, vertical: 24.h),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.error_outline,
                                              size: 64,
                                              color: Colors.red[300],
                                            ),
                                            SizedBox(height: 16),
                                            Text(
                                              'เกิดข้อผิดพลาด',
                                              style: AppTextStyle.title16bold(),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              state.weightUnitsError ??
                                                  'Unknown error',
                                              style: AppTextStyle.title14normal(
                                                color: Colors.grey[600],
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(height: 24),
                                            ElevatedButton.icon(
                                              onPressed: () {
                                                setState(() {
                                                  page = 1;
                                                });
                                                getWeightUnitCars();
                                              },
                                              icon: Icon(Icons.refresh),
                                              label: Text('ลองอีกครั้ง'),
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 24,
                                                  vertical: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }

                                  return SizedBox.shrink();
                                },
                                childCount: state.weightUnitsCars != null &&
                                        state.weightUnitsCars!.isNotEmpty
                                    ? state.weightUnitsCars!.length
                                    : 1,
                              ),
                            );
                          },
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return BlocBuilder<WeightUnitBloc,
                                  WeightUnitState>(
                                builder: (context, state) {
                                  if (state.weightUnitsCarsLoadMore == true) {
                                    return const Center(
                                        child: CustomLoadingPagination());
                                  }
                                  return const SizedBox.shrink();
                                },
                              );
                            },
                            childCount: 1,
                          ),
                        ),
                      ],
                    );
                  });
                }
              }

              if (state.establishMobileMasterDepartmentStatus ==
                  EstablishMobileMasterDepartmentStatus.error) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.red[300],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'เกิดข้อผิดพลาด',
                          style: AppTextStyle.title16bold(),
                        ),
                        SizedBox(height: 8),
                        Text(
                          state.establishMobileMasterDepartmentError ??
                              'Unknown error',
                          style: AppTextStyle.title14normal(
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: () {
                            getWeightUnitDetail();
                            getWeightUnitCars();
                          },
                          icon: Icon(Icons.refresh),
                          label: Text('ลองอีกครั้ง'),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return SizedBox.shrink();
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(90.0),
        ),
        onPressed: () {
          Routes.gotoUnitDetailsWeighingTrucks(
              context, widget.tid.toString(), '', true);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Tab tabCarWeight(BuildContext context, String svgIcon, carAmount, mockText) {
    return Tab(
      child: Row(
        children: [
          SvgPicture.asset(
            svgIcon,
            color: _tabController.index == 0
                ? Theme.of(context).colorScheme.surface
                : Theme.of(context).colorScheme.onSurface,
            width: 20.h,
          ),
          SizedBox(width: 5.h),
          BlocBuilder<EstablishBloc, EstablishState>(
            builder: (context, state) {
              if (state.establishMobileMasterDepartmentStatus ==
                  EstablishMobileMasterDepartmentStatus.success) {
                return Text(
                  carAmount,
                  style: TextStyle(
                    color: _tabController.index == 0
                        ? Theme.of(context).colorScheme.surface
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                );
              }
              return Text(
                mockText,
                style: TextStyle(
                  color: _tabController.index == 0
                      ? Theme.of(context).colorScheme.surface
                      : Theme.of(context).colorScheme.onSurface,
                ),
              );
            },
          ),
        ],
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
        return BlocListener<EstablishBloc, EstablishState>(
          listenWhen: (previous, current) =>
              previous.weightUnistCloseStatus != current.weightUnistCloseStatus,
          listener: (context, state) {
            if (state.weightUnistCloseStatus ==
                WeightUnistCloseStatus.success) {
              context.read<EstablishBloc>().add(ClearPostJoinWeightUnit());
              afterCloseUnit();
            }
          },
          child: CustomBottomSheetWidget(
            icon: 'exclamation_icon_shadow',
            title: 'สิ้นสุดการจัดตั้งหน่วย',
            message: 'ท่านต้องการสิ้นสุดการจัดตั้งหน่วยหรือไม่ ?',
            onConfirm: () {
              Navigator.pop(context);
              closeWeightUnit();

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
          ),
        );
      },
    );
  }
}
