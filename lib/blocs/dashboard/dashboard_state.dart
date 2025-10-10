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
  final List<CCTVResModel>? cctv_list;
  final String dashboardCCTVError;

  final DashboardSumVehicleStatus dashboardSumVehicleStatus;
  final DailyWeighedVehiclesSum? daily_weighed_vehicles_sum;
  final String dashboardSumVehicleError;

  final DashboardVehicleWeightInspectionStatus dashboardVehicleWeightInspectionStatus;
  final List<VehicleWeightInspectionModel>? vehicle_weight_inspection_list;
  final BarChartVehicleWeight? vehicleWeightInspectionBarChart;
  final List<BarChartGroupData>? total_chart_list;
  final String dashboardVehicleWeightInspectionError;

  final DashboardViewSumPlanChart dashboardViewSumPlanChartStatus;
  final List<DashboardSumPlaneRes>? dashboardViewSumPlanChart;
  final String planChartYear;
  final String dashboardViewSumPlanChartError;

  final TopFiveRoadStatus topFiveRoadStatus;
  final List<TopFiveRoadModelRes>? topFiveRoad;
  final String topFiveRoadError;

  // roadCodeDetail
  final RoadCodeDetailStatus roadCodeDetailStatus;
  final RoadCodeDetailModel? roadCodeDetail;
  final double? positionRadiant;
  final PositionMiddleModel? positionMiddle;
  final String roadCodeDetailError;

  // roadCode car
  final RoadCodeCarStatus roadCodeCarStatus;
  final List<RoadCodeCarModelRes>? roadCodeCar;
  final String roadCodeCarError;
  final bool roadCodeCarLoadMore;

  const DashboardState({
    // cctv
    this.dashboardCCTVStatus = DashboardCCTVStatus.initial,
    this.cctv_list,
    this.dashboardCCTVError = '',

    // daily sum weighed vehicles
    this.dashboardSumVehicleStatus = DashboardSumVehicleStatus.initial,
    this.daily_weighed_vehicles_sum,
    this.dashboardSumVehicleError = '',

    // vehicle weight inspection
    this.dashboardVehicleWeightInspectionStatus = DashboardVehicleWeightInspectionStatus.initial,
    this.vehicle_weight_inspection_list,
    this.vehicleWeightInspectionBarChart,
    this.total_chart_list,
    this.dashboardVehicleWeightInspectionError = '',

    // vehicle weight inspection
    this.dashboardViewSumPlanChartStatus = DashboardViewSumPlanChart.initial,
    this.dashboardViewSumPlanChart,
    this.planChartYear = '',
    this.dashboardViewSumPlanChartError = '',

    // top five road
    this.topFiveRoadStatus = TopFiveRoadStatus.initial,
    this.topFiveRoad = const [],
    this.topFiveRoadError = '',

    // roadCodeDetail
    this.roadCodeDetailStatus = RoadCodeDetailStatus.initial,
    this.roadCodeDetail,
    this.positionRadiant,
    this.positionMiddle,
    this.roadCodeDetailError = '',

    // roadCode car
    this.roadCodeCarStatus = RoadCodeCarStatus.initial,
    this.roadCodeCar = const [],
    this.roadCodeCarError = '',
    this.roadCodeCarLoadMore = false,
  });
  DashboardState copyWith({
    // cctv
    DashboardCCTVStatus? dashboardCCTVStatus,
    List<CCTVResModel>? cctv_list,
    String? dashboardCCTVError,
    // daily sum weighed vehicles
    DashboardSumVehicleStatus? dashboardSumVehicleStatus,
    DailyWeighedVehiclesSum? daily_weighed_vehicles_sum,
    String? dashboardSumVehicleError,

    // vehicle weight inspection
    DashboardVehicleWeightInspectionStatus? dashboardVehicleWeightInspectionStatus,
    List<VehicleWeightInspectionModel>? vehicle_weight_inspection_list,
    BarChartVehicleWeight? vehicleWeightInspectionBarChart,
    List<BarChartGroupData>? total_chart_list,
    String? dashboardVehicleWeightInspectionError,

    // daily sum weighed vehicles
    DashboardViewSumPlanChart? dashboardViewSumPlanChartStatus,
    List<DashboardSumPlaneRes>? dashboardViewSumPlanChart,
    String? dashboardViewSumPlanChartError,
    String? planChartYear,

    // top five road
    TopFiveRoadStatus? topFiveRoadStatus,
    List<TopFiveRoadModelRes>? topFiveRoad,
    String? topFiveRoadError,

    // roadCodeDetail
    RoadCodeDetailStatus? roadCodeDetailStatus,
    RoadCodeDetailModel? roadCodeDetail,
    double? positionRadiant,
    PositionMiddleModel? positionMiddle,
    String? roadCodeDetailError,

    // roadCode car
    RoadCodeCarStatus? roadCodeCarStatus,
    List<RoadCodeCarModelRes>? roadCodeCar,
    String? roadCodeCarError,
    bool? roadCodeCarLoadMore,
  }) {
    return DashboardState(
      // cctv
      dashboardCCTVStatus: dashboardCCTVStatus ?? this.dashboardCCTVStatus,
      cctv_list: cctv_list ?? this.cctv_list,
      dashboardCCTVError: dashboardCCTVError ?? this.dashboardCCTVError,
      // daily sum weighed vehicles
      dashboardSumVehicleStatus: dashboardSumVehicleStatus ?? this.dashboardSumVehicleStatus,
      daily_weighed_vehicles_sum: daily_weighed_vehicles_sum ?? this.daily_weighed_vehicles_sum,
      dashboardSumVehicleError: dashboardSumVehicleError ?? this.dashboardSumVehicleError,
      // vehicle weight inspection
      dashboardVehicleWeightInspectionStatus: dashboardVehicleWeightInspectionStatus ?? this.dashboardVehicleWeightInspectionStatus,
      vehicle_weight_inspection_list: vehicle_weight_inspection_list ?? this.vehicle_weight_inspection_list,
      vehicleWeightInspectionBarChart: vehicleWeightInspectionBarChart ?? this.vehicleWeightInspectionBarChart,
      total_chart_list: total_chart_list ?? this.total_chart_list,
      dashboardVehicleWeightInspectionError: dashboardVehicleWeightInspectionError ?? this.dashboardVehicleWeightInspectionError,

      // daily sum weighed vehicles
      dashboardViewSumPlanChartStatus: dashboardViewSumPlanChartStatus ?? this.dashboardViewSumPlanChartStatus,
      dashboardViewSumPlanChart: dashboardViewSumPlanChart ?? this.dashboardViewSumPlanChart,
      planChartYear: planChartYear ?? this.planChartYear,
      dashboardViewSumPlanChartError: dashboardViewSumPlanChartError ?? this.dashboardViewSumPlanChartError,

      // top five road
      topFiveRoadStatus: topFiveRoadStatus ?? this.topFiveRoadStatus,
      topFiveRoad: topFiveRoad ?? this.topFiveRoad,
      topFiveRoadError: topFiveRoadError ?? this.topFiveRoadError,

      // roadCodeDetail
      roadCodeDetailStatus: roadCodeDetailStatus ?? this.roadCodeDetailStatus,
      roadCodeDetail: roadCodeDetail ?? this.roadCodeDetail,
      positionRadiant: positionRadiant ?? this.positionRadiant,
      positionMiddle: positionMiddle ?? this.positionMiddle,
      roadCodeDetailError: roadCodeDetailError ?? this.roadCodeDetailError,

      // roadCode car
      roadCodeCarStatus: roadCodeCarStatus ?? this.roadCodeCarStatus,
      roadCodeCar: roadCodeCar ?? this.roadCodeCar,
      roadCodeCarError: roadCodeCarError ?? this.roadCodeCarError,
      roadCodeCarLoadMore: roadCodeCarLoadMore ?? this.roadCodeCarLoadMore,
    );
  }

  @override
  List<Object?> get props => [
        // cctv
        dashboardCCTVStatus,
        cctv_list,
        dashboardCCTVError,
        // daily sum weighed vehicles
        dashboardSumVehicleStatus,
        daily_weighed_vehicles_sum,
        dashboardSumVehicleError,
        // vehicle weight inspection
        dashboardVehicleWeightInspectionStatus,
        vehicle_weight_inspection_list,
        vehicleWeightInspectionBarChart,
        total_chart_list,
        dashboardVehicleWeightInspectionError,

        dashboardViewSumPlanChartStatus,
        dashboardViewSumPlanChart,
        planChartYear,
        dashboardViewSumPlanChartError,

        // top five road
        topFiveRoadStatus,
        topFiveRoad,
        topFiveRoadError,

        // roadCodeDetail
        roadCodeDetailStatus,
        roadCodeDetail,
        positionRadiant,
        positionMiddle,
        roadCodeDetailError,

        // roadCode car
        roadCodeCarStatus,
        roadCodeCar,
        roadCodeCarError,
        roadCodeCarLoadMore,
      ];
}
