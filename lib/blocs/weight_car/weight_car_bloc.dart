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
    on<PostWeightCarEvent>((event, emit) async {
      try {
        emit(state.copyWith(weightCarStatus: WeightCarStatus.loading));

        var body = json.encode(event.payload.toJson());
        final response = await establishRepo.postAddCarUnitWeight(body);
        if (response.statusCode >= 200 && response.statusCode < 400) {
          var result = WeightAddCarModelRes.fromJson(response.data['data']);

          await establishRepo.postAddCarUnitWeigntImage(event.payload.tId.toString(), result.tdId.toString(), event.payload.frontImage, event.payload.backImage, event.payload.leftImage, event.payload.rightImage, event.payload.slipImage, event.payload.licenseImage);
          emit(state.copyWith(weightCarStatus: WeightCarStatus.success));
          return;
        }

        emit(state.copyWith(weightCarStatus: WeightCarStatus.error, weightCarError: response.error));
        return;
      } catch (e) {
        emit(state.copyWith(weightCarStatus: WeightCarStatus.error, weightCarError: e.toString()));
        return;
      }
    });

    on<PutWeightCarEvent>((event, emit) async {
      try {
        emit(state.copyWith(weightCarStatus: WeightCarStatus.loading));

        var body = json.encode(event.payload.toJson());
        final response = await establishRepo.putAddCarUnitWeight(body);
        if (response.statusCode >= 200 && response.statusCode < 400) {
          var result = WeightAddCarModelRes.fromJson(response.data['data']);

          await establishRepo.postAddCarUnitWeigntImage(event.payload.tId.toString(), result.tdId.toString(), event.payload.frontImage, event.payload.backImage, event.payload.leftImage, event.payload.rightImage, event.payload.slipImage, event.payload.licenseImage);
          emit(state.copyWith(weightCarStatus: WeightCarStatus.success));
          return;
        }

        emit(state.copyWith(weightCarStatus: WeightCarStatus.error, weightCarError: response.error));
        return;
      } catch (e) {
        emit(state.copyWith(weightCarStatus: WeightCarStatus.error, weightCarError: e.toString()));
        return;
      }
    });
  }
}
