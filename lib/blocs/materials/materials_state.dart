part of 'materials_bloc.dart';

enum MaterialsStatus {
  initial,
  loading,
  success,
  error,
}

class MaterialsState extends Equatable {
  final MaterialsStatus materialStatus;
  final List<MaterialModelRes> materials;
  final List<MaterialModelRes> originalMaterials;
  final String materialError;
  final MaterialModelRes? material;
  final bool? loadMore;

  const MaterialsState({
    this.materialStatus = MaterialsStatus.initial,
    this.materials = const [],
    this.originalMaterials = const [],
    this.materialError = '',
    this.material,
    this.loadMore = false,
  });

  MaterialsState copyWith({
    MaterialsStatus? materialStatus,
    List<MaterialModelRes>? materials,
    List<MaterialModelRes>? originalMaterials,
    String? materialError,
    MaterialModelRes? material,
    bool? loadMore,
  }) {
    return MaterialsState(
      materialStatus: materialStatus ?? this.materialStatus,
      materials: materials ?? this.materials,
      originalMaterials: originalMaterials ?? this.originalMaterials,
      materialError: materialError ?? this.materialError,
      material: material ?? this.material,
      loadMore: loadMore ?? this.loadMore,
    );
  }

  @override
  List<Object?> get props => [
        materialStatus,
        materials,
        originalMaterials,
        materialError,
        material,
        loadMore,
      ];
}
