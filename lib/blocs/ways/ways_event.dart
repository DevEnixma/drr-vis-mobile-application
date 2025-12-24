part of 'ways_bloc.dart';

sealed class WaysEvent extends Equatable {
  const WaysEvent();

  @override
  List<Object> get props => [];
}

final class GetWaysEvent extends WaysEvent {
  final WaysReq payload;

  const GetWaysEvent(this.payload);

  @override
  List<Object> get props => [payload];
}

final class SelectedWay extends WaysEvent {
  final WaysRes payload;

  const SelectedWay(this.payload);

  @override
  List<Object> get props => [payload];
}

final class ClearSelectedWay extends WaysEvent {
  const ClearSelectedWay();
}

final class GetWayDetail extends WaysEvent {
  final String wayID;

  const GetWayDetail(this.wayID);

  @override
  List<Object> get props => [wayID];
}
