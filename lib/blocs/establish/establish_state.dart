part of 'establish_bloc.dart';

enum EstablishMobileMasterStatus {
  initial,
  loading,
  success,
  error,
}

enum EstablishMobileMasterDepartmentStatus {
  initial,
  loading,
  success,
  error,
}

enum EstablishMobileCarStatus {
  initial,
  loading,
  success,
  error,
}

enum CreateEstablishStatus {
  initial,
  loading,
  success,
  error,
}

enum CarInUnitDetailStatus {
  initial,
  loading,
  success,
  error,
}

enum CarInUnitDetailImageStatus {
  initial,
  loading,
  success,
  error,
}

enum WeightUnitJoinStatus {
  initial,
  loading,
  success,
  error,
}

enum WeightUnitUnJoinStatus {
  initial,
  loading,
  success,
  error,
}

enum WeightUnitStatus {
  initial,
  loading,
  success,
  error,
}

enum WeightUnitIsJoinStatus {
  initial,
  loading,
  success,
  error,
}

enum WeightUnistLeaveJoinStatus {
  initial,
  loading,
  success,
  error,
}

enum WeightUnistCloseStatus {
  initial,
  loading,
  success,
  error,
}

class EstablishState extends Equatable {
  // Mobile Master
  final EstablishMobileMasterStatus establishMobileMasterStatus;
  final List<MobileMasterModel>? mobile_master_list;
  final String establishMobileMasterError;
  final bool isLoadMore;
  final EstablishWeightPaginationRes? establishMobileMasterPagination;

// Mobile Master Department
  final EstablishMobileMasterDepartmentStatus establishMobileMasterDepartmentStatus;
  final MobileMasterDepartmentModel? mobileMasterDepartmentData;
  final String establishMobileMasterDepartmentError;

// Mobile Car
  final EstablishMobileCarStatus establishMobileCarStatus;
  final List<MobileCarModel>? mobile_car_list;
  final String establishMobileCarError;
  final bool carLoadMore;
  final WeightCarPaginationRes? weightCarPagination;

  final CreateEstablishStatus? createEstablishStatus;
  final EstablishAddUnitRes? createEstablishUnit;
  final String? createEstablishError;

  final CarInUnitDetailStatus? carDetailStatus;
  final CarDetailModelRes? carDetail;
  final String? carDetailError;

  final CarInUnitDetailImageStatus? carInUnitDetailImageStatus;
  final CarDetailModelImageRes? carDatailImage;
  final String? carDatailImageError;

  final WeightUnitJoinStatus? weightUnitJoinStatus;
  final String? weightUnitJoinError;
  final String? weightUnitJoinScreen;

  final WeightUnitUnJoinStatus? weightUnitUnJoinStatus;
  final String? weightUnitUnJoinError;

  // weight unit
  final WeightUnitStatus? weightUnitsStatus;
  final List<MobileMasterModel>? weightUnits;
  final String? weightUnitsError;
  final bool? weightUnitsLoadmore;

  // weight unit
  final WeightUnitIsJoinStatus? weightUnitIsJoinStatus;
  final MobileMasterModel? weightUnitIsJoin;
  final String? weightUnitIsJoinError;

  // weight unit leave join
  final WeightUnistLeaveJoinStatus? weightUnistLeaveJoinStatus;
  final String? weightUnistLeaveJoinError;

  final WeightUnistCloseStatus? weightUnistCloseStatus;
  final String? weightUnistCloseError;

