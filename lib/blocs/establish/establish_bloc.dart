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
  EstablishBloc() : super(EstablishState()) {
    on<MobileMasterFetchEvent>((event, emit) async {
      if (event.page == 1) {
        emit(state.copyWith(
            establishMobileMasterStatus: EstablishMobileMasterStatus.loading));
      } else {
        emit(state.copyWith(isLoadMore: true));
      }
      try {
        var body = EstablishWeightReq(
          startDate: event.start_date,
          endDate: event.end_date,
          page: event.page,
          pageSize: event.pageSize,
          isOpen: '1',
        );
        final response = await establishRepo.getMobileMaster(body.toJson());
        if (response.statusCode >= 200 && response.statusCode < 400) {
          final List resultList = response.data["data"];
          var result =
              resultList.map((e) => MobileMasterModel.fromJson(e)).toList();
          var pagination =
              EstablishWeightPaginationRes.fromJson(response.data["meta"]);

          emit(state.copyWith(establishMobileMasterPagination: pagination));

          if (event.page != 1) {
            state.mobile_master_list!.addAll(result);

            emit(state.copyWith(
                establishMobileMasterStatus:
                    EstablishMobileMasterStatus.success,
                mobile_master_list: state.mobile_master_list,
                isLoadMore: false));
          } else {
            emit(state.copyWith(
                establishMobileMasterStatus:
                    EstablishMobileMasterStatus.success,
                mobile_master_list: result));
          }

          return;
        }

        emit(state.copyWith(
            establishMobileMasterStatus: EstablishMobileMasterStatus.error,
            establishMobileMasterError: response.error ?? 'เกิดข้อผิดพลาด'));
      } catch (e) {
        emit(state.copyWith(
            establishMobileMasterStatus: EstablishMobileMasterStatus.error,
            establishMobileMasterError: e.toString()));
      }
    });

    on<MobileMasterDepartmentFetchEvent>((event, emit) async {
      emit(state.copyWith(
          establishMobileMasterDepartmentStatus:
              EstablishMobileMasterDepartmentStatus.loading,
          mobileMasterDepartmentData: MobileMasterDepartmentModel.empty()));

      try {
        final response =
            await establishRepo.getMobileMasterDepartment(tid: event.tid);
        if (response.statusCode >= 200 && response.statusCode < 400) {
          var result =
              MobileMasterDepartmentModel.fromJson(response.data['data']);
          emit(state.copyWith(
              establishMobileMasterDepartmentStatus:
                  EstablishMobileMasterDepartmentStatus.success,
              mobileMasterDepartmentData: result));
          return;
        }

        emit(state.copyWith(
            establishMobileMasterDepartmentStatus:
                EstablishMobileMasterDepartmentStatus.error,
            establishMobileMasterDepartmentError:
                response.error ?? 'เกิดข้อผิดพลาด'));
        return;
      } catch (e) {
        emit(state.copyWith(
            establishMobileMasterDepartmentStatus:
                EstablishMobileMasterDepartmentStatus.error,
            establishMobileMasterDepartmentError: e.toString()));
        return;
      }
    });

    on<MobileCarFetchEvent>((event, emit) async {
      // Commented out - not used
    });

    on<CreateUnitWeight>((event, emit) async {
      try {
        emit(state.copyWith(
            createEstablishStatus: CreateEstablishStatus.loading));

        var body = json.encode(event.payload.toJson());
        final response = await establishRepo.postUnitWeight(body);

        if (response.statusCode >= 200 && response.statusCode < 400) {
          var result = EstablishAddUnitRes.fromJson(response.data['data']);

          final LocalStorage storage = LocalStorage();
          await storage.setValueString(
              KeyLocalStorage.weightUnitId, result.tId.toString());

          final responseImage = await establishRepo.postUnitWeightImage(
              result.tId.toString(), event.payload.file1, event.payload.file2);
          emit(state.copyWith(
              createEstablishStatus: CreateEstablishStatus.success,
              createEstablishUnit: result));
          return;
        }

        emit(state.copyWith(
            createEstablishStatus: CreateEstablishStatus.error,
            createEstablishError: response.error ?? 'เกิดข้อผิดพลาด'));
      } catch (e) {
        emit(state.copyWith(
            createEstablishStatus: CreateEstablishStatus.error,
            createEstablishError: e.toString()));
      }
    });

    on<ResetCreateUnitWeight>((event, emit) async {
      emit(state.copyWith(
          createEstablishStatus: CreateEstablishStatus.initial,
          createEstablishError: ''));
    });

    on<GetCarDetailEvent>((event, emit) async {
      try {
        emit(state.copyWith(carDetailStatus: CarInUnitDetailStatus.loading));

        final response = await establishRepo.getMobileCarDetail(event.paylaod);

        if (response.statusCode >= 200 && response.statusCode < 400) {
          final List dataList = response.data['data'];

          if (dataList.isEmpty) {
            emit(state.copyWith(
                carDetailStatus: CarInUnitDetailStatus.error,
                carDetailError: 'ไม่พบข้อมูลรถ'));
            return;
          }

          var result = CarDetailModelRes.fromJson(dataList[0]);

          emit(state.copyWith(
              carDetailStatus: CarInUnitDetailStatus.success,
              carDetail: result));
          return;
        }

        emit(state.copyWith(
            carDetailStatus: CarInUnitDetailStatus.error,
            carDetailError: response.error ?? 'เกิดข้อผิดพลาด'));
      } catch (e) {
        emit(state.copyWith(
            carDetailStatus: CarInUnitDetailStatus.error,
            carDetailError: e.toString()));
        return;
      }
    });

    on<GetCarDetailImageEvent>((event, emit) async {
      try {
        emit(state.copyWith(
            carInUnitDetailImageStatus: CarInUnitDetailImageStatus.loading));

        final response = await establishRepo.getImageCar(event.tId, event.tdId);

        if (response.statusCode >= 200 && response.statusCode < 400) {
          final List dataList = response.data['data'];

          if (dataList.isEmpty) {
            emit(state.copyWith(
                carInUnitDetailImageStatus: CarInUnitDetailImageStatus.success,
                carDatailImage: null));
            return;
          }

          var result = CarDetailModelImageRes.fromJson(dataList[0]);

          emit(state.copyWith(
              carInUnitDetailImageStatus: CarInUnitDetailImageStatus.success,
              carDatailImage: result));
          return;
        }

        emit(state.copyWith(
            carInUnitDetailImageStatus: CarInUnitDetailImageStatus.error,
            carDatailImageError: response.error ?? 'เกิดข้อผิดพลาด'));
      } catch (e) {
        emit(state.copyWith(
            carInUnitDetailImageStatus: CarInUnitDetailImageStatus.error,
            carDatailImageError: e.toString()));
        return;
      }
    });

    on<PostJoinWeightUnit>((event, emit) async {
      try {
        emit(
            state.copyWith(weightUnitJoinStatus: WeightUnitJoinStatus.loading));

        var body = json.encode(event.payload.toJson());
        final response = await establishRepo.postJoinWeightUnit(body);

        if (response.statusCode >= 200 && response.statusCode < 400) {
          emit(state.copyWith(
              weightUnitJoinStatus: WeightUnitJoinStatus.success,
              weightUnitJoinScreen: event.weightUnitJoinScreen));

          return;
        }

        emit(state.copyWith(
            weightUnitJoinStatus: WeightUnitJoinStatus.error,
            weightUnitJoinError: response.error ?? 'เกิดข้อผิดพลาด'));
      } catch (e) {
        emit(state.copyWith(
            weightUnitJoinStatus: WeightUnitJoinStatus.error,
            weightUnitJoinError: e.toString()));
      }
    });

    on<DeleteJoinWeightUnit>((event, emit) async {
      try {
        emit(state.copyWith(
            weightUnitUnJoinStatus: WeightUnitUnJoinStatus.loading));

        final response =
            await establishRepo.deleteJoinWeightUnit(event.tId, event.username);

        if (response.statusCode >= 200 && response.statusCode < 400) {
          emit(state.copyWith(
              weightUnitUnJoinStatus: WeightUnitUnJoinStatus.success));
          return;
        }

        emit(state.copyWith(
            weightUnitUnJoinStatus: WeightUnitUnJoinStatus.error,
            weightUnitUnJoinError: response.error ?? 'เกิดข้อผิดพลาด'));
      } catch (e) {
        emit(state.copyWith(
            weightUnitUnJoinStatus: WeightUnitUnJoinStatus.error,
            weightUnitUnJoinError: e.toString()));
      }
    });

    on<GetWeightUnitsIsJoinEvent>((event, emit) async {
      try {
        emit(state.copyWith(
            weightUnitIsJoinStatus: WeightUnitIsJoinStatus.loading));
        var body = EstablishWeightReq(
          startDate: event.start_date,
          endDate: event.end_date,
          page: event.page,
          pageSize: event.pageSize,
          isJoin: '1',
        );

        final response = await establishRepo.getMobileMaster(body.toJson());
        if (response.statusCode >= 200 && response.statusCode < 400) {
          final LocalStorage storage = LocalStorage();

          final List result = response.data['data'];

          if (result.isEmpty) {
            await storage.setValueString(KeyLocalStorage.weightUnitId, '');
            emit(state.copyWith(weightUnitIsJoin: MobileMasterModel.empty()));
          } else {
            var item = MobileMasterModel.fromJson(result[0]);
            await storage.setValueString(
                KeyLocalStorage.weightUnitId, item.tID.toString());
            emit(state.copyWith(weightUnitIsJoin: item));
          }

          emit(state.copyWith(
              weightUnitIsJoinStatus: WeightUnitIsJoinStatus.success));
          return;
        }

        emit(state.copyWith(
            weightUnitIsJoinStatus: WeightUnitIsJoinStatus.error,
            weightUnitsError: response.error ?? 'เกิดข้อผิดพลาด'));
      } catch (e) {
        emit(state.copyWith(
            weightUnitIsJoinStatus: WeightUnitIsJoinStatus.error,
            weightUnitsError: e.toString()));
      }
    });

    on<ClearPostJoinWeightUnit>((event, emit) async {
      emit(state.copyWith(
          weightUnitJoinStatus: WeightUnitJoinStatus.initial,
          weightUnitJoinError: ''));
      emit(state.copyWith(
          weightUnistLeaveJoinStatus: WeightUnistLeaveJoinStatus.initial,
          weightUnistLeaveJoinError: ''));
      emit(state.copyWith(
          weightUnistCloseStatus: WeightUnistCloseStatus.initial,
          weightUnistCloseError: ''));
    });

    on<DeleteWeightUnitLeaveEvent>((event, emit) async {
      try {
        emit(state.copyWith(
            weightUnistLeaveJoinStatus: WeightUnistLeaveJoinStatus.loading));

        final response =
            await establishRepo.deleteJoinWeightUnit(event.tId, event.username);

        if (response.statusCode >= 200 && response.statusCode < 400) {
          emit(state.copyWith(
              weightUnistLeaveJoinStatus: WeightUnistLeaveJoinStatus.success));
          return;
        }

        emit(state.copyWith(
            weightUnistLeaveJoinStatus: WeightUnistLeaveJoinStatus.error,
            weightUnistLeaveJoinError: response.error ?? 'เกิดข้อผิดพลาด'));
      } catch (e) {
        emit(state.copyWith(
            weightUnistLeaveJoinStatus: WeightUnistLeaveJoinStatus.error,
            weightUnistLeaveJoinError: e.toString()));
      }
    });

    on<PostWeightUnitCloseEvent>((event, emit) async {
      try {
        emit(state.copyWith(
            weightUnistCloseStatus: WeightUnistCloseStatus.loading));

        final response = await establishRepo.postCloseWeightUnit(event.tId);

        if (response.statusCode >= 200 && response.statusCode < 400) {
          emit(state.copyWith(
              weightUnistCloseStatus: WeightUnistCloseStatus.success));
          return;
        }

        emit(state.copyWith(
            weightUnistCloseStatus: WeightUnistCloseStatus.error,
            weightUnistCloseError: response.error ?? 'เกิดข้อผิดพลาด'));
      } catch (e) {
        emit(state.copyWith(
            weightUnistCloseStatus: WeightUnistCloseStatus.error,
            weightUnistCloseError: e.toString()));
      }
    });
  }
}
