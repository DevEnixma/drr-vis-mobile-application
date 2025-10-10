part of 'weight_unit_bloc.dart';

enum WeightUnitStatus {
  initial,
  loading,
  success,
  error,
}

enum WeightUnitDetailStatus {
  initial,
  loading,
  success,
  error,
}

enum WeightUnitCarsStatus {
  initial,
  loading,
  success,
  error,
}

class WeightUnitState extends Equatable {
  // weight unit
  final WeightUnitStatus? weightUnitsStatus;
  final List<MobileMasterModel>? weightUnits;
  final String? weightUnitsError;
  final bool? weightUnitsLoadmore;
  // weight unit detail
  final WeightUnitDetailStatus? weightUnitDetailStatus;
  final MobileMasterDepartmentModel? weightUnitDetail;
  final String? weightUnitDetailError;

  // weight unit car
  final WeightUnitCarsStatus? weightUnitCarsStatus;
  final List<MobileCarModel>? weightUnitsCars;
  final String? weightUnitsCarsError;
  final bool? weightUnitsCarsLoadMore;
  final String? weightUnitCarsTotal;

  const WeightUnitState({
    // weight unit
    this.weightUnitsStatus = WeightUnitStatus.initial,
    this.weightUnits = const [],
    this.weightUnitsError = '',
    this.weightUnitsLoadmore = false,

    // weight unit detail
    this.weightUnitDetailStatus = WeightUnitDetailStatus.initial,
    this.weightUnitDetail,
    this.weightUnitDetailError = '',

    // weight unit car
    this.weightUnitCarsStatus = WeightUnitCarsStatus.initial,
    this.weightUnitsCars = const [],
    this.weightUnitsCarsError = '',
    this.weightUnitsCarsLoadMore = false,
    this.weightUnitCarsTotal = '',
  });

  WeightUnitState copyWith({
    // weight unit
    WeightUnitStatus? weightUnitsStatus,
    List<MobileMasterModel>? weightUnits,
    String? weightUnitsError,
    bool? weightUnitsLoadmore,
    // weight unit detail
    WeightUnitDetailStatus? weightUnitDetailStatus,
    MobileMasterDepartmentModel? weightUnitDetail,
    String? weightUnitDetailError,
    // weight unit car
    WeightUnitCarsStatus? weightUnitCarsStatus,
    List<MobileCarModel>? weightUnitsCars,
    String? weightUnitsCarsError,
    bool? weightUnitsCarsLoadMore,
    String? weightUnitCarsTotal,
  }) {
    return WeightUnitState(
      // weight unit
      weightUnitsStatus: weightUnitsStatus ?? this.weightUnitsStatus,
      weightUnits: weightUnits ?? this.weightUnits,
      weightUnitsError: weightUnitsError ?? this.weightUnitsError,
      weightUnitsLoadmore: weightUnitsLoadmore ?? this.weightUnitsLoadmore,
      // weight unit detail
      weightUnitDetailStatus: weightUnitDetailStatus ?? this.weightUnitDetailStatus,
      weightUnitDetail: weightUnitDetail ?? this.weightUnitDetail,
      weightUnitDetailError: weightUnitDetailError ?? this.weightUnitDetailError,

      // weight unit car
      weightUnitCarsStatus: weightUnitCarsStatus ?? this.weightUnitCarsStatus,
      weightUnitsCars: weightUnitsCars ?? this.weightUnitsCars,
      weightUnitsCarsError: weightUnitsCarsError ?? this.weightUnitsCarsError,
      weightUnitsCarsLoadMore: weightUnitsCarsLoadMore ?? this.weightUnitsCarsLoadMore,
      weightUnitCarsTotal: weightUnitCarsTotal ?? this.weightUnitCarsTotal,
    );
  }

  @override
  List<Object?> get props => [
        // weight unit
        weightUnitsStatus,
        weightUnits,
        weightUnitsError,
        weightUnitsLoadmore,
        // weight unit detail
        weightUnitDetailStatus,
        weightUnitDetail,
        weightUnitDetailError,
        // weight unit car
        weightUnitCarsStatus,
        weightUnitsCars,
        weightUnitsCarsError,
        weightUnitsCarsLoadMore,
        weightUnitCarsTotal,
      ];
}
