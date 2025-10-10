part of 'weight_unit_bloc.dart';

class WeightUnitEvent extends Equatable {
  const WeightUnitEvent();

  @override
  List<Object> get props => [];
}

class GetWeightUnitsEvent extends WeightUnitEvent {
  final String start_date;
  final String end_date;
  final String branch;
  final String search;
  final int page;
  final int pageSize;

  const GetWeightUnitsEvent({
    required this.start_date,
    required this.end_date,
    required this.branch,
    required this.page,
    required this.pageSize,
    required this.search,
  });
}

class GetWeightUnitDetail extends WeightUnitEvent {
  final String tId;

  const GetWeightUnitDetail(this.tId);
}

class GetWeightUnitCars extends WeightUnitEvent {
  final EstablishWeightCarRes payload;

  const GetWeightUnitCars(this.payload);
}

class UpdateIsArrestUnitsEvent extends WeightUnitEvent {
  final String tDId;
  final String arrestFormPostId;

  const UpdateIsArrestUnitsEvent(this.tDId, this.arrestFormPostId);
}
