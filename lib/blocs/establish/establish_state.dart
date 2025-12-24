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
  final EstablishMobileMasterStatus establishMobileMasterStatus;
  final List<MobileMasterModel>? mobileMasterList;
  final String establishMobileMasterError;
  final bool isLoadMore;
  final EstablishWeightPaginationRes? establishMobileMasterPagination;

  final EstablishMobileMasterDepartmentStatus
      establishMobileMasterDepartmentStatus;
  final MobileMasterDepartmentModel? mobileMasterDepartmentData;
  final String establishMobileMasterDepartmentError;

  final EstablishMobileCarStatus establishMobileCarStatus;
  final List<MobileCarModel>? mobileCarList;
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
  final CarDetailModelImageRes? carDetailImage;
  final String? carDetailImageError;

  final WeightUnitJoinStatus? weightUnitJoinStatus;
  final String? weightUnitJoinError;
  final String? weightUnitJoinScreen;

  final WeightUnitUnJoinStatus? weightUnitUnJoinStatus;
  final String? weightUnitUnJoinError;

  final WeightUnitStatus? weightUnitsStatus;
  final List<MobileMasterModel>? weightUnits;
  final String? weightUnitsError;
  final bool? weightUnitsLoadmore;

  final WeightUnitIsJoinStatus? weightUnitIsJoinStatus;
  final MobileMasterModel? weightUnitIsJoin;
  final String? weightUnitIsJoinError;

  final WeightUnistLeaveJoinStatus? weightUnistLeaveJoinStatus;
  final String? weightUnistLeaveJoinError;

  final WeightUnistCloseStatus? weightUnistCloseStatus;
  final String? weightUnistCloseError;

  const EstablishState({
    this.establishMobileMasterStatus = EstablishMobileMasterStatus.initial,
    this.mobileMasterList,
    this.establishMobileMasterError = '',
    this.isLoadMore = false,
    this.establishMobileMasterPagination,
    this.establishMobileMasterDepartmentStatus =
        EstablishMobileMasterDepartmentStatus.initial,
    this.mobileMasterDepartmentData,
    this.establishMobileMasterDepartmentError = '',
    this.establishMobileCarStatus = EstablishMobileCarStatus.initial,
    this.mobileCarList,
    this.establishMobileCarError = '',
    this.carLoadMore = false,
    this.weightCarPagination,
    this.createEstablishStatus = CreateEstablishStatus.initial,
    this.createEstablishUnit,
    this.createEstablishError = '',
    this.carDetailStatus = CarInUnitDetailStatus.initial,
    this.carDetail,
    this.carDetailError = '',
    this.carInUnitDetailImageStatus = CarInUnitDetailImageStatus.initial,
    this.carDetailImage,
    this.carDetailImageError = '',
    this.weightUnitJoinStatus = WeightUnitJoinStatus.initial,
    this.weightUnitJoinError = '',
    this.weightUnitJoinScreen = '',
    this.weightUnitUnJoinStatus = WeightUnitUnJoinStatus.initial,
    this.weightUnitUnJoinError = '',
    this.weightUnitsStatus = WeightUnitStatus.initial,
    this.weightUnits = const [],
    this.weightUnitsError = '',
    this.weightUnitsLoadmore = false,
    this.weightUnitIsJoinStatus = WeightUnitIsJoinStatus.initial,
    this.weightUnitIsJoin,
    this.weightUnitIsJoinError = '',
    this.weightUnistLeaveJoinStatus = WeightUnistLeaveJoinStatus.initial,
    this.weightUnistLeaveJoinError = '',
    this.weightUnistCloseStatus = WeightUnistCloseStatus.initial,
    this.weightUnistCloseError = '',
  });

  EstablishState copyWith({
    EstablishMobileMasterStatus? establishMobileMasterStatus,
    List<MobileMasterModel>? mobileMasterList,
    String? establishMobileMasterError,
    bool? isLoadMore,
    EstablishWeightPaginationRes? establishMobileMasterPagination,
    EstablishMobileMasterDepartmentStatus?
        establishMobileMasterDepartmentStatus,
    MobileMasterDepartmentModel? mobileMasterDepartmentData,
    String? establishMobileMasterDepartmentError,
    EstablishMobileCarStatus? establishMobileCarStatus,
    List<MobileCarModel>? mobileCarList,
    String? establishMobileCarError,
    bool? carLoadMore,
    WeightCarPaginationRes? weightCarPagination,
    CreateEstablishStatus? createEstablishStatus,
    EstablishAddUnitRes? createEstablishUnit,
    String? createEstablishError,
    CarInUnitDetailStatus? carDetailStatus,
    CarDetailModelRes? carDetail,
    String? carDetailError,
    CarInUnitDetailImageStatus? carInUnitDetailImageStatus,
    CarDetailModelImageRes? carDetailImage,
    String? carDetailImageError,
    WeightUnitJoinStatus? weightUnitJoinStatus,
    String? weightUnitJoinError,
    String? weightUnitJoinScreen,
    WeightUnitUnJoinStatus? weightUnitUnJoinStatus,
    String? weightUnitUnJoinError,
    WeightUnitStatus? weightUnitsStatus,
    List<MobileMasterModel>? weightUnits,
    String? weightUnitsError,
    bool? weightUnitsLoadmore,
    WeightUnitIsJoinStatus? weightUnitIsJoinStatus,
    MobileMasterModel? weightUnitIsJoin,
    String? weightUnitIsJoinError,
    WeightUnistLeaveJoinStatus? weightUnistLeaveJoinStatus,
    String? weightUnistLeaveJoinError,
    WeightUnistCloseStatus? weightUnistCloseStatus,
    String? weightUnistCloseError,
  }) {
    return EstablishState(
      establishMobileMasterStatus:
          establishMobileMasterStatus ?? this.establishMobileMasterStatus,
      mobileMasterList: mobileMasterList ?? this.mobileMasterList,
      establishMobileMasterError:
          establishMobileMasterError ?? this.establishMobileMasterError,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      establishMobileMasterPagination: establishMobileMasterPagination ??
          this.establishMobileMasterPagination,
      establishMobileMasterDepartmentStatus:
          establishMobileMasterDepartmentStatus ??
              this.establishMobileMasterDepartmentStatus,
      mobileMasterDepartmentData:
          mobileMasterDepartmentData ?? this.mobileMasterDepartmentData,
      establishMobileMasterDepartmentError:
          establishMobileMasterDepartmentError ??
              this.establishMobileMasterDepartmentError,
      establishMobileCarStatus:
          establishMobileCarStatus ?? this.establishMobileCarStatus,
      mobileCarList: mobileCarList ?? this.mobileCarList,
      establishMobileCarError:
          establishMobileCarError ?? this.establishMobileCarError,
      carLoadMore: carLoadMore ?? this.carLoadMore,
      weightCarPagination: weightCarPagination ?? this.weightCarPagination,
      createEstablishStatus:
          createEstablishStatus ?? this.createEstablishStatus,
      createEstablishUnit: createEstablishUnit ?? this.createEstablishUnit,
      createEstablishError: createEstablishError ?? this.createEstablishError,
      carDetailStatus: carDetailStatus ?? this.carDetailStatus,
      carDetail: carDetail ?? this.carDetail,
      carDetailError: carDetailError ?? this.carDetailError,
      carInUnitDetailImageStatus:
          carInUnitDetailImageStatus ?? this.carInUnitDetailImageStatus,
      carDetailImage: carDetailImage ?? this.carDetailImage,
      carDetailImageError: carDetailImageError ?? this.carDetailImageError,
      weightUnitJoinStatus: weightUnitJoinStatus ?? this.weightUnitJoinStatus,
      weightUnitJoinError: weightUnitJoinError ?? this.weightUnitJoinError,
      weightUnitJoinScreen: weightUnitJoinScreen ?? this.weightUnitJoinScreen,
      weightUnitUnJoinStatus:
          weightUnitUnJoinStatus ?? this.weightUnitUnJoinStatus,
      weightUnitUnJoinError:
          weightUnitUnJoinError ?? this.weightUnitUnJoinError,
      weightUnitsStatus: weightUnitsStatus ?? this.weightUnitsStatus,
      weightUnits: weightUnits ?? this.weightUnits,
      weightUnitsError: weightUnitsError ?? this.weightUnitsError,
      weightUnitsLoadmore: weightUnitsLoadmore ?? this.weightUnitsLoadmore,
      weightUnitIsJoinStatus:
          weightUnitIsJoinStatus ?? this.weightUnitIsJoinStatus,
      weightUnitIsJoin: weightUnitIsJoin ?? this.weightUnitIsJoin,
      weightUnitIsJoinError:
          weightUnitIsJoinError ?? this.weightUnitIsJoinError,
      weightUnistLeaveJoinStatus:
          weightUnistLeaveJoinStatus ?? this.weightUnistLeaveJoinStatus,
      weightUnistLeaveJoinError:
          weightUnistLeaveJoinError ?? this.weightUnistLeaveJoinError,
      weightUnistCloseStatus:
          weightUnistCloseStatus ?? this.weightUnistCloseStatus,
      weightUnistCloseError:
          weightUnistCloseError ?? this.weightUnistCloseError,
    );
  }

  @override
  List<Object?> get props => [
        establishMobileMasterStatus,
        mobileMasterList,
        establishMobileMasterError,
        isLoadMore,
        establishMobileMasterPagination,
        establishMobileMasterDepartmentStatus,
        mobileMasterDepartmentData,
        establishMobileMasterDepartmentError,
        establishMobileCarStatus,
        mobileCarList,
        establishMobileCarError,
        carLoadMore,
        weightCarPagination,
        createEstablishStatus,
        createEstablishUnit,
        createEstablishError,
        carDetailStatus,
        carDetail,
        carDetailError,
        carInUnitDetailImageStatus,
        carDetailImage,
        carDetailImageError,
        weightUnitJoinStatus,
        weightUnitJoinError,
        weightUnitJoinScreen,
        weightUnitUnJoinStatus,
        weightUnitUnJoinError,
        weightUnitsStatus,
        weightUnits,
        weightUnitsError,
        weightUnitsLoadmore,
        weightUnitIsJoinStatus,
        weightUnitIsJoin,
        weightUnitIsJoinError,
        weightUnistLeaveJoinStatus,
        weightUnistLeaveJoinError,
        weightUnistCloseStatus,
        weightUnistCloseError,
      ];
}
