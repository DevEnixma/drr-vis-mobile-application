import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wts_bloc/data/models/top_five_road/top_five_model_req.dart';

import '../../blocs/dashboard/dashboard_bloc.dart';
import '../../blocs/establish/establish_bloc.dart';
import '../../blocs/profile/profile_bloc.dart';
import '../../data/models/dashboard/req/deliy_weighed_sum_vehicle_req.dart';
import '../../data/models/dashboard/req/vehicle_weight_inspection_req.dart';
import '../../local_storage.dart';
import '../../main.dart';
import '../../service/token_refresh.service.dart';
import '../../utils/constants/key_localstorage.dart';
import '../../utils/libs/convert_date.dart';
import '../../utils/widgets/skeletion_widgets/skeletion_container_widget.dart';
import '../../utils/widgets/sneckbar_message.dart';
import '../widgets/empty_widget.dart';
import 'widgets/chart_wetght_widget.dart';
import 'widgets/title_card_widget.dart';
import 'widgets/title_dashboard_widget.dart';
import 'widgets/top_route_widget.dart';
import 'widgets/top_router_bar.dart';
import 'widgets/video_player_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final LocalStorage storage = LocalStorage();

  ScrollController? _scrollController;

  bool showAppBar = true;
  String? accessToken;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController?.addListener(_scrollListener);

    initScreen();
  }

  void initScreen() async {
    accessToken = await storage.getValueString(KeyLocalStorage.accessToken);
    setState(() {
      accessToken = accessToken;
    });

    call_api();

    getVehichleWeightInspectionFunc();
    getDailyWeighedSumFunc();
    getDashboardSumplane();

    getTopFiveRoadEventBloc();

    GetWeightUnitsIsJoinEventBloc();

    if (accessToken != null) {
      getProfile();
    }
  }

  void getProfile() async {
    context.read<ProfileBloc>().add(const GetProfileEvent());
  }

  void GetWeightUnitsIsJoinEventBloc() {
    context.read<EstablishBloc>().add(
          GetWeightUnitsIsJoinEvent(
            start_date: ConvertDate.convertDateToYYYYDDMM(
                ConvertDate.dateTimeYearSubstract(DateTime.now(), 1)),
            end_date: ConvertDate.convertDateToYYYYDDMM(
                ConvertDate.dateTimeYearAdd(DateTime.now(), 1)),
            page: 1,
            pageSize: 1,
          ),
        );
  }

  void call_api() {
    DateTime today = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(today);
    logger.i('====[formattedDate]======> $formattedDate');
    context.read<DashboardBloc>().add(CCTVFetchEvent());
  }

  void getDailyWeighedSumFunc() {
    DailyWeighedSumVehicleReq payload = DailyWeighedSumVehicleReq(
        date: ConvertDate.convertDateToYYYYDDMM(DateTime.now()));
    context
        .read<DashboardBloc>()
        .add(DailyWeighedSumVehicleFetchEvent(payload));
  }

  void getVehichleWeightInspectionFunc() {
    VehicleWeightInspectionReq payload = VehicleWeightInspectionReq(
        date: ConvertDate.convertDateToYYYYDDMM(DateTime.now()),
        numberDay: '6',
        stationTypeId: '');

    context
        .read<DashboardBloc>()
        .add(VehicleWeightInspectionFetchEvent(payload));
  }

  void getTopFiveRoadEventBloc() {
    var payload = TopFiveRoadModelReq(
      page: 1,
      pageSize: 5,
      order: 'DESC',
    );
    context.read<DashboardBloc>().add(GetTopFiveRoadEvent(payload));
  }

  void getDashboardSumplane() {
    context.read<DashboardBloc>().add(const GetDashboardViewSumPlanChart());
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_scrollListener);
    _scrollController?.dispose();
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

  @override
  Widget build(BuildContext context) {
    Provider.of<TokenRefreshService>(context, listen: false)
        .startTokenRefreshTimer();
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).colorScheme.surface,
              expandedHeight:
                  constraints.maxWidth > 400 && constraints.maxWidth < 600
                      ? 140.h
                      : 160.h,
              toolbarHeight: constraints.maxWidth > 600 ? 70.h : 62.h,
              floating: false,
              pinned: true,
              flexibleSpace: showAppBar
                  ? Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          child: Image.asset(
                            'assets/images/bg_top.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                        SafeArea(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              constraints.maxWidth > 400 &&
                                      constraints.maxWidth < 600
                                  ? const SizedBox.shrink()
                                  : SizedBox(height: 10.h),
                              const TitleDashboardWidget(),
                              FadeInDown(
                                duration: const Duration(milliseconds: 100),
                                child: const TitleCardWidget(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Container(
                      color: Theme.of(context).colorScheme.primary,
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            child: Image.asset(
                              'assets/images/bg_top.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                          SafeArea(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const TitleDashboardWidget(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(
                    height:
                        constraints.maxWidth > 400 && constraints.maxWidth < 600
                            ? 5.h
                            : 10.h),

                // Chart
                ChartWetghtWidget(constraints: constraints),

                Divider(
                  indent: 15.w,
                  endIndent: 15.w,
                  height: 1.h,
                ),
                SizedBox(height: 15.h),
                const TopRouteWidget(),
                SizedBox(height: 10.h),
                const TopRouterBar(),

                BlocListener<ProfileBloc, ProfileState>(
                  listener: (context, state) {
                    if (state.profileStatus == ProfileStatus.error &&
                        !(state.profileError?.contains("code: 401") ?? false)) {
                      showSnackbarBottom(context, state.profileError!);
                    }
                  },
                  child: const SizedBox.shrink(),
                ),

                SizedBox(height: 10.h),

                // CCTV List with Error Handling
                BlocConsumer<DashboardBloc, DashboardState>(
                  listenWhen: (previous, current) =>
                      previous.dashboardCCTVStatus !=
                      current.dashboardCCTVStatus,
                  listener: (context, state) {
                    if (state.dashboardCCTVStatus ==
                            DashboardCCTVStatus.error &&
                        state.dashboardCCTVError != null &&
                        state.dashboardCCTVError!.isNotEmpty) {
                      showSnackbarBottom(context, state.dashboardCCTVError!);
                    }
                  },
                  builder: (context, state) {
                    if (state.dashboardCCTVStatus ==
                        DashboardCCTVStatus.loading) {
                      return Column(
                        children: List.generate(
                          4,
                          (index) => Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.w, vertical: 8.h),
                            child: SkeletionContainerWidget(
                              height: 180.h,
                              width: double.infinity,
                              color: Theme.of(context).colorScheme.surface,
                            ),
                          ),
                        ),
                      );
                    }

                    if (state.dashboardCCTVStatus ==
                        DashboardCCTVStatus.success) {
                      if (state.cctvList != null &&
                          state.cctvList!.isNotEmpty) {
                        return ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.cctvList!.length,
                          itemBuilder: (BuildContext context, int index) {
                            final cctv = state.cctvList![index];

                            if (cctv.rtspHls == null || cctv.rtspHls!.isEmpty) {
                              return const SizedBox.shrink();
                            }

                            return VideoPlayerScreen(
                              title: cctv.cameraDesc ?? "กล้อง CCTV",
                              vdoUrl: cctv.rtspHls!,
                            );
                          },
                        );
                      } else {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 40.h),
                          child: const EmptyWidget(
                            title: 'ไม่พบข้อมูลกล้อง CCTV',
                            label: '',
                          ),
                        );
                      }
                    }

                    if (state.dashboardCCTVStatus ==
                        DashboardCCTVStatus.error) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.w, vertical: 40.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.videocam_off_outlined,
                              size: 64.h,
                              color: Theme.of(context).colorScheme.error,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              'ไม่สามารถโหลดกล้อง CCTV',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              state.dashboardCCTVError ??
                                  'กรุณาลองใหม่อีกครั้ง',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 24.h),
                            ElevatedButton.icon(
                              onPressed: () {
                                context
                                    .read<DashboardBloc>()
                                    .add(CCTVFetchEvent());
                              },
                              icon: const Icon(Icons.refresh),
                              label: const Text('ลองอีกครั้ง'),
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
                      );
                    }

                    return Column(
                      children: List.generate(
                        4,
                        (index) => Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 8.h),
                          child: SkeletionContainerWidget(
                            height: 180.h,
                            width: double.infinity,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: 80.h),
              ]),
            ),
          ],
        );
      }),
    );
  }
}
