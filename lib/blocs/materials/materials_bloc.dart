import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/master_data/material/material_model_req.dart';
import '../../data/models/master_data/material/material_model_res.dart';
import '../../data/repo/repo.dart';

part 'materials_event.dart';
part 'materials_state.dart';

class MaterialsBloc extends Bloc<MaterialsEvent, MaterialsState> {
  MaterialsBloc() : super(const MaterialsState()) {
    on<GetMaterialsEvent>((event, emit) async {
      try {
        if (event.payload.page == 1) {
          emit(state.copyWith(materialStatus: MaterialsStatus.loading));
        } else {
          emit(state.copyWith(loadMore: true));
        }

        final response = await masterDataRepo.getMaterial(event.payload.toJson());
        if (response.statusCode >= 200 && response.statusCode < 400) {
          final List items = response.data['data'];
          var result = items.map((e) => MaterialModelRes.fromJson(e)).toList();

          if (event.payload.page != 1) {
            state.materials.addAll(result);
            emit(state.copyWith(loadMore: false));
            emit(state.copyWith(materialStatus: MaterialsStatus.success, materials: state.materials));
          } else {
            emit(state.copyWith(materialStatus: MaterialsStatus.success, materials: result));
          }

          return;
        }

        emit(state.copyWith(materialStatus: MaterialsStatus.error, materialError: response.error));
        return;
      } catch (e) {
        emit(state.copyWith(materialStatus: MaterialsStatus.error, materialError: e.toString()));
        return;
      }
    });

    on<SelectMaterialsEvent>((event, emit) async {
      emit(state.copyWith(material: event.payload));
    });

    on<ClearSelectMaterialsEvent>((event, emit) async {
      emit(state.copyWith(material: MaterialModelRes.empty()));
    });

    on<SearchMaterialsEvent>((event, emit) async {
      try {
        List<MaterialModelRes>? newProvince = [];

        state.materials.map((item) {
          if (item.goodsName!.contains(event.payload)) {
            newProvince.add(item);
          }
          return item;
        }).toList();

        emit(state.copyWith(materials: newProvince));
      } catch (e) {}
    });
  }
}
