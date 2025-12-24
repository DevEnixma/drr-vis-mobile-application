import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/home/product/product_model.dart';
import '../../../data/repo/repo.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(const ProductInitial()) {
    on<ProductFetchEvent>(_onProductFetch);
  }

  Future<void> _onProductFetch(
    ProductFetchEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(const ProductLoadingState());

    try {
      final category = event.query == "All" ? null : event.query;
      final products = await productRepo.getProducts(category: category);

      if (products.isEmpty) {
        emit(const ProductEmptyState());
      } else {
        emit(ProductLoadedState(products: products));
      }
    } catch (e) {
      emit(ProductErrorState(message: e.toString()));
    }
  }
}
