part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

final class ProductFetchEvent extends ProductEvent {
  final String query;

  const ProductFetchEvent(this.query);

  @override
  List<Object?> get props => [query];
}
