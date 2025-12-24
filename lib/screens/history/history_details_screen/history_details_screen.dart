import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:wts_bloc/screens/widgets/empty_widget.dart';

import '../../../app/routes/routes.dart';
import '../../../app/routes/routes_constant.dart';
import '../../../blocs/profile/profile_bloc.dart';
import '../../../blocs/weight_unit/weight_unit_bloc.dart';
import '../../../data/models/establish/establish_weight_car_req.dart';
import '../../../data/models/establish/mobile_master_model.dart';
import '../../../local_storage.dart';
import '../../../service/token_refresh.service.dart';
import '../../../utils/constants/color_app.dart';
import '../../../utils/constants/key_localstorage.dart';
import '../../../utils/constants/text_style.dart';
import '../../../utils/libs/string_helper.dart';
import '../../../utils/widgets/custom_loading_pagination.dart';
import '../../../utils/widgets/sneckbar_message.dart';
import '../../weight_unit_screen/weight_unit_detail_screen/widgets/car_item_widget.dart';

class HistoryDetailsScreen extends StatefulWidget {
  const HistoryDetailsScreen({
    super.key,
    required this.item,
  });

  final MobileMasterModel item;

  @override
  State<HistoryDetailsScreen> createState() => _HistoryDetailsScreenState();
}

