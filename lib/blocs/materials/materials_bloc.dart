import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/master_data/material/material_model_req.dart';
import '../../data/models/master_data/material/material_model_res.dart';
import '../../data/repo/repo.dart';

part 'materials_event.dart';
part 'materials_state.dart';

class MaterialsBloc extends Bloc<MaterialsEvent, MaterialsState> {
  MaterialsBloc() : super(const MaterialsState()) {
    on<GetMaterialsEvent>(_onGetMaterials);
    on<SelectMaterialsEvent>(_onSelectMaterial);
    on<ClearSelectMaterialsEvent>(_onClearSelectMaterial);
    on<SearchMaterialsEvent>(_onSearchMaterials);
  }

  Future<void> _onGetMaterials(
    GetMaterialsEvent event,
    Emitter<MaterialsState> emit,
  ) async {
    if (event.payload.page == 1) {
      emit(state.copyWith(materialStatus: MaterialsStatus.loading));
    } else {
      emit(state.copyWith(loadMore: true));
    }

    try {
      final response = await masterDataRepo.getMaterial(event.payload.toJson());

      if (response.statusCode >= 200 && response.statusCode < 400) {
        final List items = response.data['data'];
        final result = items.map((e) => MaterialModelRes.fromJson(e)).toList();

        final updatedList =
            event.payload.page == 1 ? result : [...state.materials, ...result];

        emit(state.copyWith(
          materialStatus: MaterialsStatus.success,
          materials: updatedList,
          originalMaterials: updatedList,
          loadMore: false,
        ));
      } else {
        emit(state.copyWith(
          materialStatus: MaterialsStatus.error,
          materialError: response.error ?? 'Unknown error',
          loadMore: false,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        materialStatus: MaterialsStatus.error,
        materialError: e.toString(),
        loadMore: false,
      ));
    }
  }

  void _onSelectMaterial(
    SelectMaterialsEvent event,
    Emitter<MaterialsState> emit,
  ) {
    emit(state.copyWith(material: event.payload));
  }

  void _onClearSelectMaterial(
    ClearSelectMaterialsEvent event,
    Emitter<MaterialsState> emit,
  ) {
    emit(state.copyWith(material: MaterialModelRes.empty()));
  }

  void _onSearchMaterials(
    SearchMaterialsEvent event,
    Emitter<MaterialsState> emit,
  ) {
    try {
      final query = event.payload.toLowerCase().trim();

      if (query.isEmpty) {
        emit(state.copyWith(materials: state.originalMaterials));
        return;
      }

      final filteredList = state.originalMaterials
          .where(
              (item) => item.goodsName?.toLowerCase().contains(query) ?? false)
          .toList();

      emit(state.copyWith(materials: filteredList));
    } catch (e) {
      emit(state.copyWith(
        materialStatus: MaterialsStatus.error,
        materialError: 'Search error: ${e.toString()}',
      ));
    }
  }
}
