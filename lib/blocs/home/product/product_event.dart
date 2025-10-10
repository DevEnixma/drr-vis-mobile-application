part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

class ProductFetchEvent extends ProductEvent {
  final String query;

  ProductFetchEvent(this.query);
}
