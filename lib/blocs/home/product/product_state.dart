part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

final class ProductInitial extends ProductState {
  const ProductInitial();
}

final class ProductLoadingState extends ProductState {
  const ProductLoadingState();
}

final class ProductLoadedState extends ProductState {
  final List<ProductModel> products;

  const ProductLoadedState({required this.products});

  @override
  List<Object?> get props => [products];
}

final class ProductEmptyState extends ProductState {
  final String message;

  const ProductEmptyState({this.message = 'No products found'});

  @override
  List<Object?> get props => [message];
}

final class ProductErrorState extends ProductState {
  final String message;

  const ProductErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
