part of 'collaborative_bloc.dart';

enum CollaborativeStatus {
  initial,
  loading,
  success,
  error,
}

class CollaborativeState extends Equatable {
  final CollaborativeStatus collaborativeStatus;
  final List<CollaborativeRes>? collaborative;
  final String? collaborativeError;

  final List<CollaborativeRes>? isSelectedCollaborative;
  final String? isSelectedCollaborativeText;
  final List<String>? isSelectedCollaborativeShow;

  const CollaborativeState({
    this.collaborativeStatus = CollaborativeStatus.initial,
    this.collaborative,
    this.collaborativeError = '',
    this.isSelectedCollaborativeText = '',
    this.isSelectedCollaborative,
    this.isSelectedCollaborativeShow,
  });

  CollaborativeState copyWith({
    CollaborativeStatus? collaborativeStatus,
    List<CollaborativeRes>? collaborative,
    String? collaborativeError,
    List<CollaborativeRes>? isSelectedCollaborative,
    List<String>? isSelectedCollaborativeShow,
    String? isSelectedCollaborativeText,
  }) {
    return CollaborativeState(
      collaborativeStatus: collaborativeStatus ?? this.collaborativeStatus,
      collaborative: collaborative ?? this.collaborative,
      collaborativeError: collaborativeError ?? this.collaborativeError,
      isSelectedCollaborative: isSelectedCollaborative ?? this.isSelectedCollaborative,
      isSelectedCollaborativeShow: isSelectedCollaborativeShow ?? this.isSelectedCollaborativeShow,
      isSelectedCollaborativeText: isSelectedCollaborativeText ?? this.isSelectedCollaborativeText,
    );
  }

  @override
  List<Object?> get props => [
        collaborativeStatus,
        collaborative,
        collaborativeError,
        isSelectedCollaborative,
        isSelectedCollaborativeShow,
        isSelectedCollaborativeText,
      ];
}
