import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wts_bloc/data/models/master_data/province/province_res.dart';

import '../../data/models/master_data/province/province_req.dart';
import '../../data/repo/repo.dart';

part 'province_event.dart';
part 'province_state.dart';

class ProvinceBloc extends Bloc<ProvinceEvent, ProvinceState> {
  static const int _defaultPage = 1;
  static const int _defaultPageSize = 999;

  ProvinceBloc() : super(const ProvinceState()) {
    on<GetProvince>(_onGetProvince);
    on<SelectProvince>(_onSelectProvince);
    on<SelectProvinceTail>(_onSelectProvinceTail);
    on<ClearSelectProvince>(_onClearSelectProvince);
    on<ClearSelectProvinceTail>(_onClearSelectProvinceTail);
    on<SelectProvinceArrest>(_onSelectProvinceArrest);
    on<SelectProvincePolice>(_onSelectProvincePolice);
  }

  Future<void> _onGetProvince(
    GetProvince event,
    Emitter<ProvinceState> emit,
  ) async {
    emit(state.copyWith(provinceStatus: ProvinceStatus.loading));

    try {
      final body = ProvinceModelReq(
        page: _defaultPage,
        pageSize: _defaultPageSize,
        textSearch: event.payload,
      );

      final response = await masterDataRepo.getMasterProvince(body.toJson());

      if (response.statusCode >= 200 && response.statusCode < 400) {
        final List items = response.data['data'];
        final result = items.map((e) => ProvinceModelRes.fromJson(e)).toList();

        emit(state.copyWith(
          provinceStatus: ProvinceStatus.success,
          province: result,
        ));
      } else {
        emit(state.copyWith(
          provinceStatus: ProvinceStatus.error,
          provinceError: response.error ?? 'Unknown error',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        provinceStatus: ProvinceStatus.error,
        provinceError: e.toString(),
      ));
    }
  }

  void _onSelectProvince(
    SelectProvince event,
    Emitter<ProvinceState> emit,
  ) {
    emit(state.copyWith(selectProvince: event.payload));
  }

  void _onSelectProvinceTail(
    SelectProvinceTail event,
    Emitter<ProvinceState> emit,
  ) {
    emit(state.copyWith(selectProvinceTail: event.payload));
  }

  void _onClearSelectProvince(
    ClearSelectProvince event,
    Emitter<ProvinceState> emit,
  ) {
    emit(state.copyWith(selectProvince: ProvinceModelRes.empty()));
  }

  void _onClearSelectProvinceTail(
    ClearSelectProvinceTail event,
    Emitter<ProvinceState> emit,
  ) {
    emit(state.copyWith(selectProvinceTail: ProvinceModelRes.empty()));
  }

  void _onSelectProvinceArrest(
    SelectProvinceArrest event,
    Emitter<ProvinceState> emit,
  ) {
    emit(state.copyWith(selectProvinceArrest: event.payload));
  }

  void _onSelectProvincePolice(
    SelectProvincePolice event,
    Emitter<ProvinceState> emit,
  ) {
    emit(state.copyWith(selectProvincePolice: event.payload));
  }
}
