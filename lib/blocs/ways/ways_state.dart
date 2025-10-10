part of 'ways_bloc.dart';

enum WaysStatus {
  initial,
  loading,
  success,
  error,
}

enum WayDetailStatus {
  initial,
  loading,
  success,
  error,
}

class WaysState extends Equatable {
  final WaysStatus waysStatus;
  final List<WaysRes>? ways;
  final String? waysError;

  final bool? isLoadMore;

  final WaysRes? selectedWay;

  final WayDetailStatus wayDetailStatus;
  final WaysDetailRes? waysDetailRes;
  final String? wayDetailError;

  const WaysState({
    this.waysStatus = WaysStatus.initial,
    this.ways,
    this.waysError = '',
    this.isLoadMore,
    this.selectedWay,
    this.wayDetailStatus = WayDetailStatus.initial,
    this.waysDetailRes,
    this.wayDetailError = '',
  });

  WaysState copyWith({
    WaysStatus? waysStatus,
    List<WaysRes>? ways,
    String? waysError,
    bool? isLoadMore,
    WaysRes? selectedWay,
    WayDetailStatus? wayDetailStatus,
    WaysDetailRes? waysDetailRes,
    String? wayDetailError,
  }) {
    return WaysState(
      waysStatus: waysStatus ?? this.waysStatus,
      ways: ways ?? this.ways,
      waysError: waysError ?? this.waysError,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      selectedWay: selectedWay ?? this.selectedWay,
      wayDetailStatus: wayDetailStatus ?? this.wayDetailStatus,
      waysDetailRes: waysDetailRes ?? this.waysDetailRes,
      wayDetailError: wayDetailError ?? this.wayDetailError,
    );
  }

  @override
  List<Object?> get props => [
        waysStatus,
        ways,
        waysError,
        isLoadMore,
        selectedWay,
        wayDetailStatus,
        waysDetailRes,
        wayDetailError,
      ];
}
