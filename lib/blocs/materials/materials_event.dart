part of 'materials_bloc.dart';

sealed class MaterialsEvent extends Equatable {
  const MaterialsEvent();

  @override
  List<Object> get props => [];
}

final class GetMaterialsEvent extends MaterialsEvent {
  final MaterialModelReq payload;

  const GetMaterialsEvent(this.payload);

  @override
  List<Object> get props => [payload];
}

final class SelectMaterialsEvent extends MaterialsEvent {
  final MaterialModelRes payload;

  const SelectMaterialsEvent(this.payload);

  @override
  List<Object> get props => [payload];
}

final class ClearSelectMaterialsEvent extends MaterialsEvent {
  const ClearSelectMaterialsEvent();
}

final class SearchMaterialsEvent extends MaterialsEvent {
  final String payload;

  const SearchMaterialsEvent(this.payload);

  @override
  List<Object> get props => [payload];
}
