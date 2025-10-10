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

  double sliderValue = 20;

  bool showAppBar = true;
  bool isLoading = true;
  bool isLogged = false;

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
            start_date: ConvertDate.convertDateToYYYYDDMM(ConvertDate.dateTimeYearSubstract(DateTime.now(), 1)),
            end_date: ConvertDate.convertDateToYYYYDDMM(ConvertDate.dateTimeYearAdd(DateTime.now(), 1)),
            page: 1,
            pageSize: 1,
          ),
        );
  }

  void call_api() {
    DateTime today = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(today);
    logger.i('====[formattedDate]======> $formattedDate'); // Output: 2023-03-25
    context.read<DashboardBloc>().add(CCTVFetchEvent());
    // number_day ส่ง 7 ได้ 8 วัน
  }

  void getDailyWeighedSumFunc() {
    DailyWeighedSumVehicleReq payload = DailyWeighedSumVehicleReq(date: ConvertDate.convertDateToYYYYDDMM(DateTime.now()));
    // TODO: issue
    context.read<DashboardBloc>().add(DailyWeighedSumVehicleFetchEvent(payload));
  }

  void getVehichleWeightInspectionFunc() {
    VehicleWeightInspectionReq payload = VehicleWeightInspectionReq(date: ConvertDate.convertDateToYYYYDDMM(DateTime.now()), numberDay: '6', stationTypeId: '');
//
    // TODO: issue
    context.read<DashboardBloc>().add(VehicleWeightInspectionFetchEvent(payload));
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
        print(_scrollController);
      });
    } else if (_scrollController!.offset <= 50 && !showAppBar) {
      setState(() {
        showAppBar = true;
        print(_scrollController);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<TokenRefreshService>(context, listen: false).startTokenRefreshTimer();
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).colorScheme.surface,
              expandedHeight: constraints.maxWidth > 400 && constraints.maxWidth < 600 ? 140.h : 160.h,
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
                              constraints.maxWidth > 400 && constraints.maxWidth < 600 ? const SizedBox.shrink() : SizedBox(height: 10.h),
                              TitleDashboardWidget(),
                              FadeInDown(
                                duration: Duration(milliseconds: 100),
                                child: TitleCardWidget(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Container(
                      color: Theme.of(context).colorScheme.primary,
                      padding: EdgeInsets.only(bottom: 10),
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
                                TitleDashboardWidget(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: constraints.maxWidth > 400 && constraints.maxWidth < 600 ? 15.h : 35.h),

                // Chart ยังไม่ได้ login
                ChartWetghtWidget(constraints: constraints),

                Divider(
                  indent: 15.w,
                  endIndent: 15.w,
                  height: 1.h,
                ),
                SizedBox(height: 15.h),
                TopRouteWidget(),
                SizedBox(height: 10.h),
                TopRouterBar(),

                BlocListener<ProfileBloc, ProfileState>(
                  listener: (context, state) {
                    if (state.profileStatus == ProfileStatus.error && !(state.profileError?.contains("code: 401") ?? false)) {
                      showSnackbarBottom(context, state.profileError!);
                    }
                  },
                  child: SizedBox.shrink(),
                ),
                SizedBox(height: 10.h),
                BlocBuilder<DashboardBloc, DashboardState>(
                  builder: (context, state) {
                    if (state.dashboardCCTVStatus == DashboardCCTVStatus.success) {
                      if (state.cctv_list != null && state.cctv_list!.isNotEmpty) {
                        return SizedBox(
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.cctv_list!.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (state.cctv_list![index].rtspHls == null) {
                                return SizedBox.shrink(); // Return an empty widget
                              }
                              // return null;

                              return VideoPlayerScreen(
                                title: state.cctv_list![index].cameraDesc ?? "",
                                vdoUrl: state.cctv_list![index].rtspHls ?? 'https://67mst-pyoipc025-015.enixma.net/live/10.172.24.6.stream/playlist.m3u8',
                              );
                            },
                          ),
                        );
                      } else {
                        return EmptyWidget(
                          title: 'ไม่พบข้อมูล',
                          label: '',
                        );
                      }
                    }

                    if (state.dashboardCCTVStatus == DashboardCCTVStatus.error) {}
                    return Column(
                      children: [
                        SkeletionContainerWidget(
                          height: 180.h,
                          width: 300.w,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        SkeletionContainerWidget(
                          height: 180.h,
                          width: 300.w,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        SkeletionContainerWidget(
                          height: 180.h,
                          width: 300.w,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        SkeletionContainerWidget(
                          height: 180.h,
                          width: 300.w,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ],
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
