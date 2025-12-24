part of 'weight_car_bloc.dart';

sealed class WeightCarEvent extends Equatable {
  const WeightCarEvent();

  @override
  List<Object> get props => [];
}

final class PostWeightCarEvent extends WeightCarEvent {
  final WeightAddCarModelReq payload;

  const PostWeightCarEvent(this.payload);

  @override
  List<Object> get props => [payload];
}

final class PutWeightCarEvent extends WeightCarEvent {
  final WeightAddCarModelReq payload;

  const PutWeightCarEvent(this.payload);

  @override
  List<Object> get props => [payload];
}
