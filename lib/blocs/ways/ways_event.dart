part of 'ways_bloc.dart';

sealed class WaysEvent extends Equatable {
  const WaysEvent();

  @override
  List<Object> get props => [];
}

class GetWaysEvent extends WaysEvent {
  final WaysReq payload;

  const GetWaysEvent(this.payload);
}

class SelectedWay extends WaysEvent {
  final WaysRes payload;

  const SelectedWay(this.payload);
}

class ClearSelectedWay extends WaysEvent {
  const ClearSelectedWay();
}

class GetWayDetail extends WaysEvent {
  final String wayID;

  const GetWayDetail(this.wayID);
}
