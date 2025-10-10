part of 'province_master_bloc.dart';

sealed class ProvinceMasterEvent extends Equatable {
  const ProvinceMasterEvent();

  @override
  List<Object> get props => [];
}

class GetProvinceMaster extends ProvinceMasterEvent {
  final String payload;

  const GetProvinceMaster(this.payload);
}

class GetDistrictMaster extends ProvinceMasterEvent {
  final String payload;
  final String provinceId;

  const GetDistrictMaster(this.payload, this.provinceId);
}

class GetSubDistrictMaster extends ProvinceMasterEvent {
  final String payload;
  final String districtId;

  const GetSubDistrictMaster(this.payload, this.districtId);
}
