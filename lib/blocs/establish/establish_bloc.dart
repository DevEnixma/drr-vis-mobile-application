import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/establish/car_detail_model_res.dart';
import '../../data/models/establish/car_detali_image_model.res.dart';
import '../../data/models/establish/establish_add_unit.req.dart';
import '../../data/models/establish/establish_add_unit.res.dart';
import '../../data/models/establish/establish_weight_car_req.dart';
import '../../data/models/establish/establish_weight_pagination_res.dart';
import '../../data/models/establish/establish_weight_req.dart';
import '../../data/models/establish/mobile_car_model.dart';
import '../../data/models/establish/mobile_master_department_model.dart';
import '../../data/models/establish/mobile_master_model.dart';
import '../../data/models/establish/weight_card_res.dart';
import '../../data/models/home/join_weight_unit.dart';
import '../../data/repo/repo.dart';
import '../../local_storage.dart';
import '../../utils/constants/key_localstorage.dart';

part 'establish_event.dart';
part 'establish_state.dart';

class EstablishBloc extends Bloc<EstablishEvent, EstablishState> {
  EstablishBloc() : super(const EstablishState()) {
    on<MobileMasterFetchEvent>(_onMobileMasterFetch);
    on<MobileMasterDepartmentFetchEvent>(_onMobileMasterDepartmentFetch);
    on<CreateUnitWeight>(_onCreateUnitWeight);
    on<ResetCreateUnitWeight>(_onResetCreateUnitWeight);
    on<GetCarDetailEvent>(_onGetCarDetail);
    on<GetCarDetailImageEvent>(_onGetCarDetailImage);
    on<PostJoinWeightUnit>(_onPostJoinWeightUnit);
    on<DeleteJoinWeightUnit>(_onDeleteJoinWeightUnit);
    on<GetWeightUnitsIsJoinEvent>(_onGetWeightUnitsIsJoin);
    on<ClearPostJoinWeightUnit>(_onClearPostJoinWeightUnit);
    on<DeleteWeightUnitLeaveEvent>(_onDeleteWeightUnitLeave);
    on<PostWeightUnitCloseEvent>(_onPostWeightUnitClose);
  }

