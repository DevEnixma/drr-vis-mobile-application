part of 'province_bloc.dart';

sealed class ProvinceEvent extends Equatable {
  const ProvinceEvent();

  @override
  List<Object> get props => [];
}

final class GetProvince extends ProvinceEvent {
  final String payload;

  const GetProvince(this.payload);

  @override
  List<Object> get props => [payload];
}

final class SelectProvince extends ProvinceEvent {
  final ProvinceModelRes payload;

  const SelectProvince(this.payload);

  @override
  List<Object> get props => [payload];
}

final class SelectProvinceTail extends ProvinceEvent {
  final ProvinceModelRes payload;

  const SelectProvinceTail(this.payload);

  @override
  List<Object> get props => [payload];
}

final class ClearSelectProvince extends ProvinceEvent {
  const ClearSelectProvince();
}

final class ClearSelectProvinceTail extends ProvinceEvent {
  const ClearSelectProvinceTail();
}

final class SelectProvinceArrest extends ProvinceEvent {
  final ProvinceModelRes payload;

  const SelectProvinceArrest(this.payload);

  @override
  List<Object> get props => [payload];
}

final class SelectProvincePolice extends ProvinceEvent {
  final ProvinceModelRes payload;

  const SelectProvincePolice(this.payload);

  @override
  List<Object> get props => [payload];
}