  const EstablishState({
    // Mobile Master
    this.establishMobileMasterStatus = EstablishMobileMasterStatus.initial,
    this.mobile_master_list,
    this.establishMobileMasterError = '',
    this.isLoadMore = false,
    this.establishMobileMasterPagination,

    // Mobile Master Department
    this.establishMobileMasterDepartmentStatus = EstablishMobileMasterDepartmentStatus.initial,
    this.mobileMasterDepartmentData,
    this.establishMobileMasterDepartmentError = '',

    // Mobile Car
    this.establishMobileCarStatus = EstablishMobileCarStatus.initial,
    this.mobile_car_list,
    this.establishMobileCarError = '',
    this.carLoadMore = false,
    this.weightCarPagination,
    this.createEstablishStatus = CreateEstablishStatus.initial,
    this.createEstablishUnit,
    this.createEstablishError = '',

    // car Detail
    this.carDetailStatus = CarInUnitDetailStatus.initial,
    this.carDetail,
    this.carDetailError = '',
    this.carInUnitDetailImageStatus = CarInUnitDetailImageStatus.initial,
    this.carDatailImage,
    this.carDatailImageError = '',

    // join weight unit
    this.weightUnitJoinStatus = WeightUnitJoinStatus.initial,
    this.weightUnitJoinError = '',
    this.weightUnitJoinScreen = '',
    this.weightUnitUnJoinStatus = WeightUnitUnJoinStatus.initial,
    this.weightUnitUnJoinError = '',

    // weight unit
    this.weightUnitsStatus = WeightUnitStatus.initial,
    this.weightUnits = const [],
    this.weightUnitsError = '',
    this.weightUnitsLoadmore = false,

    // weight unit is join
    this.weightUnitIsJoinStatus = WeightUnitIsJoinStatus.initial,
    this.weightUnitIsJoin,
    this.weightUnitIsJoinError = '',

    // weight unit leave join
    this.weightUnistLeaveJoinStatus = WeightUnistLeaveJoinStatus.initial,
    this.weightUnistLeaveJoinError = '',
    this.weightUnistCloseStatus = WeightUnistCloseStatus.initial,
    this.weightUnistCloseError = '',
  });

  EstablishState copyWith({
    // Mobile Master
    EstablishMobileMasterStatus? establishMobileMasterStatus,
    List<MobileMasterModel>? mobile_master_list,
    String? establishMobileMasterError,
    bool? isLoadMore,
    EstablishWeightPaginationRes? establishMobileMasterPagination,

    // Mobile Master Department
    EstablishMobileMasterDepartmentStatus? establishMobileMasterDepartmentStatus,
    MobileMasterDepartmentModel? mobileMasterDepartmentData,
    String? establishMobileMasterDepartmentError,

    // Mobile Car
    EstablishMobileCarStatus? establishMobileCarStatus,
    List<MobileCarModel>? mobile_car_list,
    String? establishMobileCarError,
    bool? carLoadMore,
    WeightCarPaginationRes? weightCarPagination,
    // Create Unit
    CreateEstablishStatus? createEstablishStatus,
    EstablishAddUnitRes? createEstablishUnit,
    String? createEstablishError,

    // car Detail
    CarInUnitDetailStatus? carDetailStatus,
    CarDetailModelRes? carDetail,
    String? carDetailError,
    CarInUnitDetailImageStatus? carInUnitDetailImageStatus,
    CarDetailModelImageRes? carDatailImage,
    String? carDatailImageError,
    WeightUnitJoinStatus? weightUnitJoinStatus,
    String? weightUnitJoinError,
    String? weightUnitJoinScreen,
    WeightUnitUnJoinStatus? weightUnitUnJoinStatus,
    String? weightUnitUnJoinError,

    // weight unit
    WeightUnitStatus? weightUnitsStatus,
    List<MobileMasterModel>? weightUnits,
    String? weightUnitsError,
    bool? weightUnitsLoadmore,

    // weight unit is join
    WeightUnitIsJoinStatus? weightUnitIsJoinStatus,
    MobileMasterModel? weightUnitIsJoin,
    String? weightUnitIsJoinError,

    // weight unit leave join
    WeightUnistLeaveJoinStatus? weightUnistLeaveJoinStatus,
    String? weightUnistLeaveJoinError,
    WeightUnistCloseStatus? weightUnistCloseStatus,
    String? weightUnistCloseError,
  }) {
    return EstablishState(
      establishMobileMasterStatus: establishMobileMasterStatus ?? this.establishMobileMasterStatus,
      mobile_master_list: mobile_master_list ?? this.mobile_master_list,
      establishMobileMasterError: establishMobileMasterError ?? this.establishMobileMasterError,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      establishMobileMasterPagination: establishMobileMasterPagination ?? this.establishMobileMasterPagination,

      // Mobile Master Department
      establishMobileMasterDepartmentStatus: establishMobileMasterDepartmentStatus ?? this.establishMobileMasterDepartmentStatus,
      mobileMasterDepartmentData: mobileMasterDepartmentData ?? this.mobileMasterDepartmentData,
      establishMobileMasterDepartmentError: establishMobileMasterDepartmentError ?? this.establishMobileMasterDepartmentError,

      // Mobile Car
      establishMobileCarStatus: establishMobileCarStatus ?? this.establishMobileCarStatus,
      mobile_car_list: mobile_car_list ?? this.mobile_car_list,
      establishMobileCarError: establishMobileCarError ?? this.establishMobileCarError,
      carLoadMore: carLoadMore ?? this.carLoadMore,
      weightCarPagination: weightCarPagination ?? this.weightCarPagination,

      createEstablishStatus: createEstablishStatus ?? this.createEstablishStatus,
      createEstablishUnit: createEstablishUnit ?? this.createEstablishUnit,
      createEstablishError: createEstablishError ?? this.createEstablishError,

      carDetailStatus: carDetailStatus ?? this.carDetailStatus,
      carDetail: carDetail ?? this.carDetail,
      carDetailError: carDetailError ?? this.carDetailError,

      carInUnitDetailImageStatus: carInUnitDetailImageStatus ?? this.carInUnitDetailImageStatus,
      carDatailImage: carDatailImage ?? this.carDatailImage,
      carDatailImageError: carDatailImageError ?? this.carDatailImageError,

      weightUnitJoinStatus: weightUnitJoinStatus ?? this.weightUnitJoinStatus,
      weightUnitJoinError: weightUnitJoinError ?? this.weightUnitJoinError,
      weightUnitJoinScreen: weightUnitJoinScreen ?? this.weightUnitJoinScreen,

      weightUnitUnJoinStatus: weightUnitUnJoinStatus ?? this.weightUnitUnJoinStatus,
      weightUnitUnJoinError: weightUnitUnJoinError ?? this.weightUnitUnJoinError,

      // weight unit
      weightUnitsStatus: weightUnitsStatus ?? this.weightUnitsStatus,
      weightUnits: weightUnits ?? this.weightUnits,
      weightUnitsError: weightUnitsError ?? this.weightUnitsError,
      weightUnitsLoadmore: weightUnitsLoadmore ?? this.weightUnitsLoadmore,

      // weight unit is join
      weightUnitIsJoinStatus: weightUnitIsJoinStatus ?? this.weightUnitIsJoinStatus,
      weightUnitIsJoin: weightUnitIsJoin ?? this.weightUnitIsJoin,
      weightUnitIsJoinError: weightUnitIsJoinError ?? this.weightUnitIsJoinError,

      // weight unit leave join
      weightUnistLeaveJoinStatus: weightUnistLeaveJoinStatus ?? this.weightUnistLeaveJoinStatus,
      weightUnistLeaveJoinError: weightUnistLeaveJoinError ?? this.weightUnistLeaveJoinError,

      weightUnistCloseStatus: weightUnistCloseStatus ?? this.weightUnistCloseStatus,
      weightUnistCloseError: weightUnistCloseError ?? this.weightUnistCloseError,
    );
  }

