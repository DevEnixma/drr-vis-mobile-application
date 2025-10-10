part of 'weight_car_bloc.dart';

sealed class WeightCarEvent extends Equatable {
  const WeightCarEvent();

  @override
  List<Object> get props => [];
}

class PostWeightCarEvent extends WeightCarEvent {
  final WeightAddCarModelReq payload;

  const PostWeightCarEvent(this.payload);
}

class PutWeightCarEvent extends WeightCarEvent {
  final WeightAddCarModelReq payload;

  const PutWeightCarEvent(this.payload);
}
