part of 'materials_bloc.dart';

enum MaterialsStatus {
  initial,
  loading,
  success,
  error,
}

class MaterialsState extends Equatable {
  final MaterialsStatus materialStatus;
  final List<MaterialModelRes> materials; // Default to empty list
  final String materialError;
  final MaterialModelRes? material;
  final bool? loadMore;

  const MaterialsState({
    this.materialStatus = MaterialsStatus.initial,
    this.materials = const [], // Use empty list as default
    this.materialError = '',
    this.material,
    this.loadMore = false,
  });

  MaterialsState copyWith({
    MaterialsStatus? materialStatus,
    List<MaterialModelRes>? materials,
    String? materialError,
    MaterialModelRes? material,
    bool? loadMore,
  }) {
    return MaterialsState(
      materialStatus: materialStatus ?? this.materialStatus,
      materials: materials ?? this.materials,
      materialError: materialError ?? this.materialError,
      material: material ?? this.material,
      loadMore: loadMore ?? this.loadMore,
    );
  }

  @override
  List<Object?> get props => [
        materialStatus,
        materials,
        materialError,
        material,
        loadMore,
      ];
}
