import '../../models/api_response.dart';

abstract class ApiService {
  void init({required String baseUrl});

  Future<ApiResponse> get({required String path, Map<String, dynamic>? query});
  Future<ApiResponse> post({required String path, String? body, Map<String, dynamic>? query});
  Future<ApiResponse> createUnitImage({required String path, required String filePath1, required String filePath2});
  Future<ApiResponse> createCarImage({required String path, image_path1, image_path2, image_path3, image_path4, image_path5, image_path6});
  Future<ApiResponse> getImageUrl({required String path});
  Future<ApiResponse> put({required String path, String? body, Map<String, dynamic>? query});
  Future<ApiResponse> delete({required String path});
}
