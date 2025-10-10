part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoadingState extends ProductState {}

class ProductLoadedState extends ProductState {
  final List<ProductModel> products;

  ProductLoadedState({required this.products});
}

final class ProductErrorState extends ProductState {
  final String message;

  ProductErrorState({required this.message});
}