import '../../../models/home/product/product_model.dart';

abstract class ProductRepo {
  Future<List<ProductModel>> getProducts({String? category});
}
