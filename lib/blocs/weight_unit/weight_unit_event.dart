part of 'weight_unit_bloc.dart';

sealed class WeightUnitEvent extends Equatable {
  const WeightUnitEvent();

  @override
  List<Object> get props => [];
}

final class GetWeightUnitsEvent extends WeightUnitEvent {
  final String startDate;
  final String endDate;
  final String branch;
  final String search;
  final int page;
  final int pageSize;

  const GetWeightUnitsEvent({
    required this.startDate,
    required this.endDate,
    required this.branch,
    required this.page,
    required this.pageSize,
    required this.search,
  });

  @override
  List<Object> get props =>
      [startDate, endDate, branch, search, page, pageSize];
}

final class GetWeightUnitDetail extends WeightUnitEvent {
  final String tId;

  const GetWeightUnitDetail(this.tId);

  @override
  List<Object> get props => [tId];
}

final class GetWeightUnitCars extends WeightUnitEvent {
  final EstablishWeightCarRes payload;

  const GetWeightUnitCars(this.payload);

  @override
  List<Object> get props => [payload];
}

final class UpdateIsArrestUnitsEvent extends WeightUnitEvent {
  final String tDId;
  final String arrestFormPostId;

  const UpdateIsArrestUnitsEvent(this.tDId, this.arrestFormPostId);

  @override
  List<Object> get props => [tDId, arrestFormPostId];
}
