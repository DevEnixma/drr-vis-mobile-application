import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wts_bloc/data/models/master_data/province/province_master_data_res.dart';

import '../../../data/models/master_data/address/district_req.dart';
import '../../../data/models/master_data/address/districts_model.dart';
import '../../../data/models/master_data/address/sub_districts_model.dart';
import '../../../data/models/master_data/address/sub_districts_req.dart';
import '../../../data/models/master_data/province/province_req.dart';
import '../../../data/repo/repo.dart';

part 'province_master_event.dart';
part 'province_master_state.dart';

class ProvinceMasterBloc
    extends Bloc<ProvinceMasterEvent, ProvinceMasterState> {
  static const int _defaultPage = 1;
  static const int _defaultPageSize = 999;

  ProvinceMasterBloc() : super(const ProvinceMasterState()) {
    on<GetProvinceMaster>(_onGetProvinceMaster);
    on<GetDistrictMaster>(_onGetDistrictMaster);
    on<GetSubDistrictMaster>(_onGetSubDistrictMaster);
  }

  Future<void> _onGetProvinceMaster(
    GetProvinceMaster event,
    Emitter<ProvinceMasterState> emit,
  ) async {
    emit(state.copyWith(provinceMasterStatus: ProvinceMasterStatus.loading));

    try {
      final body = ProvinceModelReq(
        page: _defaultPage,
        pageSize: _defaultPageSize,
        textSearch: event.payload,
      );

      final response =
          await masterDataRepo.getProvinceMasterData(body.toJson());

      if (response.statusCode >= 200 && response.statusCode < 400) {
        final List items = response.data['data'];
        final result =
            items.map((e) => ProvinceMasterDataModel.fromJson(e)).toList();

        emit(state.copyWith(
          provinceMasterStatus: ProvinceMasterStatus.success,
          provinceMaster: result,
        ));
      } else {
        emit(state.copyWith(
          provinceMasterStatus: ProvinceMasterStatus.error,
          provinceMasterError: response.error ?? 'Unknown error',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        provinceMasterStatus: ProvinceMasterStatus.error,
        provinceMasterError: e.toString(),
      ));
    }
  }

  Future<void> _onGetDistrictMaster(
    GetDistrictMaster event,
    Emitter<ProvinceMasterState> emit,
  ) async {
    emit(state.copyWith(districtsMasterStatus: DistrictsMasterStatus.loading));

    try {
      final provinceId = int.tryParse(event.provinceId);
      if (provinceId == null) {
        emit(state.copyWith(
          districtsMasterStatus: DistrictsMasterStatus.error,
          districtsMasterError: 'Invalid province ID',
        ));
        return;
      }

      final body = DistrictsReq(
        page: _defaultPage,
        pageSize: _defaultPageSize,
        textSearch: event.payload,
        provinceId: provinceId,
      );

      final response =
          await masterDataRepo.getDistrctsMasterData(body.toJson());

      if (response.statusCode >= 200 && response.statusCode < 400) {
        final List items = response.data['data'];
        final result =
            items.map((e) => DistrictsMasterDataModel.fromJson(e)).toList();

        emit(state.copyWith(
          districtsMasterStatus: DistrictsMasterStatus.success,
          districtsMaster: result,
        ));
      } else {
        emit(state.copyWith(
          districtsMasterStatus: DistrictsMasterStatus.error,
          districtsMasterError: response.error ?? 'Unknown error',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        districtsMasterStatus: DistrictsMasterStatus.error,
        districtsMasterError: e.toString(),
      ));
    }
  }

  Future<void> _onGetSubDistrictMaster(
    GetSubDistrictMaster event,
    Emitter<ProvinceMasterState> emit,
  ) async {
    emit(state.copyWith(
        subDistrictsMasterStatus: SubDistrictsMasterStatus.loading));

    try {
      final districtId = int.tryParse(event.districtId);
      if (districtId == null) {
        emit(state.copyWith(
          subDistrictsMasterStatus: SubDistrictsMasterStatus.error,
          subDistrictsMasterError: 'Invalid district ID',
        ));
        return;
      }

      final body = SubDistrictsReq(
        page: _defaultPage,
        pageSize: _defaultPageSize,
        textSearch: event.payload,
        districtId: districtId,
      );

      final response =
          await masterDataRepo.getSubDistrctsMasterData(body.toJson());

      if (response.statusCode >= 200 && response.statusCode < 400) {
        final List items = response.data['data'];
        final result =
            items.map((e) => SubDistrictsMasterDataModel.fromJson(e)).toList();

        emit(state.copyWith(
          subDistrictsMasterStatus: SubDistrictsMasterStatus.success,
          subDistrictsMaster: result,
        ));
      } else {
        emit(state.copyWith(
          subDistrictsMasterStatus: SubDistrictsMasterStatus.error,
          subDistrictsMasterError: response.error ?? 'Unknown error',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        subDistrictsMasterStatus: SubDistrictsMasterStatus.error,
        subDistrictsMasterError: e.toString(),
      ));
    }
  }
}