  Future<void> _onMobileMasterFetch(
    MobileMasterFetchEvent event,
    Emitter<EstablishState> emit,
  ) async {
    if (event.page == 1) {
      emit(state.copyWith(
        establishMobileMasterStatus: EstablishMobileMasterStatus.loading,
      ));
    } else {
      emit(state.copyWith(isLoadMore: true));
    }

    try {
      final body = EstablishWeightReq(
        startDate: event.startDate,
        endDate: event.endDate,
        page: event.page,
        pageSize: event.pageSize,
        isOpen: '1',
      );

      final response = await establishRepo.getMobileMaster(body.toJson());

      if (response.statusCode >= 200 && response.statusCode < 400) {
        final List resultList = response.data["data"];
        final result =
            resultList.map((e) => MobileMasterModel.fromJson(e)).toList();
        final pagination =
            EstablishWeightPaginationRes.fromJson(response.data["meta"]);

        final updatedList =
            event.page == 1 ? result : [...?state.mobileMasterList, ...result];

        emit(state.copyWith(
          establishMobileMasterStatus: EstablishMobileMasterStatus.success,
          mobileMasterList: updatedList,
          establishMobileMasterPagination: pagination,
          isLoadMore: false,
        ));
      } else {
        emit(state.copyWith(
          establishMobileMasterStatus: EstablishMobileMasterStatus.error,
          establishMobileMasterError: response.error ?? 'เกิดข้อผิดพลาด',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        establishMobileMasterStatus: EstablishMobileMasterStatus.error,
        establishMobileMasterError: e.toString(),
      ));
    }
  }

  Future<void> _onMobileMasterDepartmentFetch(
    MobileMasterDepartmentFetchEvent event,
    Emitter<EstablishState> emit,
  ) async {
    emit(state.copyWith(
      establishMobileMasterDepartmentStatus:
          EstablishMobileMasterDepartmentStatus.loading,
      mobileMasterDepartmentData: MobileMasterDepartmentModel.empty(),
    ));

    try {
      final response =
          await establishRepo.getMobileMasterDepartment(tid: event.tid);

      if (response.statusCode >= 200 && response.statusCode < 400) {
        final result =
            MobileMasterDepartmentModel.fromJson(response.data['data']);

        emit(state.copyWith(
          establishMobileMasterDepartmentStatus:
              EstablishMobileMasterDepartmentStatus.success,
          mobileMasterDepartmentData: result,
        ));
      } else {
        emit(state.copyWith(
          establishMobileMasterDepartmentStatus:
              EstablishMobileMasterDepartmentStatus.error,
          establishMobileMasterDepartmentError:
              response.error ?? 'เกิดข้อผิดพลาด',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        establishMobileMasterDepartmentStatus:
            EstablishMobileMasterDepartmentStatus.error,
        establishMobileMasterDepartmentError: e.toString(),
      ));
    }
  }

  Future<void> _onCreateUnitWeight(
    CreateUnitWeight event,
    Emitter<EstablishState> emit,
  ) async {
    try {
      emit(
          state.copyWith(createEstablishStatus: CreateEstablishStatus.loading));

      final body = json.encode(event.payload.toJson());
      final response = await establishRepo.postUnitWeight(body);

      if (response.statusCode >= 200 && response.statusCode < 400) {
        final result = EstablishAddUnitRes.fromJson(response.data['data']);

        final storage = LocalStorage();
        await storage.setValueString(
          KeyLocalStorage.weightUnitId,
          result.tId.toString(),
        );

        await establishRepo.postUnitWeightImage(
          result.tId.toString(),
          event.payload.file1,
          event.payload.file2,
        );

        emit(state.copyWith(
          createEstablishStatus: CreateEstablishStatus.success,
          createEstablishUnit: result,
        ));
      } else {
        emit(state.copyWith(
          createEstablishStatus: CreateEstablishStatus.error,
          createEstablishError: response.error ?? 'เกิดข้อผิดพลาด',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        createEstablishStatus: CreateEstablishStatus.error,
        createEstablishError: e.toString(),
      ));
    }
  }

  void _onResetCreateUnitWeight(
    ResetCreateUnitWeight event,
    Emitter<EstablishState> emit,
  ) {
    emit(state.copyWith(
      createEstablishStatus: CreateEstablishStatus.initial,
      createEstablishError: '',
    ));
  }

  Future<void> _onGetCarDetail(
    GetCarDetailEvent event,
    Emitter<EstablishState> emit,
  ) async {
    try {
      emit(state.copyWith(carDetailStatus: CarInUnitDetailStatus.loading));

      final response = await establishRepo.getMobileCarDetail(event.payload);

      if (response.statusCode >= 200 && response.statusCode < 400) {
        final List dataList = response.data['data'];

        if (dataList.isEmpty) {
          emit(state.copyWith(
            carDetailStatus: CarInUnitDetailStatus.error,
            carDetailError: 'ไม่พบข้อมูลรถ',
          ));
          return;
        }

        final result = CarDetailModelRes.fromJson(dataList[0]);

        emit(state.copyWith(
          carDetailStatus: CarInUnitDetailStatus.success,
          carDetail: result,
        ));
      } else {
        emit(state.copyWith(
          carDetailStatus: CarInUnitDetailStatus.error,
          carDetailError: response.error ?? 'เกิดข้อผิดพลาด',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        carDetailStatus: CarInUnitDetailStatus.error,
        carDetailError: e.toString(),
      ));
    }
  }

  Future<void> _onGetCarDetailImage(
    GetCarDetailImageEvent event,
    Emitter<EstablishState> emit,
  ) async {
    try {
      emit(state.copyWith(
        carInUnitDetailImageStatus: CarInUnitDetailImageStatus.loading,
      ));

      final response = await establishRepo.getImageCar(event.tId, event.tdId);

      if (response.statusCode >= 200 && response.statusCode < 400) {
        final List dataList = response.data['data'];

        if (dataList.isEmpty) {
          emit(state.copyWith(
            carInUnitDetailImageStatus: CarInUnitDetailImageStatus.success,
            carDetailImage: null,
          ));
          return;
        }

        final result = CarDetailModelImageRes.fromJson(dataList[0]);

        emit(state.copyWith(
          carInUnitDetailImageStatus: CarInUnitDetailImageStatus.success,
          carDetailImage: result,
        ));
      } else {
        emit(state.copyWith(
          carInUnitDetailImageStatus: CarInUnitDetailImageStatus.error,
          carDetailImageError: response.error ?? 'เกิดข้อผิดพลาด',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        carInUnitDetailImageStatus: CarInUnitDetailImageStatus.error,
        carDetailImageError: e.toString(),
      ));
    }
  }

  Future<void> _onPostJoinWeightUnit(
    PostJoinWeightUnit event,
    Emitter<EstablishState> emit,
  ) async {
    try {
      emit(state.copyWith(weightUnitJoinStatus: WeightUnitJoinStatus.loading));

      final body = json.encode(event.payload.toJson());
      final response = await establishRepo.postJoinWeightUnit(body);

      if (response.statusCode >= 200 && response.statusCode < 400) {
        emit(state.copyWith(
          weightUnitJoinStatus: WeightUnitJoinStatus.success,
          weightUnitJoinScreen: event.weightUnitJoinScreen,
        ));
      } else {
        emit(state.copyWith(
          weightUnitJoinStatus: WeightUnitJoinStatus.error,
          weightUnitJoinError: response.error ?? 'เกิดข้อผิดพลาด',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        weightUnitJoinStatus: WeightUnitJoinStatus.error,
        weightUnitJoinError: e.toString(),
      ));
    }
  }

  Future<void> _onDeleteJoinWeightUnit(
    DeleteJoinWeightUnit event,
    Emitter<EstablishState> emit,
  ) async {
    try {
      emit(state.copyWith(
        weightUnitUnJoinStatus: WeightUnitUnJoinStatus.loading,
      ));

      final response =
          await establishRepo.deleteJoinWeightUnit(event.tId, event.username);

      if (response.statusCode >= 200 && response.statusCode < 400) {
        emit(state.copyWith(
          weightUnitUnJoinStatus: WeightUnitUnJoinStatus.success,
        ));
      } else {
        emit(state.copyWith(
          weightUnitUnJoinStatus: WeightUnitUnJoinStatus.error,
          weightUnitUnJoinError: response.error ?? 'เกิดข้อผิดพลาด',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        weightUnitUnJoinStatus: WeightUnitUnJoinStatus.error,
        weightUnitUnJoinError: e.toString(),
      ));
    }
  }

  Future<void> _onGetWeightUnitsIsJoin(
    GetWeightUnitsIsJoinEvent event,
    Emitter<EstablishState> emit,
  ) async {
    try {
      emit(state.copyWith(
        weightUnitIsJoinStatus: WeightUnitIsJoinStatus.loading,
      ));

      final body = EstablishWeightReq(
        startDate: event.startDate,
        endDate: event.endDate,
        page: event.page,
        pageSize: event.pageSize,
        isJoin: '1',
      );

      final response = await establishRepo.getMobileMaster(body.toJson());

      if (response.statusCode >= 200 && response.statusCode < 400) {
        final storage = LocalStorage();
        final List result = response.data['data'];

        if (result.isEmpty) {
          await storage.setValueString(KeyLocalStorage.weightUnitId, '');
          emit(state.copyWith(
            weightUnitIsJoin: MobileMasterModel.empty(),
            weightUnitIsJoinStatus: WeightUnitIsJoinStatus.success,
          ));
        } else {
          final item = MobileMasterModel.fromJson(result[0]);
          await storage.setValueString(
            KeyLocalStorage.weightUnitId,
            item.tID.toString(),
          );
          emit(state.copyWith(
            weightUnitIsJoin: item,
            weightUnitIsJoinStatus: WeightUnitIsJoinStatus.success,
          ));
        }
      } else {
        emit(state.copyWith(
          weightUnitIsJoinStatus: WeightUnitIsJoinStatus.error,
          weightUnitsError: response.error ?? 'เกิดข้อผิดพลาด',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        weightUnitIsJoinStatus: WeightUnitIsJoinStatus.error,
        weightUnitsError: e.toString(),
      ));
    }
  }

  void _onClearPostJoinWeightUnit(
    ClearPostJoinWeightUnit event,
    Emitter<EstablishState> emit,
  ) {
    emit(state.copyWith(
      weightUnitJoinStatus: WeightUnitJoinStatus.initial,
      weightUnitJoinError: '',
      weightUnistLeaveJoinStatus: WeightUnistLeaveJoinStatus.initial,
      weightUnistLeaveJoinError: '',
      weightUnistCloseStatus: WeightUnistCloseStatus.initial,
      weightUnistCloseError: '',
    ));
  }

  Future<void> _onDeleteWeightUnitLeave(
    DeleteWeightUnitLeaveEvent event,
    Emitter<EstablishState> emit,
  ) async {
    try {
      emit(state.copyWith(
        weightUnistLeaveJoinStatus: WeightUnistLeaveJoinStatus.loading,
      ));

      final response =
          await establishRepo.deleteJoinWeightUnit(event.tId, event.username);

      if (response.statusCode >= 200 && response.statusCode < 400) {
        emit(state.copyWith(
          weightUnistLeaveJoinStatus: WeightUnistLeaveJoinStatus.success,
        ));
      } else {
        emit(state.copyWith(
          weightUnistLeaveJoinStatus: WeightUnistLeaveJoinStatus.error,
          weightUnistLeaveJoinError: response.error ?? 'เกิดข้อผิดพลาด',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        weightUnistLeaveJoinStatus: WeightUnistLeaveJoinStatus.error,
        weightUnistLeaveJoinError: e.toString(),
      ));
    }
  }

  Future<void> _onPostWeightUnitClose(
    PostWeightUnitCloseEvent event,
    Emitter<EstablishState> emit,
  ) async {
    try {
      emit(state.copyWith(
        weightUnistCloseStatus: WeightUnistCloseStatus.loading,
      ));

      final response = await establishRepo.postCloseWeightUnit(event.tId);

      if (response.statusCode >= 200 && response.statusCode < 400) {
        emit(state.copyWith(
          weightUnistCloseStatus: WeightUnistCloseStatus.success,
        ));
      } else {
        emit(state.copyWith(
          weightUnistCloseStatus: WeightUnistCloseStatus.error,
          weightUnistCloseError: response.error ?? 'เกิดข้อผิดพลาด',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        weightUnistCloseStatus: WeightUnistCloseStatus.error,
        weightUnistCloseError: e.toString(),
      ));
    }
  }
}
