import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wts_bloc/data/models/master_data/vehicles/vehicle_req.dart';
import 'package:wts_bloc/data/models/master_data/vehicles/vehicle_res.dart';
import 'package:wts_bloc/data/repo/repo.dart';

part 'vehicle_car_event.dart';
part 'vehicle_car_state.dart';

class VehicleCarBloc extends Bloc<VehicleCarEvent, VehicleCarState> {
  VehicleCarBloc() : super(const VehicleCarState()) {
    on<GetVehicleCarEvent>((event, emit) async {
      try {
        emit(state.copyWith(vehicleCarStatus: VehicleCarStatus.loading));
        final response = await masterDataRepo.getMasterVehicleClass(event.payload.toJson());

        if (response.statusCode >= 200 && response.statusCode < 400) {
          final List items = response.data['data']['data'];
          var result = items.map((e) => VehicleRes.fromJson(e)).toList();

          emit(state.copyWith(vehicleCarStatus: VehicleCarStatus.success, vehicleCar: result));
          return;
        }
        emit(state.copyWith(vehicleCarStatus: VehicleCarStatus.error, vehicleCarError: response.error));
        return;
      } catch (e) {
        emit(state.copyWith(vehicleCarStatus: VehicleCarStatus.error, vehicleCarError: e.toString()));
        return;
      }
    });

    on<SelectVehicleCarEvent>((event, emit) async {
      emit(state.copyWith(selectVehicle: event.payload));
    });

    on<ClearSelectVehicleCarEvent>((event, emit) async {
      emit(state.copyWith(selectVehicle: VehicleRes.empty()));
    });
  }
}
