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
    on<GetWaysEvent>((event, emit) async {
      try {
        if (event.payload.page! <= 1) {
          emit(state.copyWith(waysStatus: WaysStatus.loading));
        }
        if (event.payload.page! > 1) {
          emit(state.copyWith(isLoadMore: true));
        }

        final response = await masterDataRepo.getWays(event.payload.toJson());
        if (response.statusCode >= 200 && response.statusCode < 400) {
          final List items = response.data['data'];
          var result = items.map((e) => WaysRes.fromJson(e)).toList();

          if (event.payload.page! > 1) {
            state.ways!.addAll(result);
            emit(state.copyWith(ways: state.ways!));
          } else {
            emit(state.copyWith(ways: result));
          }

          emit(state.copyWith(waysStatus: WaysStatus.success));
          emit(state.copyWith(isLoadMore: false));
          return;
        }

        emit(state.copyWith(waysStatus: WaysStatus.error, waysError: response.error));
        return;
      } catch (e) {
        emit(state.copyWith(waysStatus: WaysStatus.error, waysError: e.toString()));
        return;
      }
    });

    on<SelectedWay>((event, emit) async {
      emit(state.copyWith(selectedWay: event.payload));
    });

    on<ClearSelectedWay>((event, emit) async {
      emit(state.copyWith(selectedWay: WaysRes.empty()));
    });

    on<GetWayDetail>((event, emit) async {
      try {
        emit(state.copyWith(wayDetailStatus: WayDetailStatus.loading));
        final response = await masterDataRepo.getWaysDetail(event.wayID, {});
        if (response.statusCode >= 200 && response.statusCode < 400) {
          var result = WaysDetailRes.fromJson(response.data['data']);

          emit(state.copyWith(wayDetailStatus: WayDetailStatus.success, waysDetailRes: result));
          return;
        }

        emit(state.copyWith(wayDetailStatus: WayDetailStatus.loading, wayDetailError: response.error));
        return;
      } catch (e) {
        emit(state.copyWith(wayDetailStatus: WayDetailStatus.loading, wayDetailError: e.toString()));
        return;
      }
    });
  }
}
