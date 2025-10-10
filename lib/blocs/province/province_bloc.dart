import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wts_bloc/data/models/master_data/province/province_res.dart';

import '../../data/models/master_data/province/province_req.dart';
import '../../data/repo/repo.dart';

part 'province_event.dart';
part 'province_state.dart';

class ProvinceBloc extends Bloc<ProvinceEvent, ProvinceState> {
  ProvinceBloc() : super(const ProvinceState()) {
    on<GetProvince>((event, emit) async {
      try {
        emit(state.copyWith(provinceStatus: ProvinceStatus.loading));

        var body = ProvinceModelReq(
          page: 1,
          pageSize: 999,
          textSearch: event.payload,
        );

        final response = await masterDataRepo.getMasterProvince(body.toJson());

        if (response.statusCode >= 200 && response.statusCode < 400) {
          final List items = response.data['data'];
          var result = items.map((e) => ProvinceModelRes.fromJson(e)).toList();

          emit(state.copyWith(provinceStatus: ProvinceStatus.success, province: result));
          return;
        }
        emit(state.copyWith(provinceStatus: ProvinceStatus.error, provinceError: response.error));
        return;
      } catch (e) {
        emit(state.copyWith(provinceStatus: ProvinceStatus.error, provinceError: e.toString()));
        return;
      }
    });

    on<SelectProvince>((event, emit) async {
      emit(state.copyWith(selectProvince: event.payload));
    });

    on<SelectProvinceTail>((event, emit) async {
      emit(state.copyWith(selectProvinceTail: event.payload));
    });

    on<ClearSelectProvince>((event, emit) async {
      emit(state.copyWith(selectProvince: ProvinceModelRes.empty()));
    });

    on<ClearSelectProvinceTail>((event, emit) async {
      emit(state.copyWith(selectProvinceTail: ProvinceModelRes.empty()));
    });

    on<SelectProvinceArrest>((event, emit) async {
      emit(state.copyWith(selectProvinceArrest: event.payload));
    });

    on<SelectProvincePolice>((event, emit) async {
      emit(state.copyWith(selectProvincePolice: event.payload));
    });
  }
}
