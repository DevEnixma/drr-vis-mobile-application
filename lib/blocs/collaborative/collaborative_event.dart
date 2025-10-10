part of 'collaborative_bloc.dart';

sealed class CollaborativeEvent extends Equatable {
  const CollaborativeEvent();

  @override
  List<Object> get props => [];
}

class GetCollaborativeEvent extends CollaborativeEvent {
  const GetCollaborativeEvent();
}

class SelectedCollaborativeEvent extends CollaborativeEvent {
  final CollaborativeRes collaborative;
  const SelectedCollaborativeEvent(this.collaborative);
}

class ConfirmCollaborativeEvent extends CollaborativeEvent {
  const ConfirmCollaborativeEvent();
}

class SearchCollaborativeEvent extends CollaborativeEvent {
  final String payload;
  const SearchCollaborativeEvent(this.payload);
}
