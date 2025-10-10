part of 'province_bloc.dart';

enum ProvinceStatus {
  initial,
  loading,
  success,
  error,
}

class ProvinceState extends Equatable {
  final ProvinceStatus provinceStatus;
  final List<ProvinceModelRes>? province;
  final String? provinceError;

  final ProvinceModelRes? selectProvince;
  final ProvinceModelRes? selectProvinceTail;
  final ProvinceModelRes? selectProvinceArrest;
  final ProvinceModelRes? selectProvincePolice;

  const ProvinceState({
    this.provinceStatus = ProvinceStatus.initial,
    this.province,
    this.provinceError = '',
    this.selectProvince,
    this.selectProvinceTail,
    this.selectProvinceArrest,
    this.selectProvincePolice,
  });

  ProvinceState copyWith({
    ProvinceStatus? provinceStatus,
    List<ProvinceModelRes>? province,
    String? provinceError,
    ProvinceModelRes? selectProvince,
    ProvinceModelRes? selectProvinceTail,
    ProvinceModelRes? selectProvinceArrest,
    ProvinceModelRes? selectProvincePolice,
  }) {
    return ProvinceState(
      provinceStatus: provinceStatus ?? this.provinceStatus,
      province: province ?? this.province,
      provinceError: provinceError ?? this.provinceError,
      selectProvince: selectProvince ?? this.selectProvince,
      selectProvinceTail: selectProvinceTail ?? this.selectProvinceTail,
      selectProvinceArrest: selectProvinceArrest ?? this.selectProvinceArrest,
      selectProvincePolice: selectProvincePolice ?? this.selectProvincePolice,
    );
  }

  @override
  List<Object?> get props => [
        provinceStatus,
        province,
        provinceError,
        selectProvince,
        selectProvinceTail,
        selectProvinceArrest,
        selectProvincePolice,
      ];
}
