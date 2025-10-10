import 'package:wts_bloc/data/service/api/api_path.dart';
import 'package:wts_bloc/data/service/service.dart';
import '../../../../utils/exceptions/exceptions.dart';
import '../../../models/home/product/product_model.dart';
import 'product_repo.dart';

class ProductRepoImpl implements ProductRepo {
  @override
  Future<List<ProductModel>> getProducts({String? category}) async {
    print('===== ApiPath =====');
    print(ApiPath.getAllProducts);
    try {
      final String url;
      // if (category != null) {
      //   // url = '${ApiPath.getCategoriesProduct}/$category';

      // } else {
      //   url = ApiPath.getAllProducts;
      // }
       url = ApiPath.getAllProducts;
      // url = 'https://fakestoreapi.com/products';
      final response = await apiService.get(path: url);

      if (response.statusCode == 200) {
        final List<ProductModel> products = (response.data as List).map((product) => ProductModel.fromJson(product)).toList();

        return products;
      }

      return [];
    } catch (e) {
      throw RepoException("Error while fetching products");
    }
  }

  // Future<dynamic> getProducts(Map<String, dynamic>? query) async {
  //   try {
  //     final response = await apiService.get(path: ApiPath.getAllProducts, query: query);
  //     return response;
  //   } catch (e) {
  //     throw RepoException('Error wile catch notification');
  //   }
  // }
}
