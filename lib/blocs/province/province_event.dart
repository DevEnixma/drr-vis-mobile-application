part of 'province_bloc.dart';

sealed class ProvinceEvent extends Equatable {
  const ProvinceEvent();

  @override
  List<Object> get props => [];
}

class GetProvince extends ProvinceEvent {
  final String payload;

  const GetProvince(this.payload);
}

class SelectProvince extends ProvinceEvent {
  final ProvinceModelRes payload;

  const SelectProvince(this.payload);
}

class SelectProvinceTail extends ProvinceEvent {
  final ProvinceModelRes payload;

  const SelectProvinceTail(this.payload);
}

class ClearSelectProvince extends ProvinceEvent {
  const ClearSelectProvince();
}

class ClearSelectProvinceTail extends ProvinceEvent {
  const ClearSelectProvinceTail();
}

class SelectProvinceArrest extends ProvinceEvent {
  final ProvinceModelRes payload;

  const SelectProvinceArrest(this.payload);
}

class SelectProvincePolice extends ProvinceEvent {
  final ProvinceModelRes payload;

  const SelectProvincePolice(this.payload);
}
