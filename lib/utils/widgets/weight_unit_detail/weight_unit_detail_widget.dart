import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wts_bloc/utils/constants/color_app.dart';

import '../../../app/routes/routes.dart';
import '../../../blocs/weight_unit/weight_unit_bloc.dart';
import '../../../data/models/establish/establish_weight_car_req.dart';
import '../../../data/models/establish/mobile_car_model.dart';
import '../../../screens/establish/establish_unit/widgets/custom_bottom_sheet_widget.dart';
import '../../../screens/weight_unit_screen/weight_unit_detail_screen/widgets/car_item_widget.dart';
import '../../../screens/widgets/custom_confirmation_screen.dart';
import '../../../screens/widgets/empty_widget.dart';
import '../../../screens/widgets/success_screen.dart';
import '../../constants/text_style.dart';
import '../badges/badge_widget.dart';
import '../custom_loading_pagination.dart';
import '../sneckbar_message.dart';
import 'widgets/title_weight_unit_widget.dart';

class WeightUnitDetailWidget extends StatefulWidget {
  const WeightUnitDetailWidget({
    super.key,
    required this.tid,
  });

  final String? tid;

  @override
  State<WeightUnitDetailWidget> createState() => _WeightUnitDetailWidgetState();
}

class _WeightUnitDetailWidgetState extends State<WeightUnitDetailWidget>
    with SingleTickerProviderStateMixin {
  ScrollController? _scrollController;
  late TabController _tabController;

  List<MobileCarModel> mobile_car = [];

  int page = 1;
  int pageSize = 20;
  String isOverWeight = '';
  String search = '';

  late ScrollController scrollList;

  bool showAppBar = true;
  bool hasMoreData = true;
  bool isLoadingMore = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController?.addListener(_scrollListener);

    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);

    scrollList = ScrollController();

    scrollList.addListener(() {
      if (scrollList.position.pixels >=
          scrollList.position.maxScrollExtent - 200) {
        if (hasMoreData && !isLoadingMore) {
          loadMore();
        }
      }
    });

    initScreen();
  }

  void initScreen() async {
    getDetailWeightUnit();
    getMobileCarList();
  }

  void getDetailWeightUnit() {
    context
        .read<WeightUnitBloc>()
        .add(GetWeightUnitDetail(widget.tid.toString()));
  }

  void getMobileCarList() {
    var payload = EstablishWeightCarRes(
      tid: widget.tid.toString(),
      page: page,
      pageSize: pageSize,
      search: search,
      isOverWeight: isOverWeight,
    );
    context.read<WeightUnitBloc>().add(GetWeightUnitCars(payload));
  }

  void _handleTabSelection() async {
    if (_tabController.index != _tabController.previousIndex) {
      setState(() {
        isOverWeight = _tabController.index.toString();
        page = 1;
        hasMoreData = true;
        isLoadingMore = false;
      });
      getMobileCarList();
    }
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_scrollListener);
    _scrollController?.dispose();
    _tabController.dispose();
    scrollList.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController!.offset > 50 && showAppBar) {
      setState(() {
        showAppBar = false;
      });
    } else if (_scrollController!.offset <= 50 && !showAppBar) {
      setState(() {
        showAppBar = true;
      });
    }
  }

  void loadMore() async {
    setState(() {
      page = page + 1;
      isLoadingMore = true;
    });
    getMobileCarList();
  }

  Future<void> refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      page = 1;
      hasMoreData = true;
      isLoadingMore = false;
    });
    getMobileCarList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              leading: showAppBar
                  ? SizedBox.shrink()
                  : IconButton(
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      onPressed: () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                    ),
              title: showAppBar
                  ? SizedBox.shrink()
                  : BlocBuilder<WeightUnitBloc, WeightUnitState>(
                      builder: (context, state) {
                        if (state.weightUnitDetailStatus ==
                                WeightUnitDetailStatus.success &&
                            state.weightUnitDetail != null) {
                          return Container(
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              state.weightUnitDetail?.wayId ?? '',
                              style: AppTextStyle.title16bold(
                                  color: Theme.of(context).colorScheme.surface),
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
              actions: [
                GestureDetector(
                  onTap: () {
                    _showCustomBottomSheet(context);
                  },
                  child: BadgeWidget(
                    text: 'สิ้นสุดการจัดตั้งหน่วย',
                  ),
                ),
              ],
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
              expandedHeight:
                  constraints.maxWidth > 400 && constraints.maxWidth < 600
                      ? 200.h
                      : 260.h,
              toolbarHeight: constraints.maxWidth > 600 ? 70.h : 52.h,
              floating: false,
              pinned: true,
              bottom: TabBar(
                tabAlignment: TabAlignment.center,
                dividerColor: Theme.of(context).colorScheme.tertiaryContainer,
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: Theme.of(context).colorScheme.surface,
                labelColor: Theme.of(context).colorScheme.surface,
                unselectedLabelColor: Theme.of(context).colorScheme.onSurface,
                indicatorWeight: 3,
                labelStyle: AppTextStyle.title16bold(),
                controller: _tabController,
                onTap: (value) {
                  setState(() {});
                },
                tabs: [
                  Tab(
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svg/iconamoon_news-fill.svg',
                          color: _tabController.index == 0
                              ? Theme.of(context).colorScheme.surface
                              : Theme.of(context).colorScheme.onSurface,
                          width: 20.h,
                        ),
                        SizedBox(width: 5.h),
                        BlocBuilder<WeightUnitBloc, WeightUnitState>(
                          builder: (context, state) {
                            final count = state.weightUnitsCars?.length ?? 0;
                            return Text(
                              'รถเข้าชั่ง ($count)',
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
                  ),
                  Tab(
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svg/truck_icon.svg',
                          color: _tabController.index == 1
                              ? Theme.of(context).colorScheme.surface
                              : Theme.of(context).colorScheme.onSurface,
                          width: 22.h,
                        ),
                        SizedBox(width: 5.h),
                        Text(
                          'รถน้ำหนักเกิน (0)',
                          style: TextStyle(
                            color: _tabController.index == 1
                                ? Theme.of(context).colorScheme.surface
                                : Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              flexibleSpace: showAppBar
                  ? BlocBuilder<WeightUnitBloc, WeightUnitState>(
                      builder: (context, state) {
                        if (state.weightUnitDetailStatus ==
                                WeightUnitDetailStatus.success &&
                            state.weightUnitDetail != null) {
                          return TitleWeightUnitWidget(
                            item: state.weightUnitDetail!,
                            constraints: constraints,
                          );
                        }
                        return SizedBox.shrink();
                      },
                    )
                  : Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF314188), Color(0xFF1F2E6F)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // First Tab Content
                  FirstTabContent(),
                  // Second Tab Content
                  SecondTabContent(),
                ],
              ),
            ),
          ],
        );
      }),
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

  Container SecondTabContent() {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 4.h),
            margin: EdgeInsets.all(8.h),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onTertiaryContainer,
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
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'ค้นหา...',
                      hintStyle: AppTextStyle.title16normal(
                          color: ColorApps.colorGray),
                      border: InputBorder.none,
                    ),
                    style: AppTextStyle.title16normal(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: EmptyWidget(
              title: 'ไม่พบรายการรถเข้าชั่ง',
              label: 'กรุณาเพิ่มรายการรถเข้าชั่ง',
            ),
          ),
        ],
      ),
    );
  }

  Widget FirstTabContent() {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          BlocListener<WeightUnitBloc, WeightUnitState>(
            listenWhen: (previous, current) {
              // Listen เมื่อ status เปลี่ยน
              return previous.weightUnitCarsStatus !=
                  current.weightUnitCarsStatus;
            },
            listener: (context, state) {
              // อัปเดต loading flag
              if (mounted) {
                setState(() {
                  isLoadingMore = false;
                });
              }

              // เช็คว่ามีข้อมูลเพิ่มหรือไม่
              if (state.weightUnitCarsStatus == WeightUnitCarsStatus.success) {
                if (mounted) {
                  setState(() {
                    if (state.weightUnitsCars == null ||
                        state.weightUnitsCars!.length < pageSize) {
                      hasMoreData = false;
                    }
                  });
                }
              }

              // แสดง Snackbar เมื่อเกิด error
              if (state.weightUnitCarsStatus == WeightUnitCarsStatus.error &&
                  state.weightUnitsError != null &&
                  state.weightUnitsError!.isNotEmpty) {
                showSnackbarBottom(context, state.weightUnitsError!);
              }
            },
            child: const SizedBox.shrink(),
          ),

          // Search bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 4.h),
            margin: EdgeInsets.all(8.h),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onTertiaryContainer,
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
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'ค้นหา..',
                      border: InputBorder.none,
                      hintStyle: AppTextStyle.title16normal(
                          color: ColorApps.colorGray),
                    ),
                    style: AppTextStyle.title16normal(),
                    onChanged: (value) {
                      if (_debounce?.isActive ?? false) _debounce!.cancel();

                      _debounce = Timer(const Duration(milliseconds: 500), () {
                        setState(() {
                          search = value;
                          page = 1;
                          hasMoreData = true;
                        });
                        getMobileCarList();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          // List content
          Expanded(
            child: BlocBuilder<WeightUnitBloc, WeightUnitState>(
              builder: (context, state) {
                // Loading state
                if (state.weightUnitCarsStatus ==
                    WeightUnitCarsStatus.loading) {
                  return const Center(child: CustomLoadingPagination());
                }

                // Success state
                if (state.weightUnitCarsStatus ==
                    WeightUnitCarsStatus.success) {
                  if (state.weightUnitsCars != null &&
                      state.weightUnitsCars!.isNotEmpty) {
                    return RefreshIndicator(
                      onRefresh: refreshData,
                      child: ListView.separated(
                        controller: scrollList,
                        padding: EdgeInsets.zero,
                        separatorBuilder: (context, index) => Divider(
                          color:
                              Theme.of(context).colorScheme.tertiaryContainer,
                          height: 1,
                          indent: 20,
                          endIndent: 20,
                        ),
                        itemCount: state.weightUnitsCars!.length,
                        itemBuilder: (context, index) {
                          final carItem = state.weightUnitsCars![index];
                          return GestureDetector(
                            onTap: () {
                              Routes.gotoHistoryDetailsView(
                                context,
                                carItem.tId!.toString(),
                                carItem.tdId!,
                              );
                            },
                            child: CarItemWidget(
                              item: carItem,
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    // Empty state
                    return EmptyWidget(
                      title: 'ไม่พบรายการรถเข้าชั่ง',
                      label: 'กรุณาเพิ่มรายการรถเข้าชั่ง',
                    );
                  }
                }

                if (state.weightUnitCarsStatus == WeightUnitCarsStatus.error) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(24.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64.h,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'เกิดข้อผิดพลาด',
                            style: AppTextStyle.title18bold(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            state.weightUnitsError ?? 'ไม่สามารถโหลดข้อมูลได้',
                            style: AppTextStyle.title14normal(
                              color: ColorApps.colorGray,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 24.h),
                          ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                page = 1;
                                hasMoreData = true;
                                isLoadingMore = false;
                              });
                              getMobileCarList();
                            },
                            icon: Icon(Icons.refresh),
                            label: Text('ลองอีกครั้ง'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              foregroundColor:
                                  Theme.of(context).colorScheme.surface,
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

                return const SizedBox.shrink();
              },
            ),
          ),

          BlocBuilder<WeightUnitBloc, WeightUnitState>(
            builder: (context, state) {
              // แสดง loading เมื่อกำลัง load more
              if (state.weightUnitsCarsLoadMore == true && isLoadingMore) {
                return Padding(
                  padding: EdgeInsets.all(16.h),
                  child: Column(
                    children: [
                      const CustomLoadingPagination(),
                      SizedBox(height: 8.h),
                      Text(
                        'กำลังโหลดข้อมูลเพิ่มเติม...',
                        style: AppTextStyle.title14normal(
                          color: ColorApps.colorGray,
                        ),
                      ),
                    ],
                  ),
                );
              }

              // แสดงข้อความเมื่อไม่มีข้อมูลเพิ่ม
              if (!hasMoreData &&
                  state.weightUnitsCars != null &&
                  state.weightUnitsCars!.isNotEmpty) {
                return Padding(
                  padding: EdgeInsets.all(16.h),
                  child: Text(
                    'แสดงข้อมูลครบแล้ว',
                    style: AppTextStyle.title14normal(
                      color: ColorApps.colorGray,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  void _showCustomBottomSheet(BuildContext context) {
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

  void showConfirmationDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width,
      ),
      builder: (BuildContext context) {
        return CustomConfirmationScreen(
          icon: 'assets/svg/check_icon_shadow.svg',
          titleBT: 'กลับหน้าแรก',
          title: 'สิ้นสุดการจัดหน่วยสำเร็จ',
          message: 'สามารถเริ่มการจัดตั้งหน่วยใหม่ได้',
          onConfirm: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        );
      },
    );
  }
}
