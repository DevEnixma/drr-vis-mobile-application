part of 'province_master_bloc.dart';

sealed class ProvinceMasterEvent extends Equatable {
  const ProvinceMasterEvent();

  @override
  List<Object> get props => [];
}

final class GetProvinceMaster extends ProvinceMasterEvent {
  final String payload;

  const GetProvinceMaster(this.payload);

  @override
  List<Object> get props => [payload];
}

final class GetDistrictMaster extends ProvinceMasterEvent {
  final String payload;
  final String provinceId;

  const GetDistrictMaster(this.payload, this.provinceId);

  @override
  List<Object> get props => [payload, provinceId];
}

final class GetSubDistrictMaster extends ProvinceMasterEvent {
  final String payload;
  final String districtId;

  const GetSubDistrictMaster(this.payload, this.districtId);

  @override
  List<Object> get props => [payload, districtId];
}
