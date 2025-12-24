part of 'vehicle_car_bloc.dart';

sealed class VehicleCarEvent extends Equatable {
  const VehicleCarEvent();

  @override
  List<Object> get props => [];
}

final class GetVehicleCarEvent extends VehicleCarEvent {
  final VehicleReq payload;

  const GetVehicleCarEvent(this.payload);

  @override
  List<Object> get props => [payload];
}

final class SelectVehicleCarEvent extends VehicleCarEvent {
  final VehicleRes payload;

  const SelectVehicleCarEvent(this.payload);

  @override
  List<Object> get props => [payload];
}

final class ClearSelectVehicleCarEvent extends VehicleCarEvent {
  const ClearSelectVehicleCarEvent();
}
