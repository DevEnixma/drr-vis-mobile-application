import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wts_bloc/data/models/master_data/ways/ways_detail_res.dart';
import 'package:wts_bloc/data/models/master_data/ways/ways_req.dart';
import 'package:wts_bloc/data/models/master_data/ways/ways_res.dart';
import 'package:wts_bloc/data/repo/repo.dart';

part 'ways_event.dart';
part 'ways_state.dart';

class WaysBloc extends Bloc<WaysEvent, WaysState> {
  WaysBloc() : super(const WaysState()) {
    on<GetWaysEvent>(_onGetWays);
    on<SelectedWay>(_onSelectedWay);
    on<ClearSelectedWay>(_onClearSelectedWay);
    on<GetWayDetail>(_onGetWayDetail);
  }

  Future<void> _onGetWays(
    GetWaysEvent event,
    Emitter<WaysState> emit,
  ) async {
    final page = event.payload.page ?? 1;

    if (page <= 1) {
      emit(state.copyWith(waysStatus: WaysStatus.loading));
    } else {
      emit(state.copyWith(isLoadMore: true));
    }

    try {
      final response = await masterDataRepo.getWays(event.payload.toJson());

      if (response.statusCode >= 200 && response.statusCode < 400) {
        final List items = response.data['data'];
        final result = items.map((e) => WaysRes.fromJson(e)).toList();

        final updatedList = page <= 1 ? result : [...?state.ways, ...result];

        emit(state.copyWith(
          waysStatus: WaysStatus.success,
          ways: updatedList,
          isLoadMore: false,
        ));
      } else {
        emit(state.copyWith(
          waysStatus: WaysStatus.error,
          waysError: response.error ?? 'Unknown error',
          isLoadMore: false,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        waysStatus: WaysStatus.error,
        waysError: e.toString(),
        isLoadMore: false,
      ));
    }
  }

  void _onSelectedWay(
    SelectedWay event,
    Emitter<WaysState> emit,
  ) {
    emit(state.copyWith(selectedWay: event.payload));
  }

  void _onClearSelectedWay(
    ClearSelectedWay event,
    Emitter<WaysState> emit,
  ) {
    emit(state.copyWith(selectedWay: WaysRes.empty()));
  }

  Future<void> _onGetWayDetail(
    GetWayDetail event,
    Emitter<WaysState> emit,
  ) async {
    emit(state.copyWith(wayDetailStatus: WayDetailStatus.loading));

    try {
      final response = await masterDataRepo.getWaysDetail(event.wayID, {});

      if (response.statusCode >= 200 && response.statusCode < 400) {
        final result = WaysDetailRes.fromJson(response.data['data']);

        emit(state.copyWith(
          wayDetailStatus: WayDetailStatus.success,
          waysDetailRes: result,
        ));
      } else {
        emit(state.copyWith(
          wayDetailStatus: WayDetailStatus.error,
          wayDetailError: response.error ?? 'Unknown error',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        wayDetailStatus: WayDetailStatus.error,
        wayDetailError: e.toString(),
      ));
    }
  }
}
