import '../../models/api_response.dart';

abstract class ApiService {
  void init({required String baseUrl});

  Future<ApiResponse> get({
    required String path,
    Map<String, dynamic>? query,
  });

  Future<ApiResponse> post({
    required String path,
    String? body,
    Map<String, dynamic>? query,
  });

  Future<ApiResponse> put({
    required String path,
    String? body,
    Map<String, dynamic>? query,
  });

  Future<ApiResponse> delete({
    required String path,
  });

  Future<ApiResponse> createUnitImage({
    required String path,
    required String filePath1,
    required String filePath2,
    Map<String, dynamic>? query,
  });

  Future<ApiResponse> createCarImage({
    required String path,
    String? image_path1,
    String? image_path2,
    String? image_path3,
    String? image_path4,
    String? image_path5,
    String? image_path6,
  });

  Future<ApiResponse> getImageUrl({
    required String path,
  });
}
