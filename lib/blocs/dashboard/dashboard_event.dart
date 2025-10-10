part of 'dashboard_bloc.dart';

class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class CCTVFetchEvent extends DashboardEvent {
  const CCTVFetchEvent();
}

class DailyWeighedSumVehicleFetchEvent extends DashboardEvent {
  final DailyWeighedSumVehicleReq payload;

  const DailyWeighedSumVehicleFetchEvent(this.payload);
}

class VehicleWeightInspectionFetchEvent extends DashboardEvent {
  final VehicleWeightInspectionReq payload;

  const VehicleWeightInspectionFetchEvent(this.payload);
}

class GetDashboardViewSumPlanChart extends DashboardEvent {
  const GetDashboardViewSumPlanChart();
}

class GetTopFiveRoadEvent extends DashboardEvent {
  final TopFiveRoadModelReq payload;

  const GetTopFiveRoadEvent(this.payload);
}

class GetRoadCodeDetailEvent extends DashboardEvent {
  final String roadCode;

  const GetRoadCodeDetailEvent(this.roadCode);
}

class GetRoadCodeCarEvent extends DashboardEvent {
  final RoadCodeCarModelReq payload;

  const GetRoadCodeCarEvent(this.payload);
}
