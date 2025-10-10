part of 'province_master_bloc.dart';

enum ProvinceMasterStatus {
  initial,
  loading,
  success,
  error,
}

enum DistrictsMasterStatus {
  initial,
  loading,
  success,
  error,
}

enum SubDistrictsMasterStatus {
  initial,
  loading,
  success,
  error,
}

class ProvinceMasterState extends Equatable {
  final ProvinceMasterStatus? provinceMasterStatus;
  final List<ProvinceMasterDataModel>? provinceMaster;
  final String? provinceMasterError;

  final DistrictsMasterStatus? districtsMasterStatus;
  final List<DistrictsMasterDataModel>? districtsMaster;
  final String? districtsMasterError;

  final SubDistrictsMasterStatus? subDistrictsMasterStatus;
  final List<SubDistrictsMasterDataModel>? subDistrictsMaster;
  final String? subDistrictsMasterError;

  const ProvinceMasterState({
    this.provinceMasterStatus = ProvinceMasterStatus.initial,
    this.provinceMaster = const [],
    this.provinceMasterError = '',
    this.districtsMasterStatus = DistrictsMasterStatus.initial,
    this.districtsMaster = const [],
    this.districtsMasterError = '',
    this.subDistrictsMasterStatus = SubDistrictsMasterStatus.initial,
    this.subDistrictsMaster = const [],
    this.subDistrictsMasterError = '',
  });

  ProvinceMasterState copyWith({
    ProvinceMasterStatus? provinceMasterStatus,
    List<ProvinceMasterDataModel>? provinceMaster,
    String? provinceMasterError,
    DistrictsMasterStatus? districtsMasterStatus,
    List<DistrictsMasterDataModel>? districtsMaster,
    String? districtsMasterError,
    SubDistrictsMasterStatus? subDistrictsMasterStatus,
    List<SubDistrictsMasterDataModel>? subDistrictsMaster,
    String? subDistrictsMasterError,
  }) {
    return ProvinceMasterState(
      provinceMasterStatus: provinceMasterStatus ?? this.provinceMasterStatus,
      provinceMaster: provinceMaster ?? this.provinceMaster,
      provinceMasterError: provinceMasterError ?? this.provinceMasterError,
      districtsMasterStatus: districtsMasterStatus ?? this.districtsMasterStatus,
      districtsMaster: districtsMaster ?? this.districtsMaster,
      districtsMasterError: districtsMasterError ?? this.districtsMasterError,
      subDistrictsMasterStatus: subDistrictsMasterStatus ?? this.subDistrictsMasterStatus,
      subDistrictsMaster: subDistrictsMaster ?? this.subDistrictsMaster,
      subDistrictsMasterError: subDistrictsMasterError ?? this.subDistrictsMasterError,
    );
  }

  @override
  List<Object?> get props => [
        provinceMasterStatus,
        provinceMaster,
        provinceMasterError,
        districtsMasterStatus,
        districtsMaster,
        districtsMasterError,
        subDistrictsMasterStatus,
        subDistrictsMaster,
        subDistrictsMasterError,
      ];
}
