import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/collaborative/collaborative_res.dart';
import '../../data/repo/repo.dart';

part 'collaborative_event.dart';
part 'collaborative_state.dart';

class CollaborativeBloc extends Bloc<CollaborativeEvent, CollaborativeState> {
  CollaborativeBloc() : super(const CollaborativeState()) {
    on<GetCollaborativeEvent>(_onGetCollaborative);
    on<SelectedCollaborativeEvent>(_onSelectedCollaborative);
    on<ConfirmCollaborativeEvent>(_onConfirmCollaborative);
    on<SearchCollaborativeEvent>(_onSearchCollaborative);
  }

  String _buildSelectedText(List<CollaborativeRes> items) {
    return items
        .where((item) => item.isSelected == true)
        .map((item) => item.colname ?? '')
        .where((name) => name.isNotEmpty)
        .join(', ');
  }

  List<CollaborativeRes> _getSelectedItems(List<CollaborativeRes> items) {
    return items.where((item) => item.isSelected == true).toList();
  }

  Future<void> _onGetCollaborative(
    GetCollaborativeEvent event,
    Emitter<CollaborativeState> emit,
  ) async {
    try {
      emit(state.copyWith(collaborativeStatus: CollaborativeStatus.loading));

      final response = await collaborativeRepo.getCollaborative({});

      if (response.statusCode >= 200 && response.statusCode < 400) {
        final List items = response.data['data'];

        final collaborative = items
            .asMap()
            .entries
            .map((entry) => CollaborativeRes(
                  colname: entry.value['colname'] as String?,
                  isSelected: false,
                  id: entry.key + 1,
                ))
            .toList();

        emit(state.copyWith(
          collaborative: collaborative,
          originalCollaborative: collaborative,
          collaborativeStatus: CollaborativeStatus.success,
          isSelectedCollaborativeText: '',
        ));
      } else {
        emit(state.copyWith(
          collaborativeStatus: CollaborativeStatus.error,
          collaborativeError: response.error ?? 'Unknown error',
        ));
      }
    } catch (e, stackTrace) {
      emit(state.copyWith(
        collaborativeStatus: CollaborativeStatus.error,
        collaborativeError: e.toString(),
      ));
    }
  }

  void _onSelectedCollaborative(
    SelectedCollaborativeEvent event,
    Emitter<CollaborativeState> emit,
  ) {
    final currentList = state.collaborative;
    if (currentList == null || currentList.isEmpty) return;

    try {
      final updatedList = currentList.map((item) {
        if (item.id == event.collaborative.id) {
          return CollaborativeRes(
            colname: item.colname,
            isSelected: !(item.isSelected ?? false),
            id: item.id,
          );
        }
        return item;
      }).toList();

      final selectedText = _buildSelectedText(updatedList);
      final selectedItems = _getSelectedItems(updatedList);

      emit(state.copyWith(
        collaborative: updatedList,
        isSelectedCollaborative: selectedItems,
        isSelectedCollaborativeText: selectedText,
        collaborativeStatus: CollaborativeStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        collaborativeStatus: CollaborativeStatus.error,
        collaborativeError: 'Selection error: ${e.toString()}',
      ));
    }
  }

  void _onConfirmCollaborative(
    ConfirmCollaborativeEvent event,
    Emitter<CollaborativeState> emit,
  ) {
    final currentList = state.collaborative;
    if (currentList == null || currentList.isEmpty) return;

    try {
      final selectedNames = currentList
          .where((item) => item.isSelected == true)
          .map((item) => item.colname ?? '')
          .where((name) => name.isNotEmpty)
          .toList();

      emit(state.copyWith(isSelectedCollaborativeShow: selectedNames));
    } catch (e) {
      emit(state.copyWith(
        collaborativeStatus: CollaborativeStatus.error,
        collaborativeError: 'Confirm error: ${e.toString()}',
      ));
    }
  }

  void _onSearchCollaborative(
    SearchCollaborativeEvent event,
    Emitter<CollaborativeState> emit,
  ) {
    final originalList = state.originalCollaborative;
    if (originalList == null || originalList.isEmpty) return;

    try {
      final query = event.payload.toLowerCase().trim();

      if (query.isEmpty) {
        emit(state.copyWith(collaborative: originalList));
        return;
      }
      final filteredList = originalList
          .where((item) => item.colname?.toLowerCase().contains(query) ?? false)
          .toList();

      emit(state.copyWith(collaborative: filteredList));
    } catch (e) {
      emit(state.copyWith(
        collaborativeStatus: CollaborativeStatus.error,
        collaborativeError: 'Search error: ${e.toString()}',
      ));
    }
  }
}
