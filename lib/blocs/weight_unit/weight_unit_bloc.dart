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
  WeightUnitBloc() : super(const WeightUnitState()) {
    on<GetWeightUnitsEvent>(_onGetWeightUnits);
    on<GetWeightUnitDetail>(_onGetWeightUnitDetail);
    on<GetWeightUnitCars>(_onGetWeightUnitCars);
    on<UpdateIsArrestUnitsEvent>(_onUpdateIsArrestUnits);
  }

  Future<void> _onGetWeightUnits(
    GetWeightUnitsEvent event,
    Emitter<WeightUnitState> emit,
  ) async {
    if (event.page == 1) {
      emit(state.copyWith(weightUnitsStatus: WeightUnitStatus.loading));
    } else {
      emit(state.copyWith(weightUnitsLoadmore: true));
    }

    try {
      final body = EstablishWeightReq(
        startDate: event.startDate,
        endDate: event.endDate,
        page: event.page,
        pageSize: event.pageSize,
        isOpen: '0',
        branch: event.branch,
        search: event.search,
      );

      final response = await establishRepo.getMobileMaster(body.toJson());

      if (response.statusCode >= 200 && response.statusCode < 400) {
        final List items = response.data['data'];
        final result = items.map((e) => MobileMasterModel.fromJson(e)).toList();

        final updatedList =
            event.page == 1 ? result : [...?state.weightUnits, ...result];

        emit(state.copyWith(
          weightUnitsStatus: WeightUnitStatus.success,
          weightUnits: updatedList,
          weightUnitsLoadmore: false,
          weightUnitsError: '',
        ));
      } else {
        emit(state.copyWith(
          weightUnitsStatus: WeightUnitStatus.error,
          weightUnitsError: response.error ?? 'Unknown error',
          weightUnitsLoadmore: false,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        weightUnitsStatus: WeightUnitStatus.error,
        weightUnitsError: e.toString(),
        weightUnitsLoadmore: false,
      ));
    }
  }

  Future<void> _onGetWeightUnitDetail(
    GetWeightUnitDetail event,
    Emitter<WeightUnitState> emit,
  ) async {
    emit(state.copyWith(
      weightUnitDetailStatus: WeightUnitDetailStatus.loading,
      weightUnitDetail: MobileMasterDepartmentModel.empty(),
    ));

    try {
      final response = await establishRepo.getMobileMasterDepartment(
        tid: event.tId,
      );

      if (response.statusCode >= 200 && response.statusCode < 400) {
        final result = MobileMasterDepartmentModel.fromJson(
          response.data['data'],
        );

        emit(state.copyWith(
          weightUnitDetailStatus: WeightUnitDetailStatus.success,
          weightUnitDetail: result,
        ));
      } else {
        emit(state.copyWith(
          weightUnitDetailStatus: WeightUnitDetailStatus.error,
          weightUnitDetailError: response.error ?? 'Unknown error',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        weightUnitDetailStatus: WeightUnitDetailStatus.error,
        weightUnitDetailError: e.toString(),
      ));
    }
  }

  Future<void> _onGetWeightUnitCars(
    GetWeightUnitCars event,
    Emitter<WeightUnitState> emit,
  ) async {
    if (event.payload.page == 1) {
      emit(state.copyWith(weightUnitCarsStatus: WeightUnitCarsStatus.loading));
    } else {
      emit(state.copyWith(weightUnitsCarsLoadMore: true));
    }

    try {
      final response = await establishRepo.getMobileCar(
        event.payload.toJson(),
      );

      if (response.statusCode >= 200 && response.statusCode < 400) {
        final List items = response.data['data']['data'];
        final result = items.map((e) => MobileCarModel.fromJson(e)).toList();

        final updatedList = event.payload.page == 1
            ? result
            : [...?state.weightUnitsCars, ...result];

        final total = response.data['data']['meta']['total']?.toString() ?? '0';

        emit(state.copyWith(
          weightUnitCarsStatus: WeightUnitCarsStatus.success,
          weightUnitsCars: updatedList,
          weightUnitCarsTotal: total,
          weightUnitsCarsLoadMore: false,
          weightUnitsCarsError: '',
        ));
      } else {
        emit(state.copyWith(
          weightUnitCarsStatus: WeightUnitCarsStatus.error,
          weightUnitsCarsError: response.error ?? 'Unknown error',
          weightUnitsCarsLoadMore: false,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        weightUnitCarsStatus: WeightUnitCarsStatus.error,
        weightUnitsCarsError: e.toString(),
        weightUnitsCarsLoadMore: false,
      ));
    }
  }

  void _onUpdateIsArrestUnits(
    UpdateIsArrestUnitsEvent event,
    Emitter<WeightUnitState> emit,
  ) {
    try {
      final updateItems = (state.weightUnitsCars ?? []).map((element) {
        if (element.tdId == event.tDId) {
          return element.copyWith(
            isArrested: 1,
            arrestId: event.arrestFormPostId,
          );
        }
        return element;
      }).toList();

      emit(state.copyWith(
        weightUnitCarsStatus: WeightUnitCarsStatus.success,
        weightUnitsCars: updateItems,
        weightUnitsCarsError: '',
      ));
    } catch (e) {
      emit(state.copyWith(
        weightUnitCarsStatus: WeightUnitCarsStatus.error,
        weightUnitsCarsError: e.toString(),
      ));
    }
  }
}
