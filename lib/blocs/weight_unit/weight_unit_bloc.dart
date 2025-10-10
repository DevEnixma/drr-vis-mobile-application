import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/establish/establish_weight_car_req.dart';
import '../../data/models/establish/establish_weight_req.dart';
import '../../data/models/establish/mobile_car_model.dart';
import '../../data/models/establish/mobile_master_department_model.dart';
import '../../data/models/establish/mobile_master_model.dart';
import '../../data/repo/repo.dart';

part 'weight_unit_event.dart';
part 'weight_unit_state.dart';

class WeightUnitBloc extends Bloc<WeightUnitEvent, WeightUnitState> {
  WeightUnitBloc() : super(WeightUnitState()) {
    on<GetWeightUnitsEvent>((event, emit) async {
      try {
        emit(state.copyWith(weightUnitsError: ''));
        if (event.page == 1) {
          emit(state.copyWith(weightUnitsStatus: WeightUnitStatus.loading));
        } else {
          emit(state.copyWith(weightUnitsLoadmore: true));
        }

        var body = EstablishWeightReq(
          startDate: event.start_date,
          endDate: event.end_date,
          page: event.page,
          pageSize: event.pageSize,
          isOpen: '0',
          branch: event.branch,
          search: event.search,
        );

        final response = await establishRepo.getMobileMaster(body.toJson());

        if (response.statusCode >= 200 && response.statusCode < 400) {
          final List items = response.data['data'];
          var result = items.map((e) => MobileMasterModel.fromJson(e)).toList();

          if (event.page != 1) {
            state.weightUnits!.addAll(result);

            emit(state.copyWith(weightUnits: state.weightUnits!));

            emit(state.copyWith(weightUnitsLoadmore: false));
          } else {
            emit(state.copyWith(weightUnits: result));
          }

          emit(state.copyWith(weightUnitsStatus: WeightUnitStatus.success));
          return;
        }

        emit(state.copyWith(weightUnitsStatus: WeightUnitStatus.error, weightUnitsError: response.error));
      } catch (e) {
        emit(state.copyWith(weightUnitsStatus: WeightUnitStatus.error, weightUnitsError: e.toString()));
      }
    });

    on<GetWeightUnitDetail>((event, emit) async {
      try {
        emit(state.copyWith(weightUnitDetailStatus: WeightUnitDetailStatus.loading, weightUnitDetail: MobileMasterDepartmentModel.empty()));
        final response = await establishRepo.getMobileMasterDepartment(tid: event.tId.toString());

        if (response.statusCode >= 200 && response.statusCode < 400) {
          var result = MobileMasterDepartmentModel.fromJson(response.data['data']);

          emit(state.copyWith(weightUnitDetailStatus: WeightUnitDetailStatus.success, weightUnitDetail: result));
          return;
        }

        emit(state.copyWith(weightUnitDetailStatus: WeightUnitDetailStatus.error, weightUnitDetailError: response.error));
        return;
      } catch (e) {
        emit(state.copyWith(weightUnitDetailStatus: WeightUnitDetailStatus.error, weightUnitDetailError: e.toString()));
        return;
      }
    });

    on<GetWeightUnitCars>((event, emit) async {
      try {
        emit(state.copyWith(weightUnitsCarsError: ''));

        if (event.payload.page == 1) {
          emit(state.copyWith(weightUnitCarsStatus: WeightUnitCarsStatus.loading));
        } else {
          emit(state.copyWith(weightUnitsCarsLoadMore: true));
        }
        final response = await establishRepo.getMobileCar(event.payload.toJson());

        if (response.statusCode >= 200 && response.statusCode < 400) {
          final List items = response.data['data']['data'];
          var result = items.map((e) => MobileCarModel.fromJson(e)).toList();

          if (event.payload.page != 1) {
            state.weightUnitsCars!.addAll(result);

            emit(state.copyWith(weightUnitsCars: state.weightUnitsCars!));

            emit(state.copyWith(weightUnitsCarsLoadMore: false));
          } else {
            emit(state.copyWith(weightUnitsCars: result));
          }

          emit(state.copyWith(weightUnitCarsTotal: response.data['data']['meta']['total'].toString()));
          emit(state.copyWith(weightUnitCarsStatus: WeightUnitCarsStatus.success));

          return;
        }
        emit(state.copyWith(weightUnitCarsStatus: WeightUnitCarsStatus.error, weightUnitsCarsError: response.error));
      } catch (e) {
        emit(state.copyWith(weightUnitCarsStatus: WeightUnitCarsStatus.error, weightUnitsCarsError: e.toString()));
      }
    });

    on<UpdateIsArrestUnitsEvent>((event, emit) async {
      try {
        emit(state.copyWith(weightUnitCarsStatus: WeightUnitCarsStatus.loading, weightUnitsCarsError: ''));

        final updateItems = (state.weightUnitsCars ?? []).map((element) {
          if (element.tdId == event.tDId) {
            return element.copyWith(isArrested: 1, arrestId: event.arrestFormPostId.toString());
          }
          return element;
        }).toList();
        emit(state.copyWith(weightUnitsCars: updateItems));

        emit(state.copyWith(weightUnitCarsStatus: WeightUnitCarsStatus.success));
        return;
      } catch (e) {
        emit(state.copyWith(weightUnitCarsStatus: WeightUnitCarsStatus.error, weightUnitsCarsError: e.toString()));
        return;
      }
    });
  }
}