class _HistoryDetailsScreenState extends State<HistoryDetailsScreen>
    with SingleTickerProviderStateMixin {
  ScrollController? _scrollController;
  late TabController _tabController;
  final FocusNode focusNode = FocusNode();
  bool showAppBar = true;

  final LocalStorage storage = LocalStorage();

  String? accessToken;

  int page = 1;
  int pageSize = 20;
  String isOverWeight = '';
  String search = '';

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController?.addListener(_scrollListener);

    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);

    initScreen();
  }

  void initScreen() async {
    String? token = await storage.getValueString(KeyLocalStorage.accessToken);
    if (context.read<ProfileBloc>().state.profile != null && token != null) {
      setState(() {
        accessToken = token;
      });
    } else {
      setState(() {
        accessToken = null;
      });
    }

    getDetailWeightUnit();
    getMobileCarList();
  }

  void getDetailWeightUnit() {
    context
        .read<WeightUnitBloc>()
        .add(GetWeightUnitDetail(widget.item.tID.toString()));
  }

  void getMobileCarList() {
    var payload = EstablishWeightCarRes(
      tid: widget.item.tID.toString(),
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
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() async {
    if (_tabController.index != _tabController.previousIndex) {
      setState(() {
        isOverWeight = _tabController.index.toString();
      });
      getMobileCarList();
    }
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

  void onChangedText(String value) {
    setState(() {
      search = value;
      page = 1;
    });
    getMobileCarList();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<TokenRefreshService>(context, listen: false)
        .startTokenRefreshTimer();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
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
                  : Container(
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: BlocBuilder<WeightUnitBloc, WeightUnitState>(
                        builder: (context, state) {
                          if (state.weightUnitDetailStatus ==
                                  WeightUnitDetailStatus.success &&
                              state.weightUnitDetail != null) {
                            return Text(
                              StringHleper.checkString(
                                  state.weightUnitDetail!.wayId),
                              style: AppTextStyle.title16bold(
                                  color: Theme.of(context).colorScheme.surface),
                            );
                          }
                          return SizedBox.shrink();
                        },
                      ),
                    ),
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
              expandedHeight:
                  constraints.maxWidth > 400 && constraints.maxWidth < 600
                      ? 200.h
                      : 250.h,
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
                        Text(
                          'รถเข้าชั่ง (${widget.item.total})',
                          style: TextStyle(
                            color: _tabController.index == 0
                                ? Theme.of(context).colorScheme.surface
                                : Theme.of(context).colorScheme.onSurface,
                          ),
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
                          'รถน้ำหนักเกิน (${widget.item.totalOver})',
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
                  ? Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF314188), Color(0xFF1F2E6F)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: SafeArea(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.arrow_back_rounded,
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                  ),
                                  onPressed: () {
                                    Navigator.popUntil(
                                        context, (route) => route.isFirst);
                                  },
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.h),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BlocBuilder<WeightUnitBloc, WeightUnitState>(
                                    builder: (context, state) {
                                      if (state.weightUnitDetailStatus ==
                                              WeightUnitDetailStatus.success &&
                                          state.weightUnitDetail != null) {
                                        return Text(
                                          StringHleper.checkString(
                                              state.weightUnitDetail!.wayId),
                                          style: AppTextStyle.title20bold(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surface,
                                          ),
                                        );
                                      }
                                      return SizedBox.shrink();
                                    },
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'จัดตั้งโดย:',
                                        style: AppTextStyle.title16bold(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surface),
                                      ),
                                      SizedBox(width: 6),
                                      BlocBuilder<WeightUnitBloc,
                                          WeightUnitState>(
                                        builder: (context, state) {
                                          if (state.weightUnitDetailStatus ==
                                                  WeightUnitDetailStatus
                                                      .success &&
                                              state.weightUnitDetail != null) {
                                            return Text(
                                              '${StringHleper.checkString(state.weightUnitDetail!.firstName)} ${StringHleper.checkString(state.weightUnitDetail!.lastName)}',
                                              style: AppTextStyle.title16normal(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .surface,
                                              ),
                                            );
                                          }
                                          return SizedBox.shrink();
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'กม.ที่:',
                                        style: AppTextStyle.title16normal(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surface),
                                      ),
                                      SizedBox(width: 6),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface
                                              .withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(32.r),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 1),
                                        child: Center(
                                          child: BlocBuilder<WeightUnitBloc,
                                              WeightUnitState>(
                                            builder: (context, state) {
                                              if (state.weightUnitDetailStatus ==
                                                      WeightUnitDetailStatus
                                                          .success &&
                                                  state.weightUnitDetail !=
                                                      null) {
                                                return Text(
                                                  StringHleper.checkString(state
                                                      .weightUnitDetail!
                                                      .kmFrom),
                                                  style: AppTextStyle
                                                      .title16normal(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .surface),
                                                );
                                              }
                                              return SizedBox.shrink();
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        'ถึง',
                                        style: AppTextStyle.title16normal(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surface),
                                      ),
                                      SizedBox(width: 6),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface
                                              .withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(32.r),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 1),
                                        child: Center(
                                          child: BlocBuilder<WeightUnitBloc,
                                              WeightUnitState>(
                                            builder: (context, state) {
                                              if (state.weightUnitDetailStatus ==
                                                      WeightUnitDetailStatus
                                                          .success &&
                                                  state.weightUnitDetail !=
                                                      null) {
                                                return Text(
                                                  StringHleper.checkString(state
                                                      .weightUnitDetail!.kmTo),
                                                  style: AppTextStyle
                                                      .title16normal(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .surface),
                                                );
                                              }
                                              return SizedBox.shrink();
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Divider(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .tertiaryContainer,
                                    height: 1,
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          'ผู้ร่วมบูรณาการ',
                                          style: AppTextStyle.title16bold(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .surface),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: BlocBuilder<WeightUnitBloc,
                                            WeightUnitState>(
                                          builder: (context, state) {
                                            if (state.weightUnitDetailStatus ==
                                                    WeightUnitDetailStatus
                                                        .success &&
                                                state.weightUnitDetail !=
                                                    null) {
                                              return Text(
                                                StringHleper.checkString(state
                                                    .weightUnitDetail!
                                                    .collaboration),
                                                style:
                                                    AppTextStyle.title16normal(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .surface),
                                              );
                                            }
                                            return SizedBox.shrink();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          'ที่อยู่',
                                          style: AppTextStyle.title16bold(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .surface),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: BlocBuilder<WeightUnitBloc,
                                            WeightUnitState>(
                                          builder: (context, state) {
                                            if (state.weightUnitDetailStatus ==
                                                    WeightUnitDetailStatus
                                                        .success &&
                                                state.weightUnitDetail !=
                                                    null) {
                                              return Text(
                                                '${StringHleper.checkString(state.weightUnitDetail!.subDistrict)}, ${StringHleper.checkString(state.weightUnitDetail!.district)}, ${StringHleper.checkString(state.weightUnitDetail!.province)}, ${StringHleper.checkString(state.weightUnitDetail!.province)}',
                                                style:
                                                    AppTextStyle.title16normal(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .surface),
                                              );
                                            }
                                            return SizedBox.shrink();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  constraints.maxWidth > 400 &&
                                          constraints.maxWidth < 600
                                      ? SizedBox(height: 30.h)
                                      : SizedBox(height: 40.h),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
                  FirstTabContent(),
                  SecondTabContent(),
                ],
              ),
            ),
          ],
        );
      }),
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
                SvgPicture.asset('assets/svg/ri_search-line.svg'),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    onChanged: onChangedText,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'ค้นหาทะเบียนรถบรรทุก',
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
            child: const SizedBox.shrink(),
          ),
          Expanded(
            child: BlocBuilder<WeightUnitBloc, WeightUnitState>(
              builder: (context, state) {
                if (state.weightUnitCarsStatus ==
                    WeightUnitCarsStatus.loading) {
                  return const Center(child: CustomLoadingPagination());
                }
                if (state.weightUnitCarsStatus ==
                    WeightUnitCarsStatus.success) {
                  if (state.weightUnitsCars != null &&
                      state.weightUnitsCars!.isNotEmpty) {
                    return ListView.separated(
                      padding: EdgeInsets.zero,
                      separatorBuilder: (context, index) => Divider(
                        color: Theme.of(context).colorScheme.tertiaryContainer,
                        height: 1,
                        indent: 20,
                        endIndent: 20,
                      ),
                      itemCount: state.weightUnitsCars!.length,
                      itemBuilder: (context, index) {
                        final carItem = state.weightUnitsCars![index];
                        return GestureDetector(
                          onTap: () {
                            final isLoggedIn =
                                accessToken != null && accessToken!.isNotEmpty;

                            if (isLoggedIn) {
                              Routes.gotoHistoryDetailsView(context,
                                  carItem.tId!.toString(), carItem.tdId!);
                            } else {
                              Navigator.pushNamed(
                                  context, RoutesName.loginScreen);
                            }
                          },
                          child: CarItemWidget(item: carItem),
                        );
                      },
                    );
                  } else {
                    return EmptyWidget(
                      title: 'ไม่พบรายการรถน้ำหนักเกิน',
                      label: 'ไม่มีรถน้ำหนักเกินในขณะนี้',
                    );
                  }
                }

                if (state.weightUnitCarsStatus == WeightUnitCarsStatus.error) {
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
                            state.weightUnitsError ?? 'Unknown error',
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
                              getMobileCarList();
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
          BlocBuilder<WeightUnitBloc, WeightUnitState>(
            builder: (context, state) {
              if (state.weightUnitsCarsLoadMore == true) {
                return const Center(child: CustomLoadingPagination());
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Container FirstTabContent() {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Center(
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
                  SvgPicture.asset('assets/svg/ri_search-line.svg'),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      focusNode: focusNode,
                      onChanged: onChangedText,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'ค้นหาทะเบียนรถบรรทุก',
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
              child: const SizedBox.shrink(),
            ),
            Expanded(
              child: BlocBuilder<WeightUnitBloc, WeightUnitState>(
                builder: (context, state) {
                  if (state.weightUnitCarsStatus ==
                      WeightUnitCarsStatus.loading) {
                    return const Center(child: CustomLoadingPagination());
                  }

                  if (state.weightUnitCarsStatus ==
                      WeightUnitCarsStatus.success) {
                    if (state.weightUnitsCars != null &&
                        state.weightUnitsCars!.isNotEmpty) {
                      return ListView.separated(
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
                              final isLoggedIn = accessToken != null &&
                                  accessToken!.isNotEmpty;

                              if (isLoggedIn) {
                                Routes.gotoHistoryDetailsView(context,
                                    carItem.tId!.toString(), carItem.tdId!);
                              } else {
                                Navigator.pushNamed(
                                    context, RoutesName.loginScreen);
                              }
                            },
                            child: CarItemWidget(item: carItem),
                          );
                        },
                      );
                    } else {
                      return EmptyWidget(
                        title: 'ไม่พบรายการรถเข้าชั่ง',
                        label: 'กรุณาเพิ่มรายการรถเข้าชั่ง',
                      );
                    }
                  }

                  if (state.weightUnitCarsStatus ==
                      WeightUnitCarsStatus.error) {
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
                              state.weightUnitsError ?? 'Unknown error',
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
                                getMobileCarList();
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
            BlocBuilder<WeightUnitBloc, WeightUnitState>(
              builder: (context, state) {
                if (state.weightUnitsCarsLoadMore == true) {
                  return const Center(child: CustomLoadingPagination());
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
