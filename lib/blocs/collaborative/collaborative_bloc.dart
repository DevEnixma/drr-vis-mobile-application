import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/collaborative/collaborative_res.dart';
import '../../data/repo/repo.dart';

part 'collaborative_event.dart';
part 'collaborative_state.dart';

class CollaborativeBloc extends Bloc<CollaborativeEvent, CollaborativeState> {
  CollaborativeBloc() : super(const CollaborativeState()) {
    on<GetCollaborativeEvent>((event, emit) async {
      try {
        emit(state.copyWith(isSelectedCollaborativeText: ""));
        emit(state.copyWith(collaborativeStatus: CollaborativeStatus.loading));

        final response = await collaborativeRepo.getCollaborative({});
        if (response.statusCode >= 200 && response.statusCode < 400) {
          final List items = response.data['data'];

          List<CollaborativeRes>? newCollaborative = [];

          int countItems = 1;

          items.map((item) {
            newCollaborative.add(CollaborativeRes(
              colname: item['colname'],
              isSelected: false,
              id: countItems,
            ));
            countItems++;
          }).toList();

          emit(state.copyWith(collaborative: newCollaborative));

          emit(state.copyWith(collaborativeStatus: CollaborativeStatus.success));

          return;
        }

        emit(state.copyWith(collaborativeStatus: CollaborativeStatus.error, collaborativeError: response.error));
        return;
      } catch (e) {
        emit(state.copyWith(collaborativeStatus: CollaborativeStatus.error, collaborativeError: e.toString()));
        return;
      }
    });

    on<SelectedCollaborativeEvent>((event, emit) async {
      try {
        final List<CollaborativeRes> updatedSelectedCollaborative = List.from(state.isSelectedCollaborative ?? []);
        final bool isExisting = updatedSelectedCollaborative.any((item) => item.colname == event.collaborative.colname);

        List<CollaborativeRes> newCollaborative = state.collaborative!.map((item) {
          if (item.id == event.collaborative.id) {
            return CollaborativeRes(
              colname: item.colname,
              isSelected: !isExisting,
              id: item.id,
            );
          }
          return item;
        }).toList();

        if (isExisting) {
          updatedSelectedCollaborative.removeWhere((item) => item.colname == event.collaborative.colname);
        } else {
          updatedSelectedCollaborative.add(event.collaborative);
        }

        List<String> itemShow = [];
        newCollaborative.forEach((element) {
          if (element.isSelected == true) {
            itemShow.add(element.colname!);
          }
        });

        String result = itemShow.map((e) => e.toString()).join(', ');

        emit(state.copyWith(collaborative: newCollaborative));

        emit(state.copyWith(collaborativeStatus: CollaborativeStatus.success));

        emit(state.copyWith(
          isSelectedCollaborative: updatedSelectedCollaborative,
          isSelectedCollaborativeText: result,
          collaborative: newCollaborative,
        ));
      } catch (e) {
      }
    });

    on<ConfirmCollaborativeEvent>((event, emit) async {
      try {
        List<String>? newCollaborativeShow = [];

        state.collaborative!.map((item) {
          if (item.isSelected != null && item.isSelected == true) {
            newCollaborativeShow.add(item.colname!);
          }
          return item;
        }).toList();

        emit(state.copyWith(isSelectedCollaborativeShow: newCollaborativeShow));
      } catch (e) {
      }
    });

    on<SearchCollaborativeEvent>((event, emit) async {
      try {
        List<CollaborativeRes>? newCollaborativeShow = [];

        state.collaborative!.map((item) {
          if (item.colname!.contains(event.payload)) {
            newCollaborativeShow.add(item);
          }
          return item;
        }).toList();

        emit(state.copyWith(collaborative: newCollaborativeShow));
      } catch (e) {
      }
    });
  }
}
