part of 'weight_car_bloc.dart';

enum WeightCarStatus {
  initial,
  loading,
  success,
  error,
}

class WeightCarState extends Equatable {
  final WeightCarStatus weightCarStatus;
  final WeightAddCarModelRes? weightCar;
  final String weightCarError;

  const WeightCarState({
    this.weightCarStatus = WeightCarStatus.initial,
    this.weightCar,
    this.weightCarError = '',
  });

  WeightCarState copyWith({
    WeightCarStatus? weightCarStatus,
    WeightAddCarModelRes? weightCar,
    String? weightCarError,
  }) {
    return WeightCarState(
      weightCarStatus: weightCarStatus ?? this.weightCarStatus,
      weightCar: weightCar ?? this.weightCar,
      weightCarError: weightCarError ?? this.weightCarError,
    );
  }

  @override
  List<Object?> get props => [
        weightCarStatus,
        weightCar,
        weightCarError,
      ];
}
