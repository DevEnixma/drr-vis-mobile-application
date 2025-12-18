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
    on<CCTVFetchEvent>((event, emit) async {
      emit(state.copyWith(dashboardCCTVStatus: DashboardCCTVStatus.loading));

      try {
        final response = await dashboardRepo.getCCTV();
        if (response.statusCode >= 200 && response.statusCode < 400) {
          final List resultList = response.data["data"];
          var result = resultList.map((e) => CCTVResModel.fromJson(e)).toList();

          emit(state.copyWith(
              dashboardCCTVStatus: DashboardCCTVStatus.success,
              cctv_list: result));
          return;
        }

        emit(state.copyWith(
            dashboardCCTVStatus: DashboardCCTVStatus.error,
            dashboardCCTVError: response.error));
      } catch (e) {
        emit(state.copyWith(
            dashboardCCTVStatus: DashboardCCTVStatus.error,
            dashboardCCTVError: e.toString()));
        print('error ${e.toString()}');
      }
    });

    on<DailyWeighedSumVehicleFetchEvent>((event, emit) async {
      emit(state.copyWith(
          dashboardSumVehicleStatus: DashboardSumVehicleStatus.loading));

      try {
        final response = await dashboardRepo
            .getDailyWeighedSumVehicle(event.payload.toJson());
        if (response.statusCode >= 200 && response.statusCode < 400) {
          DailyWeighedVehiclesSum result = DailyWeighedVehiclesSum.empty();

          if (response.data['data']['items'].length != 0) {
            // print("XXXXX: ${response.data['data']['items']}");
            try {
              var matchingItem = response.data['data']['items'].firstWhere(
                (item) =>
                    item['station_type_desc'] ==
                    'หน่วยชั่งน้ำหนักยานพาหนะเคลื่อนที่',
                orElse: () => null,
              );

              if (matchingItem != null) {
                result = DailyWeighedVehiclesSum.fromJson(matchingItem);
              }
            } catch (e) {
              print("Error finding matching item: $e");
            }
          } else {
            var mockData = {
              "create_date": "18/10/2566",
              "station_type": 2,
              "station_type_eng": "spot",
              "station_type_desc": "หน่วยชั่งน้ำหนักยานพาหนะเคลื่อนที่",
              "total": "1",
              "over": "0"
            };
            result = DailyWeighedVehiclesSum.fromJson(mockData);
          }

          emit(state.copyWith(
              dashboardSumVehicleStatus: DashboardSumVehicleStatus.success,
              daily_weighed_vehicles_sum: result));
          return;
        }

        emit(state.copyWith(
            dashboardSumVehicleStatus: DashboardSumVehicleStatus.error,
            dashboardSumVehicleError: response.error));
      } catch (e) {
        emit(state.copyWith(
            dashboardSumVehicleStatus: DashboardSumVehicleStatus.error,
            dashboardSumVehicleError: e.toString()));
        print('error ${e.toString()}');
      }
    });

    on<VehicleWeightInspectionFetchEvent>((event, emit) async {
      try {
        emit(state.copyWith(
            dashboardVehicleWeightInspectionStatus:
                DashboardVehicleWeightInspectionStatus.loading));
        final response = await dashboardRepo
            .getVehicleWeightInspection(event.payload.toJson());
        if (response.statusCode >= 200 && response.statusCode < 400) {
          List<String> barChartLabel = [];
          List<int> barChartVechicleWeight = [];
          List<int> barChartVechicleWeightOver = [];

          late List<BarChartGroupData> total_chart_list = [];

          if (response.data['data'].length == 0) {
            int count = 7;
            late List<VehicleWeightInspectionModel> mockDataList = [];
            for (int i = 0; i < count; i++) {
              var mockDate = {
                "create_date": ConvertDate.dateTimeSubtractDays(count - i),
                "filter_station": "all",
                "total_title": "รถเข้าชั่ง",
                "over_title": "รถน้ำหนักเกิน",
                "total": "0",
                "over": "0"
              };
              mockDataList.add(VehicleWeightInspectionModel.fromJson(mockDate));
            }

            for (int j = 0; j < mockDataList.length; j++) {
              total_chart_list.add(makeGroupData(
                  j, double.parse(mockDataList[j].total.toString())));

              barChartLabel.add(StringHleper.convertDDMMYYYYToDDMM(
                  mockDataList[j].createDate.toString()));
              barChartVechicleWeight
                  .add(int.parse(mockDataList[j].total!.toString()));
              barChartVechicleWeightOver
                  .add(int.parse(mockDataList[j].over!.toString()));
            }

            emit(state.copyWith(
              vehicle_weight_inspection_list: mockDataList,
            ));
          } else {
            final List resultList = response.data["data"];
            var result = resultList
                .map((e) => VehicleWeightInspectionModel.fromJson(e))
                .toList();

            for (var i = 0; i < result.length; i++) {
              total_chart_list.add(
                  makeGroupData(i, double.parse(result[i].total.toString())));

              barChartLabel.add(StringHleper.convertDDMMYYYYToDDMM(
                  result[i].createDate.toString()));
              barChartVechicleWeight
                  .add(int.parse(result[i].total!.toString()));
              barChartVechicleWeightOver
                  .add(int.parse(result[i].over!.toString()));
            }

            emit(state.copyWith(
              vehicle_weight_inspection_list: result,
            ));
          }

          BarChartVehicleWeight barChartVehicleWeight = BarChartVehicleWeight(
            labels: barChartLabel,
            vechicleWeight: barChartVechicleWeight,
            vechicleWeightOver: barChartVechicleWeightOver,
          );

          emit(state.copyWith(
            total_chart_list: total_chart_list,
            vehicleWeightInspectionBarChart: barChartVehicleWeight,
          ));

          emit(state.copyWith(
            dashboardVehicleWeightInspectionStatus:
                DashboardVehicleWeightInspectionStatus.success,
          ));
          return;
        }

        emit(state.copyWith(
            dashboardVehicleWeightInspectionStatus:
                DashboardVehicleWeightInspectionStatus.error,
            dashboardVehicleWeightInspectionError: response.error));
      } catch (e) {
        emit(state.copyWith(
            dashboardVehicleWeightInspectionStatus:
                DashboardVehicleWeightInspectionStatus.error,
            dashboardVehicleWeightInspectionError: e.toString()));
      }
    });

    on<GetDashboardViewSumPlanChart>((event, emit) async {
      try {
        emit(state.copyWith(
            dashboardViewSumPlanChartStatus:
                DashboardViewSumPlanChart.loading));
        ;
        final response = await dashboardRepo.getDashboardViewSumPlanChart({});
        if (response.statusCode >= 200 && response.statusCode < 400) {
          emit(state.copyWith(planChartYear: response.data["plan_year"]));
          final List resultList = response.data["item"];

          var result =
              resultList.map((e) => DashboardSumPlaneRes.fromJson(e)).toList();

          emit(state.copyWith(
            dashboardViewSumPlanChartStatus: DashboardViewSumPlanChart.success,
            dashboardViewSumPlanChart: result,
          ));

          return;
        }

        emit(state.copyWith(
            dashboardViewSumPlanChartStatus: DashboardViewSumPlanChart.error,
            dashboardViewSumPlanChartError: response.error));
        return;
      } catch (e) {
        emit(state.copyWith(
            dashboardViewSumPlanChartStatus: DashboardViewSumPlanChart.error,
            dashboardViewSumPlanChartError: e.toString()));
      }
    });

    on<GetTopFiveRoadEvent>((event, emit) async {
      emit(state.copyWith(topFiveRoadStatus: TopFiveRoadStatus.loading));

      try {
        final response =
            await dashboardRepo.getTopFiveRoad(event.payload.toJson());
        if (response.statusCode >= 200 && response.statusCode < 400) {
          final List resultList = response.data['data']["items"];

          var result =
              resultList.map((e) => TopFiveRoadModelRes.fromJson(e)).toList();

          emit(state.copyWith(topFiveRoad: result));

          emit(state.copyWith(topFiveRoadStatus: TopFiveRoadStatus.success));

          return;
        }

        emit(state.copyWith(
            topFiveRoadStatus: TopFiveRoadStatus.error,
            topFiveRoadError: response.error));
        return;
      } catch (e) {
        emit(state.copyWith(
            topFiveRoadStatus: TopFiveRoadStatus.error,
            topFiveRoadError: e.toString()));
      }
    });

    on<GetRoadCodeDetailEvent>((event, emit) async {
      try {
        emit(
            state.copyWith(roadCodeDetailStatus: RoadCodeDetailStatus.loading));
        final response = await dashboardRepo.getRoadCodeDetail(event.roadCode);
        if (response.statusCode >= 200 && response.statusCode < 400) {
          var result = RoadCodeDetailModel.fromJson(response.data['data']);

          // คำนวณพิกัดตรงกลาง
          final latMid = (result.latStart! + result.latEnd!) / 2;
          final lonMid = (result.lonStart! + result.lonEnd!) / 2;

          var positionMiddle = PositionMiddleModel(
            positionMiddleLat: latMid,
            positionMiddleLng: lonMid,
          );

          String radiant = MapPositionHleper.calculateMiddleAndDistance(
            result.latStart!,
            result.lonStart!,
            result.latEnd!,
            result.lonEnd!,
          );

          emit(state.copyWith(
              roadCodeDetail: result,
              positionRadiant: double.parse(radiant),
              positionMiddle: positionMiddle));

          emit(state.copyWith(
              roadCodeDetailStatus: RoadCodeDetailStatus.success));

          return;
        }

        emit(state.copyWith(
            roadCodeDetailStatus: RoadCodeDetailStatus.error,
            roadCodeDetailError: response.error));
        return;
      } catch (e) {
        emit(state.copyWith(
            roadCodeDetailStatus: RoadCodeDetailStatus.error,
            roadCodeDetailError: e.toString()));
      }
    });

    on<GetRoadCodeCarEvent>((event, emit) async {
      try {
        if (event.payload.page == 1) {
          emit(state.copyWith(roadCodeCarStatus: RoadCodeCarStatus.loading));
        } else {
          emit(state.copyWith(roadCodeCarLoadMore: true));
        }

        final response =
            await dashboardRepo.getRoadCodeCar(event.payload.toJson());
        if (response.statusCode >= 200 && response.statusCode < 400) {
          final List resultList = response.data['data'];

          final result =
              resultList.map((e) => RoadCodeCarModelRes.fromJson(e)).toList();
          if (event.payload.page != 1) {
            state.roadCodeCar!.addAll(result);
            emit(state.copyWith(roadCodeCar: state.roadCodeCar));
            emit(state.copyWith(roadCodeCarLoadMore: false));
          } else {
            emit(state.copyWith(roadCodeCar: result));
          }

          emit(state.copyWith(roadCodeCarStatus: RoadCodeCarStatus.success));

          return;
        }

        emit(state.copyWith(
            roadCodeCarStatus: RoadCodeCarStatus.error,
            roadCodeCarError: response.error));
        return;
      } catch (e) {
        emit(state.copyWith(
            roadCodeCarStatus: RoadCodeCarStatus.error,
            roadCodeCarError: e.toString()));

        return;
      }
    });
  }
}

BarChartGroupData makeGroupData(int x, double y) {
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
