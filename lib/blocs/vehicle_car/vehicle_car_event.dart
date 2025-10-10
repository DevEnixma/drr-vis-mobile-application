part of 'vehicle_car_bloc.dart';

sealed class VehicleCarEvent extends Equatable {
  const VehicleCarEvent();

  @override
  List<Object> get props => [];
}

class GetVehicleCarEvent extends VehicleCarEvent {
  final VehicleReq payload;

  const GetVehicleCarEvent(this.payload);
}

class SelectVehicleCarEvent extends VehicleCarEvent {
  final VehicleRes payload;

  const SelectVehicleCarEvent(this.payload);
}

class ClearSelectVehicleCarEvent extends VehicleCarEvent {
  const ClearSelectVehicleCarEvent();
}
