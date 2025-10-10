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

class ProvinceMasterBloc extends Bloc<ProvinceMasterEvent, ProvinceMasterState> {
  ProvinceMasterBloc() : super(const ProvinceMasterState()) {
    on<GetProvinceMaster>((event, emit) async {
      try {
        emit(state.copyWith(provinceMasterStatus: ProvinceMasterStatus.loading));

        var body = ProvinceModelReq(
          page: 1,
          pageSize: 999,
          textSearch: event.payload,
        );

        final response = await masterDataRepo.getProvinceMasterData(body.toJson());
        if (response.statusCode >= 200 && response.statusCode < 400) {
          final List items = response.data['data'];
          var result = items.map((e) => ProvinceMasterDataModel.fromJson(e)).toList();

          emit(state.copyWith(provinceMasterStatus: ProvinceMasterStatus.success, provinceMaster: result));
          return;
        }
        emit(state.copyWith(provinceMasterStatus: ProvinceMasterStatus.error, provinceMasterError: response.error));
        return;
      } catch (e) {
        emit(state.copyWith(provinceMasterStatus: ProvinceMasterStatus.error, provinceMasterError: e.toString()));
        return;
      }
    });

    on<GetDistrictMaster>((event, emit) async {
      try {
        emit(state.copyWith(districtsMasterStatus: DistrictsMasterStatus.loading));

        var body = DistrictsReq(
          page: 1,
          pageSize: 999,
          textSearch: event.payload,
          provinceId: int.parse(event.provinceId),
        );

        final response = await masterDataRepo.getDistrctsMasterData(body.toJson());
        if (response.statusCode >= 200 && response.statusCode < 400) {
          final List items = response.data['data'];
          var result = items.map((e) => DistrictsMasterDataModel.fromJson(e)).toList();

          emit(state.copyWith(districtsMasterStatus: DistrictsMasterStatus.success, districtsMaster: result));
          return;
        }
        emit(state.copyWith(districtsMasterStatus: DistrictsMasterStatus.error, districtsMasterError: response.error));
        return;
      } catch (e) {
        emit(state.copyWith(districtsMasterStatus: DistrictsMasterStatus.error, districtsMasterError: e.toString()));
        return;
      }
    });

    on<GetSubDistrictMaster>((event, emit) async {
      try {
        emit(state.copyWith(subDistrictsMasterStatus: SubDistrictsMasterStatus.loading));

        var body = SubDistrictsReq(
          page: 1,
          pageSize: 999,
          textSearch: event.payload,
          districtId: int.parse(event.districtId),
        );

        final response = await masterDataRepo.getSubDistrctsMasterData(body.toJson());
        if (response.statusCode >= 200 && response.statusCode < 400) {
          final List items = response.data['data'];
          var result = items.map((e) => SubDistrictsMasterDataModel.fromJson(e)).toList();

          emit(state.copyWith(subDistrictsMasterStatus: SubDistrictsMasterStatus.success, subDistrictsMaster: result));
          return;
        }
        emit(state.copyWith(subDistrictsMasterStatus: SubDistrictsMasterStatus.error, subDistrictsMasterError: response.error));
        return;
      } catch (e) {
        emit(state.copyWith(subDistrictsMasterStatus: SubDistrictsMasterStatus.error, subDistrictsMasterError: e.toString()));
        return;
      }
    });
  }
}
