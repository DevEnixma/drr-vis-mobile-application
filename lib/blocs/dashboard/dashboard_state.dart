part of 'dashboard_bloc.dart';

enum DashboardCCTVStatus {
  initial,
  loading,
  success,
  error,
}

enum DashboardSumVehicleStatus {
  initial,
  loading,
  success,
  error,
}

enum DashboardVehicleWeightInspectionStatus {
  initial,
  loading,
  success,
  error,
}

enum DashboardViewSumPlanChart {
  initial,
  loading,
  success,
  error,
}

enum TopFiveRoadStatus {
  initial,
  loading,
  success,
  error,
}

enum RoadCodeDetailStatus {
  initial,
  loading,
  success,
  error,
}

enum RoadCodeCarStatus {
  initial,
  loading,
  success,
  error,
}

class DashboardState extends Equatable {
  final DashboardCCTVStatus dashboardCCTVStatus;
  final List<CCTVResModel>? cctvList;
  final String dashboardCCTVError;

  final DashboardSumVehicleStatus dashboardSumVehicleStatus;
  final DailyWeighedVehiclesSum? dailyWeighedVehiclesSum;
  final String dashboardSumVehicleError;

  final DashboardVehicleWeightInspectionStatus
      dashboardVehicleWeightInspectionStatus;
  final List<VehicleWeightInspectionModel>? vehicleWeightInspectionList;
  final BarChartVehicleWeight? vehicleWeightInspectionBarChart;
  final List<BarChartGroupData>? totalChartList;
  final String dashboardVehicleWeightInspectionError;

  final DashboardViewSumPlanChart dashboardViewSumPlanChartStatus;
  final List<DashboardSumPlaneRes>? dashboardViewSumPlanChart;
  final String planChartYear;
  final String dashboardViewSumPlanChartError;

  final TopFiveRoadStatus topFiveRoadStatus;
  final List<TopFiveRoadModelRes>? topFiveRoad;
  final String topFiveRoadError;

  final RoadCodeDetailStatus roadCodeDetailStatus;
  final RoadCodeDetailModel? roadCodeDetail;
  final double? positionRadiant;
  final PositionMiddleModel? positionMiddle;
  final String roadCodeDetailError;

  final RoadCodeCarStatus roadCodeCarStatus;
  final List<RoadCodeCarModelRes>? roadCodeCar;
  final String roadCodeCarError;
  final bool roadCodeCarLoadMore;

  const DashboardState({
    this.dashboardCCTVStatus = DashboardCCTVStatus.initial,
    this.cctvList,
    this.dashboardCCTVError = '',
    this.dashboardSumVehicleStatus = DashboardSumVehicleStatus.initial,
    this.dailyWeighedVehiclesSum,
    this.dashboardSumVehicleError = '',
    this.dashboardVehicleWeightInspectionStatus =
        DashboardVehicleWeightInspectionStatus.initial,
    this.vehicleWeightInspectionList,
    this.vehicleWeightInspectionBarChart,
    this.totalChartList,
    this.dashboardVehicleWeightInspectionError = '',
    this.dashboardViewSumPlanChartStatus = DashboardViewSumPlanChart.initial,
    this.dashboardViewSumPlanChart,
    this.planChartYear = '',
    this.dashboardViewSumPlanChartError = '',
    this.topFiveRoadStatus = TopFiveRoadStatus.initial,
    this.topFiveRoad = const [],
    this.topFiveRoadError = '',
    this.roadCodeDetailStatus = RoadCodeDetailStatus.initial,
    this.roadCodeDetail,
    this.positionRadiant,
    this.positionMiddle,
    this.roadCodeDetailError = '',
    this.roadCodeCarStatus = RoadCodeCarStatus.initial,
    this.roadCodeCar = const [],
    this.roadCodeCarError = '',
    this.roadCodeCarLoadMore = false,
  });

