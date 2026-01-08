import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:wts_bloc/app/config/server_config.dart';

import '../../../local_storage.dart';
import '../../../main.dart';
import '../../../utils/constants/key_localstorage.dart';
import '../../models/api_response.dart';
import 'api_service.dart';

class ApiServiceImpl extends ApiService {
  late Dio _dio;
  late Dio _dioImage;
  final LocalStorage _storage = LocalStorage();

  @override
  void init({required String baseUrl}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      ),
    );

    _dioImage = Dio(
      BaseOptions(
        baseUrl: ServerConfig.baseUrlImage,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.addAll([
      _AuthInterceptor(_storage),
      TalkerDioLogger(
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printRequestData: true,
          printResponseData: false,
          printResponseHeaders: false,
          printResponseMessage: false,
        ),
      ),
      InterceptorsWrapper(
        onResponse: _onResponse,
        onError: _onError,
      ),
    ]);
  }

  void _onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    logger.i(
        'RESPONSE[${response.statusCode}] => ${response.requestOptions.path}');
    handler.next(response);
  }

  Future<void> _onError(
    DioException e,
    ErrorInterceptorHandler handler,
  ) async {
    logger.e('ERROR[${e.response?.statusCode}] => ${e.requestOptions.path}');

    if (e.response?.statusCode == 401) {
      logger.e('401 Unauthorized - Token expired');
    }

    handler.next(e);
  }

  @override
  Future<ApiResponse> get({
    required String path,
    Map<String, dynamic>? query,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: query);
      return ApiResponse.fromDioResponse(response);
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  @override
  Future<ApiResponse> post({
    required String path,
    String? body,
    Map<String, dynamic>? query,
  }) async {
    try {
      final response =
          await _dio.post(path, data: body, queryParameters: query);
      return ApiResponse.fromDioResponse(response);
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  @override
  Future<ApiResponse> put({
    required String path,
    String? body,
    Map<String, dynamic>? query,
  }) async {
    try {
      final response = await _dio.put(path, data: body, queryParameters: query);
      return ApiResponse.fromDioResponse(response);
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  @override
  Future<ApiResponse> delete({
    required String path,
  }) async {
    try {
      final response = await _dio.delete(path);
      return ApiResponse.fromDioResponse(response);
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  @override
  Future<ApiResponse> createUnitImage({
    required String path,
    required String filePath1,
    required String filePath2,
    Map<String, dynamic>? query,
  }) async {
    try {
      final formData = FormData.fromMap({
        'file1': await MultipartFile.fromFile(
          filePath1,
          filename: _getFileName(filePath1),
        ),
        'file2': await MultipartFile.fromFile(
          filePath2,
          filename: _getFileName(filePath2),
        ),
      });

      final response = await _dio.post(
        path,
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );

      return ApiResponse.fromDioResponse(response);
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  @override
  Future<ApiResponse> createCarImage({
    required String path,
    String? image_path1,
    String? image_path2,
    String? image_path3,
    String? image_path4,
    String? image_path5,
    String? image_path6,
  }) async {
    try {
      final Map<String, dynamic> formDataMap = {};

      await _addImageToFormData(formDataMap, 'image_path1', image_path1);
      await _addImageToFormData(formDataMap, 'image_path2', image_path2);
      await _addImageToFormData(formDataMap, 'image_path3', image_path3);
      await _addImageToFormData(formDataMap, 'image_path4', image_path4);
      await _addImageToFormData(formDataMap, 'image_path5', image_path5);
      await _addImageToFormData(formDataMap, 'image_path6', image_path6);

      final formData = FormData.fromMap(formDataMap);

      final response = await _dio.post(
        path,
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );

      return ApiResponse.fromDioResponse(response);
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  @override
  Future<ApiResponse> getImageUrl({required String path}) async {
    try {
      final response = await _dioImage.get(path);
      return ApiResponse.fromDioResponse(response);
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  Future<void> _addImageToFormData(
    Map<String, dynamic> formDataMap,
    String key,
    String? imagePath,
  ) async {
    if (imagePath != null && imagePath.isNotEmpty) {
      formDataMap[key] = await MultipartFile.fromFile(
        imagePath,
        filename: _getFileName(imagePath),
      );
    } else {
      formDataMap[key] = '';
    }
  }

  String _getFileName(String path) {
    return path.split('/').last;
  }

  Future<ApiResponse> _handleDioError(DioException e) async {
    logger.e('DioException: ${e.type}');

    final statusCode = e.response?.statusCode ?? 0;
    String errorMessage = 'An error occurred';

    final data = e.response?.data;
    if (data is Map<String, dynamic>) {
      final errorModel = ErrorMessageModel.fromJson(data);
      errorMessage = errorModel.message ?? errorMessage;
    } else {
      errorMessage = _getErrorMessageByType(e.type);
    }

    final resultMessage = 'code: $statusCode\nmessage: $errorMessage';
    logger.e('Error: $resultMessage');

    return ApiResponse.error(resultMessage, statusCode: statusCode);
  }

  String _getErrorMessageByType(DioExceptionType type) {
    switch (type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout';
      case DioExceptionType.sendTimeout:
        return 'Send timeout';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout';
      case DioExceptionType.badResponse:
        return 'Invalid response from server';
      case DioExceptionType.cancel:
        return 'Request cancelled';
      case DioExceptionType.connectionError:
        return 'Network connection error';
      case DioExceptionType.unknown:
        return 'Unknown network error';
      default:
        return 'Unknown error occurred';
    }
  }
}

class _AuthInterceptor extends Interceptor {
  final LocalStorage _storage;

  _AuthInterceptor(this._storage);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final accessToken =
          await _storage.getValueString(KeyLocalStorage.accessToken);

      if (accessToken != null && accessToken.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $accessToken';
        logger.i('REQUEST[${options.method}] => ${options.path}');
      } else {
        logger.w('No access token found for ${options.path}');
      }
    } catch (e) {
      logger.e('Error adding auth token: $e');
    }

    handler.next(options);
  }
}

class ErrorMessageModel {
  final int? statusCode;
  final String? message;

  ErrorMessageModel({this.statusCode, this.message});

  factory ErrorMessageModel.fromJson(Map<String, dynamic> json) {
    return ErrorMessageModel(
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'message': message,
    };
  }
}
