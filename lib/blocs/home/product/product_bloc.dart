import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/home/product/product_model.dart';
import '../../../data/repo/repo.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<ProductFetchEvent>((event, emit) async {
      emit(ProductLoadingState());

      try {
        final category = event.query == "All" ? null : event.query;

        final products = await productRepo.getProducts(category: category);
// final response = await productRepo.getProducts(category: category);
        emit(ProductLoadedState(products: products));
      } catch (e) {
        emit(ProductErrorState(message: e.toString()));
      }
    });
  }
}
