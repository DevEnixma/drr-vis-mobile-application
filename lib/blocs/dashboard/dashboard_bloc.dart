import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wts_bloc/data/models/top_five_road/top_five_model_req.dart';
import 'package:wts_bloc/utils/constants/color_app.dart';
import 'package:wts_bloc/utils/libs/convert_date.dart';
import 'package:wts_bloc/utils/libs/string_helper.dart';

import '../../data/models/dashboard/bar_chart_vehicle_weight.dart';
import '../../data/models/dashboard/cctv_model.dart';
import '../../data/models/dashboard/daily_weighed_vehicles_sum_model.dart';
import '../../data/models/dashboard/reponse/dashboard_sum_plane_res.dart';
import '../../data/models/dashboard/req/deliy_weighed_sum_vehicle_req.dart';
import '../../data/models/dashboard/req/vehicle_weight_inspection_req.dart';
import '../../data/models/dashboard/vehicle_weight_inspection_model.dart';
import '../../data/models/road_code_car/road_code_car_model_res.dart';
import '../../data/models/road_code_car/road_code_car_req.dart';
import '../../data/models/road_code_detail/postion_middle_model.dart';
import '../../data/models/road_code_detail/road_code_detail_model.dart';
import '../../data/models/top_five_road/top_five_model_res.dart';
import '../../data/repo/repo.dart';
import '../../utils/libs/map_position_helper.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardState()) {
    on<CCTVFetchEvent>(_onCCTVFetch);
    on<DailyWeighedSumVehicleFetchEvent>(_onDailyWeighedSumVehicleFetch);
    on<VehicleWeightInspectionFetchEvent>(_onVehicleWeightInspectionFetch);
    on<GetDashboardViewSumPlanChart>(_onGetDashboardViewSumPlanChart);
    on<GetTopFiveRoadEvent>(_onGetTopFiveRoad);
    on<GetRoadCodeDetailEvent>(_onGetRoadCodeDetail);
    on<GetRoadCodeCarEvent>(_onGetRoadCodeCar);
  }

  Future<void> _onCCTVFetch(
    CCTVFetchEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(dashboardCCTVStatus: DashboardCCTVStatus.loading));

    try {
      final response = await dashboardRepo.getCCTV();

      if (response.statusCode >= 200 && response.statusCode < 400) {
        final List resultList = response.data["data"];
        final result = resultList.map((e) => CCTVResModel.fromJson(e)).toList();

        emit(state.copyWith(
          dashboardCCTVStatus: DashboardCCTVStatus.success,
          cctv_list: result,
        ));
      } else {
        emit(state.copyWith(
          dashboardCCTVStatus: DashboardCCTVStatus.error,
          dashboardCCTVError: response.error,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        dashboardCCTVStatus: DashboardCCTVStatus.error,
        dashboardCCTVError: e.toString(),
      ));
    }
  }

  Future<void> _onDailyWeighedSumVehicleFetch(
    DailyWeighedSumVehicleFetchEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(
      dashboardSumVehicleStatus: DashboardSumVehicleStatus.loading,
    ));

    try {
      final response = await dashboardRepo.getDailyWeighedSumVehicle(
        event.payload.toJson(),
      );

      if (response.statusCode >= 200 && response.statusCode < 400) {
        final result = _parseDailyWeighedSum(response.data);

        emit(state.copyWith(
          dashboardSumVehicleStatus: DashboardSumVehicleStatus.success,
          daily_weighed_vehicles_sum: result,
        ));
      } else {
        emit(state.copyWith(
          dashboardSumVehicleStatus: DashboardSumVehicleStatus.error,
          dashboardSumVehicleError: response.error,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        dashboardSumVehicleStatus: DashboardSumVehicleStatus.error,
        dashboardSumVehicleError: e.toString(),
      ));
    }
  }

  DailyWeighedVehiclesSum _parseDailyWeighedSum(dynamic data) {
    final items = data['data']['items'] as List;

    if (items.isEmpty) {
      return DailyWeighedVehiclesSum.fromJson(_getMockDailyWeighedData());
    }

    try {
      final matchingItem = items.firstWhere(
        (item) =>
            item['station_type_desc'] == 'หน่วยชั่งน้ำหนักยานพาหนะเคลื่อนที่',
        orElse: () => _getMockDailyWeighedData(),
      );

      return DailyWeighedVehiclesSum.fromJson(matchingItem);
    } catch (e) {
      return DailyWeighedVehiclesSum.fromJson(_getMockDailyWeighedData());
    }
  }

  Map<String, dynamic> _getMockDailyWeighedData() {
    return {
      "create_date": "18/10/2566",
      "station_type": 2,
      "station_type_eng": "spot",
      "station_type_desc": "หน่วยชั่งน้ำหนักยานพาหนะเคลื่อนที่",
      "total": "1",
      "over": "0"
    };
  }

  Future<void> _onVehicleWeightInspectionFetch(
    VehicleWeightInspectionFetchEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(
      dashboardVehicleWeightInspectionStatus:
          DashboardVehicleWeightInspectionStatus.loading,
    ));

    try {
      final response = await dashboardRepo.getVehicleWeightInspection(
        event.payload.toJson(),
      );

      if (response.statusCode >= 200 && response.statusCode < 400) {
        final resultList = response.data['data'] as List;

        final data = resultList.isEmpty
            ? _generateMockVehicleWeightData(7)
            : _parseVehicleWeightData(resultList);

        emit(state.copyWith(
          dashboardVehicleWeightInspectionStatus:
              DashboardVehicleWeightInspectionStatus.success,
          vehicle_weight_inspection_list: data.list,
          total_chart_list: data.chartList,
          vehicleWeightInspectionBarChart: data.barChart,
        ));
      } else {
        emit(state.copyWith(
          dashboardVehicleWeightInspectionStatus:
              DashboardVehicleWeightInspectionStatus.error,
          dashboardVehicleWeightInspectionError: response.error,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        dashboardVehicleWeightInspectionStatus:
            DashboardVehicleWeightInspectionStatus.error,
        dashboardVehicleWeightInspectionError: e.toString(),
      ));
    }
  }

  _VehicleWeightData _generateMockVehicleWeightData(int count) {
    final mockDataList = List.generate(count, (i) {
      final mockDate = {
        "create_date": ConvertDate.dateTimeSubtractDays(count - i),
        "filter_station": "all",
        "total_title": "รถเข้าชั่ง",
        "over_title": "รถน้ำหนักเกิน",
        "total": "0",
        "over": "0"
      };
      return VehicleWeightInspectionModel.fromJson(mockDate);
    });

    return _buildVehicleWeightData(mockDataList);
  }

  _VehicleWeightData _parseVehicleWeightData(List resultList) {
    final list = resultList
        .map((e) => VehicleWeightInspectionModel.fromJson(e))
        .toList();

    return _buildVehicleWeightData(list);
  }

  _VehicleWeightData _buildVehicleWeightData(
    List<VehicleWeightInspectionModel> list,
  ) {
    final chartList = <BarChartGroupData>[];
    final labels = <String>[];
    final weights = <int>[];
    final weightsOver = <int>[];

    for (var i = 0; i < list.length; i++) {
      final item = list[i];

      chartList.add(
        _makeGroupData(i, double.parse(item.total.toString())),
      );

      labels.add(
        StringHleper.convertDDMMYYYYToDDMM(item.createDate.toString()),
      );

      weights.add(int.parse(item.total!.toString()));
      weightsOver.add(int.parse(item.over!.toString()));
    }

    final barChart = BarChartVehicleWeight(
      labels: labels,
      vechicleWeight: weights,
      vechicleWeightOver: weightsOver,
    );

    return _VehicleWeightData(
      list: list,
      chartList: chartList,
      barChart: barChart,
    );
  }

  BarChartGroupData _makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: ColorApps.colorMain,
          width: 35.w,
          borderRadius: BorderRadius.circular(6.r),
        ),
      ],
      showingTooltipIndicators: [0],
    );
  }

  Future<void> _onGetDashboardViewSumPlanChart(
    GetDashboardViewSumPlanChart event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(
      dashboardViewSumPlanChartStatus: DashboardViewSumPlanChart.loading,
    ));

    try {
      final response = await dashboardRepo.getDashboardViewSumPlanChart({});

      if (response.statusCode >= 200 && response.statusCode < 400) {
        final List resultList = response.data["item"];
        final result =
            resultList.map((e) => DashboardSumPlaneRes.fromJson(e)).toList();

        emit(state.copyWith(
          dashboardViewSumPlanChartStatus: DashboardViewSumPlanChart.success,
          planChartYear: response.data["plan_year"],
          dashboardViewSumPlanChart: result,
        ));
      } else {
        emit(state.copyWith(
          dashboardViewSumPlanChartStatus: DashboardViewSumPlanChart.error,
          dashboardViewSumPlanChartError: response.error,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        dashboardViewSumPlanChartStatus: DashboardViewSumPlanChart.error,
        dashboardViewSumPlanChartError: e.toString(),
      ));
    }
  }

  Future<void> _onGetTopFiveRoad(
    GetTopFiveRoadEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(topFiveRoadStatus: TopFiveRoadStatus.loading));

    try {
      final response = await dashboardRepo.getTopFiveRoad(
        event.payload.toJson(),
      );

      if (response.statusCode >= 200 && response.statusCode < 400) {
        final List resultList = response.data['data']["items"];
        final result =
            resultList.map((e) => TopFiveRoadModelRes.fromJson(e)).toList();

        emit(state.copyWith(
          topFiveRoadStatus: TopFiveRoadStatus.success,
          topFiveRoad: result,
        ));
      } else {
        emit(state.copyWith(
          topFiveRoadStatus: TopFiveRoadStatus.error,
          topFiveRoadError: response.error,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        topFiveRoadStatus: TopFiveRoadStatus.error,
        topFiveRoadError: e.toString(),
      ));
    }
  }

  Future<void> _onGetRoadCodeDetail(
    GetRoadCodeDetailEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(roadCodeDetailStatus: RoadCodeDetailStatus.loading));

    try {
      final response = await dashboardRepo.getRoadCodeDetail(event.roadCode);

      if (response.statusCode >= 200 && response.statusCode < 400) {
        final result = RoadCodeDetailModel.fromJson(response.data['data']);

        final latMid = (result.latStart! + result.latEnd!) / 2;
        final lonMid = (result.lonStart! + result.lonEnd!) / 2;

        final positionMiddle = PositionMiddleModel(
          positionMiddleLat: latMid,
          positionMiddleLng: lonMid,
        );

        final radiant = MapPositionHleper.calculateMiddleAndDistance(
          result.latStart!,
          result.lonStart!,
          result.latEnd!,
          result.lonEnd!,
        );

        emit(state.copyWith(
          roadCodeDetailStatus: RoadCodeDetailStatus.success,
          roadCodeDetail: result,
          positionRadiant: double.parse(radiant),
          positionMiddle: positionMiddle,
        ));
      } else {
        emit(state.copyWith(
          roadCodeDetailStatus: RoadCodeDetailStatus.error,
          roadCodeDetailError: response.error,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        roadCodeDetailStatus: RoadCodeDetailStatus.error,
        roadCodeDetailError: e.toString(),
      ));
    }
  }

  Future<void> _onGetRoadCodeCar(
    GetRoadCodeCarEvent event,
    Emitter<DashboardState> emit,
  ) async {
    if (event.payload.page == 1) {
      emit(state.copyWith(roadCodeCarStatus: RoadCodeCarStatus.loading));
    } else {
      emit(state.copyWith(roadCodeCarLoadMore: true));
    }

    try {
      final response = await dashboardRepo.getRoadCodeCar(
        event.payload.toJson(),
      );

      if (response.statusCode >= 200 && response.statusCode < 400) {
        final List resultList = response.data['data'];
        final result =
            resultList.map((e) => RoadCodeCarModelRes.fromJson(e)).toList();

        final updatedList = event.payload.page == 1
            ? result
            : [...?state.roadCodeCar, ...result];

        emit(state.copyWith(
          roadCodeCarStatus: RoadCodeCarStatus.success,
          roadCodeCar: updatedList,
          roadCodeCarLoadMore: false,
        ));
      } else {
        emit(state.copyWith(
          roadCodeCarStatus: RoadCodeCarStatus.error,
          roadCodeCarError: response.error,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        roadCodeCarStatus: RoadCodeCarStatus.error,
        roadCodeCarError: e.toString(),
      ));
    }
  }
}

class _VehicleWeightData {
  final List<VehicleWeightInspectionModel> list;
  final List<BarChartGroupData> chartList;
  final BarChartVehicleWeight barChart;

  _VehicleWeightData({
    required this.list,
    required this.chartList,
    required this.barChart,
  });
}
