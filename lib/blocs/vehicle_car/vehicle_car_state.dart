part of 'vehicle_car_bloc.dart';

enum VehicleCarStatus {
  initial,
  loading,
  success,
  error,
}

class VehicleCarState extends Equatable {
  final VehicleCarStatus vehicleCarStatus;
  final List<VehicleRes>? vehicleCar;
  final String? vehicleCarError;

  final VehicleRes? selectVehicle;

  const VehicleCarState({
    this.vehicleCarStatus = VehicleCarStatus.initial,
    this.vehicleCar,
    this.vehicleCarError = '',
    this.selectVehicle,
  });

  VehicleCarState copyWith({
    VehicleCarStatus? vehicleCarStatus,
    List<VehicleRes>? vehicleCar,
    String? vehicleCarError,
    VehicleRes? selectVehicle,
  }) {
    return VehicleCarState(
      vehicleCarStatus: vehicleCarStatus ?? this.vehicleCarStatus,
      vehicleCar: vehicleCar ?? this.vehicleCar,
      vehicleCarError: vehicleCarError ?? this.vehicleCarError,
      selectVehicle: selectVehicle ?? this.selectVehicle,
    );
  }

  @override
  List<Object?> get props => [
        vehicleCarStatus,
        vehicleCar,
        vehicleCarError,
        selectVehicle,
      ];
}
