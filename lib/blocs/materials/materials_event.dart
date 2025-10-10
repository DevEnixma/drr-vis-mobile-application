part of 'materials_bloc.dart';

sealed class MaterialsEvent extends Equatable {
  const MaterialsEvent();

  @override
  List<Object> get props => [];
}

class GetMaterialsEvent extends MaterialsEvent {
  final MaterialModelReq payload;

  const GetMaterialsEvent(this.payload);
}

class SelectMaterialsEvent extends MaterialsEvent {
  final MaterialModelRes payload;

  const SelectMaterialsEvent(this.payload);
}

class ClearSelectMaterialsEvent extends MaterialsEvent {
  const ClearSelectMaterialsEvent();
}

class SearchMaterialsEvent extends MaterialsEvent {
  final String payload;

  const SearchMaterialsEvent(this.payload);
}