  @override
  List<Object?> get props => [
        // Mobile Master
        establishMobileMasterStatus,
        mobile_master_list,
        establishMobileMasterError,
        isLoadMore,
        establishMobileMasterPagination,

        // Mobile Master Department
        establishMobileMasterDepartmentStatus,
        mobileMasterDepartmentData,
        establishMobileMasterDepartmentError,

        // Mobile Car
        establishMobileCarStatus,
        mobile_car_list,
        establishMobileCarError,
        carLoadMore,
        weightCarPagination,

        createEstablishStatus,
        createEstablishUnit,
        createEstablishError,

        // car detail
        carDetailStatus,
        carDetail,
        carDetailError,

        carInUnitDetailImageStatus,
        carDatailImage,
        carDatailImageError,

        weightUnitJoinStatus,
        weightUnitJoinError,
        weightUnitJoinScreen,

        weightUnitUnJoinStatus,
        weightUnitUnJoinError,

        weightUnitsStatus,
        weightUnits,
        weightUnitsError,
        weightUnitsLoadmore,

        // weight unit is join
        weightUnitIsJoinStatus,
        weightUnitIsJoin,
        weightUnitIsJoinError,

        // weight unit leave join
        weightUnistLeaveJoinStatus,
        weightUnistLeaveJoinError,

        weightUnistCloseStatus,
        weightUnistCloseError,
      ];
}