  DashboardState copyWith({
    DashboardCCTVStatus? dashboardCCTVStatus,
    List<CCTVResModel>? cctvList,
    String? dashboardCCTVError,
    DashboardSumVehicleStatus? dashboardSumVehicleStatus,
    DailyWeighedVehiclesSum? dailyWeighedVehiclesSum,
    String? dashboardSumVehicleError,
    DashboardVehicleWeightInspectionStatus?
        dashboardVehicleWeightInspectionStatus,
    List<VehicleWeightInspectionModel>? vehicleWeightInspectionList,
    BarChartVehicleWeight? vehicleWeightInspectionBarChart,
    List<BarChartGroupData>? totalChartList,
    String? dashboardVehicleWeightInspectionError,
    DashboardViewSumPlanChart? dashboardViewSumPlanChartStatus,
    List<DashboardSumPlaneRes>? dashboardViewSumPlanChart,
    String? dashboardViewSumPlanChartError,
    String? planChartYear,
    TopFiveRoadStatus? topFiveRoadStatus,
    List<TopFiveRoadModelRes>? topFiveRoad,
    String? topFiveRoadError,
    RoadCodeDetailStatus? roadCodeDetailStatus,
    RoadCodeDetailModel? roadCodeDetail,
    double? positionRadiant,
    PositionMiddleModel? positionMiddle,
    String? roadCodeDetailError,
    RoadCodeCarStatus? roadCodeCarStatus,
    List<RoadCodeCarModelRes>? roadCodeCar,
    String? roadCodeCarError,
    bool? roadCodeCarLoadMore,
  }) {
    return DashboardState(
      dashboardCCTVStatus: dashboardCCTVStatus ?? this.dashboardCCTVStatus,
      cctvList: cctvList ?? this.cctvList,
      dashboardCCTVError: dashboardCCTVError ?? this.dashboardCCTVError,
      dashboardSumVehicleStatus:
          dashboardSumVehicleStatus ?? this.dashboardSumVehicleStatus,
      dailyWeighedVehiclesSum:
          dailyWeighedVehiclesSum ?? this.dailyWeighedVehiclesSum,
      dashboardSumVehicleError:
          dashboardSumVehicleError ?? this.dashboardSumVehicleError,
      dashboardVehicleWeightInspectionStatus:
          dashboardVehicleWeightInspectionStatus ??
              this.dashboardVehicleWeightInspectionStatus,
      vehicleWeightInspectionList:
          vehicleWeightInspectionList ?? this.vehicleWeightInspectionList,
      vehicleWeightInspectionBarChart: vehicleWeightInspectionBarChart ??
          this.vehicleWeightInspectionBarChart,
      totalChartList: totalChartList ?? this.totalChartList,
      dashboardVehicleWeightInspectionError:
          dashboardVehicleWeightInspectionError ??
              this.dashboardVehicleWeightInspectionError,
      dashboardViewSumPlanChartStatus: dashboardViewSumPlanChartStatus ??
          this.dashboardViewSumPlanChartStatus,
      dashboardViewSumPlanChart:
          dashboardViewSumPlanChart ?? this.dashboardViewSumPlanChart,
      planChartYear: planChartYear ?? this.planChartYear,
      dashboardViewSumPlanChartError:
          dashboardViewSumPlanChartError ?? this.dashboardViewSumPlanChartError,
      topFiveRoadStatus: topFiveRoadStatus ?? this.topFiveRoadStatus,
      topFiveRoad: topFiveRoad ?? this.topFiveRoad,
      topFiveRoadError: topFiveRoadError ?? this.topFiveRoadError,
      roadCodeDetailStatus: roadCodeDetailStatus ?? this.roadCodeDetailStatus,
      roadCodeDetail: roadCodeDetail ?? this.roadCodeDetail,
      positionRadiant: positionRadiant ?? this.positionRadiant,
      positionMiddle: positionMiddle ?? this.positionMiddle,
      roadCodeDetailError: roadCodeDetailError ?? this.roadCodeDetailError,
      roadCodeCarStatus: roadCodeCarStatus ?? this.roadCodeCarStatus,
      roadCodeCar: roadCodeCar ?? this.roadCodeCar,
      roadCodeCarError: roadCodeCarError ?? this.roadCodeCarError,
      roadCodeCarLoadMore: roadCodeCarLoadMore ?? this.roadCodeCarLoadMore,
    );
  }

  @override
  List<Object?> get props => [
        dashboardCCTVStatus,
        cctvList,
        dashboardCCTVError,
        dashboardSumVehicleStatus,
        dailyWeighedVehiclesSum,
        dashboardSumVehicleError,
        dashboardVehicleWeightInspectionStatus,
        vehicleWeightInspectionList,
        vehicleWeightInspectionBarChart,
        totalChartList,
        dashboardVehicleWeightInspectionError,
        dashboardViewSumPlanChartStatus,
        dashboardViewSumPlanChart,
        planChartYear,
        dashboardViewSumPlanChartError,
        topFiveRoadStatus,
        topFiveRoad,
        topFiveRoadError,
        roadCodeDetailStatus,
        roadCodeDetail,
        positionRadiant,
        positionMiddle,
        roadCodeDetailError,
        roadCodeCarStatus,
        roadCodeCar,
        roadCodeCarError,
        roadCodeCarLoadMore,
      ];
}
