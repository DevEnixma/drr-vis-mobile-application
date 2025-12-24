import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wts_bloc/data/repo/repo.dart';

import '../../data/models/weight_add_car/weight_add_car_model_req.dart';
import '../../data/models/weight_add_car/weight_add_car_model_res.dart';

part 'weight_car_event.dart';
part 'weight_car_state.dart';

class WeightCarBloc extends Bloc<WeightCarEvent, WeightCarState> {
  WeightCarBloc() : super(const WeightCarState()) {
    on<PostWeightCarEvent>(_onPostWeightCar);
    on<PutWeightCarEvent>(_onPutWeightCar);
  }

  Future<void> _onPostWeightCar(
    PostWeightCarEvent event,
    Emitter<WeightCarState> emit,
  ) async {
    await _submitWeightCar(
      event.payload,
      emit,
      (body) => establishRepo.postAddCarUnitWeight(body),
    );
  }

  Future<void> _onPutWeightCar(
    PutWeightCarEvent event,
    Emitter<WeightCarState> emit,
  ) async {
    await _submitWeightCar(
      event.payload,
      emit,
      (body) => establishRepo.putAddCarUnitWeight(body),
    );
  }

  Future<void> _submitWeightCar(
    WeightAddCarModelReq payload,
    Emitter<WeightCarState> emit,
    Future<dynamic> Function(String body) apiCall,
  ) async {
    emit(state.copyWith(weightCarStatus: WeightCarStatus.loading));

    try {
      final body = json.encode(payload.toJson());
      final response = await apiCall(body);

      if (response.statusCode >= 200 && response.statusCode < 400) {
        final result = WeightAddCarModelRes.fromJson(response.data['data']);

        await _uploadCarImages(payload, result.tdId.toString());

        emit(state.copyWith(
          weightCarStatus: WeightCarStatus.success,
          weightCar: result,
        ));
      } else {
        emit(state.copyWith(
          weightCarStatus: WeightCarStatus.error,
          weightCarError: response.error ?? 'Unknown error',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        weightCarStatus: WeightCarStatus.error,
        weightCarError: e.toString(),
      ));
    }
  }

  Future<void> _uploadCarImages(
    WeightAddCarModelReq payload,
    String tdId,
  ) async {
    await establishRepo.postAddCarUnitWeigntImage(
      payload.tId.toString(),
      tdId,
      payload.frontImage,
      payload.backImage,
      payload.leftImage,
      payload.rightImage,
      payload.slipImage,
      payload.licenseImage,
    );
  }
}
