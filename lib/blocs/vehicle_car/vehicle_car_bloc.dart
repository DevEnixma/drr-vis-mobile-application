import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wts_bloc/data/models/master_data/vehicles/vehicle_req.dart';
import 'package:wts_bloc/data/models/master_data/vehicles/vehicle_res.dart';
import 'package:wts_bloc/data/repo/repo.dart';

part 'vehicle_car_event.dart';
part 'vehicle_car_state.dart';

class VehicleCarBloc extends Bloc<VehicleCarEvent, VehicleCarState> {
  VehicleCarBloc() : super(const VehicleCarState()) {
    on<GetVehicleCarEvent>(_onGetVehicleCar);
    on<SelectVehicleCarEvent>(_onSelectVehicleCar);
    on<ClearSelectVehicleCarEvent>(_onClearSelectVehicleCar);
  }

  Future<void> _onGetVehicleCar(
    GetVehicleCarEvent event,
    Emitter<VehicleCarState> emit,
  ) async {
    emit(state.copyWith(vehicleCarStatus: VehicleCarStatus.loading));

    try {
      final response = await masterDataRepo.getMasterVehicleClass(
        event.payload.toJson(),
      );

      if (response.statusCode >= 200 && response.statusCode < 400) {
        final List items = response.data['data']['data'];
        final result = items.map((e) => VehicleRes.fromJson(e)).toList();

        emit(state.copyWith(
          vehicleCarStatus: VehicleCarStatus.success,
          vehicleCar: result,
        ));
      } else {
        emit(state.copyWith(
          vehicleCarStatus: VehicleCarStatus.error,
          vehicleCarError: response.error ?? 'Unknown error',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        vehicleCarStatus: VehicleCarStatus.error,
        vehicleCarError: e.toString(),
      ));
    }
  }

  void _onSelectVehicleCar(
    SelectVehicleCarEvent event,
    Emitter<VehicleCarState> emit,
  ) {
    emit(state.copyWith(selectVehicle: event.payload));
  }

  void _onClearSelectVehicleCar(
    ClearSelectVehicleCarEvent event,
    Emitter<VehicleCarState> emit,
  ) {
    emit(state.copyWith(selectVehicle: VehicleRes.empty()));
  }
}
