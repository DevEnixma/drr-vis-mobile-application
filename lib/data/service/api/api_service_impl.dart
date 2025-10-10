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

  @override
  void init({required String baseUrl}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ),
    );
    _dio.interceptors.add(
      TalkerDioLogger(
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printRequestData: true,
          printResponseData: false,
          printResponseHeaders: true,
          printResponseMessage: true,
        ),
      ),
    );
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.baseUrl = baseUrl;
          try {
            final LocalStorage storage = LocalStorage();

            String? accessToken = await storage.getValueString(KeyLocalStorage.accessToken);
            logger.i('======[dio]=====${DateTime.now()}==accessToken: >>> $accessToken <<<');

            if (accessToken != null && accessToken != '') {
              options.headers['Authorization'] = 'Bearer $accessToken';
            }
          } catch (e) {
            (e);
          }

          logger.i('======[dio]=======REQUEST[${options.method}] => PATH: ${options.path}');
          logger.i('======[dio]=======Headers: ${options.headers}');
          logger.i('======[dio]=======Query Parameters: ${options.queryParameters}');
          logger.i('======[dio]=======Data: ${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          logger.i("======[dio]=======RESPONSE[${response.statusCode}] => DATA: ${response.data}");
          return handler.next(response);
        },
        onError: (e, handler) async {
          logger.e("======[dio]=======ERROR[${e.response?.statusCode}] => MESSAGE: ${e.message}");
          final LocalStorage storage = LocalStorage();

          if (e.response?.statusCode == 401) {
            logger.e('===========[refresh token]===========');
            String? refreshToken = await storage.getValueString(KeyLocalStorage.refreshToken);
            String? accessToken = await storage.getValueString(KeyLocalStorage.accessToken);
            logger.e('===========[refresh accessToken]===========> $accessToken');
            logger.e('===========[refresh refreshToken]===========> $refreshToken');
            if (refreshToken != null && refreshToken != '' && accessToken != null && accessToken != '') {
              logger.e('===========[refresh in process]===========');
            } else {}

            // await storage.removeStorageLogout();
            // if (refreshToken != null && !e.requestOptions.extra.containsKey('retry')) {
            //   e.requestOptions.extra['retry'] = true;

            //   e.requestOptions.headers['Authorization'] = 'Bearer $accessToken';
            //   e.requestOptions.headers['Refresh_token'] = refreshToken;

            //   logger.e('====showErrorSnackbar==type==[postRefreshToken]>');
            //   final response = await loginRepo.postRefreshToken();

            //   if (response.statusCode >= 200 && response.statusCode < 400) {
            //     logger.e('====showErrorSnackbar==type==[statusCode]> ${response.statusCode}');
            //     logger.e('====showErrorSnackbar==type==[data]> ${response.data}');
            //     logger.e('====showErrorSnackbar==type==[new access_token]> ${response.data['response']['access_token']}');
            //     logger.e('====showErrorSnackbar==type==[old accessToken]> $accessToken');

            //     final result = LoginModelRes.fromJson(response.data?["response"]);
            //     logger.e('===showErrorSnackbar==result newToken111>  ${result.toJson()}');
            //     logger.e('===showErrorSnackbar==result newToken222>  ${result.accessToken}');

            //     await storage.setValueString(KeyLocalStorage.accessToken, result.accessToken.toString());
            //     await storage.setValueString(KeyLocalStorage.refreshToken, result.refreshToken.toString());
            //     String? accessToken2 = await storage.getValueString(KeyLocalStorage.accessToken);
            //     logger.e('===299=showErrorSnackbar==type==[old accessToken] 111> $accessToken2');

            //     // return handler.resolve(await _dio.fetch(e.requestOptions));
            //   }
            // }
          }
          return handler.next(e);
        },
      ),
    );
  }

  @override
  Future<ApiResponse> get({
    required String path,
    Map<String, dynamic>? query,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: query);

      return ApiResponse.fromDioResponse(
        response,
      );
    } on DioException catch (e) {
      // return ApiResponse.error(e.toString());
      return handleDioError(e);
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
      final response = await _dio.post(path, data: body, queryParameters: query);
      return ApiResponse.fromDioResponse(response);
    } on DioException catch (e) {
      // return ApiResponse.error(e.toString());
      return handleDioError(e);
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
      return handleDioError(e);
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
      List<String> parts1 = filePath1.split("/");
      String fileName1 = parts1.last;

      List<String> parts2 = filePath1.split("/");
      String fileName2 = parts2.last;

      FormData formData = FormData.fromMap({
        'file1': await MultipartFile.fromFile(filePath1, filename: fileName1),
        'file2': await MultipartFile.fromFile(filePath2, filename: fileName2),
      });

      formData.fields.map((field) {});

      final response = await _dio.post(
        path,
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );

      return ApiResponse.fromDioResponse(response);
    } on DioException catch (e) {
      // return ApiResponse.error(e.toString());
      return handleDioError(e);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  @override
  Future<ApiResponse> createCarImage({required String path, image_path1, image_path2, image_path3, image_path4, image_path5, image_path6}) async {
    try {
      String fileName1 = '';
      if (image_path1 != '') {
        List<String> parts1 = image_path1.split("/");
        fileName1 = parts1.last;
      }

      String fileName2 = '';
      if (image_path2 != '') {
        List<String> parts2 = image_path2.split("/");
        fileName2 = parts2.last;
      }

      String fileName3 = '';
      if (image_path3 != '') {
        List<String> parts3 = image_path3.split("/");
        fileName3 = parts3.last;
      }

      String fileName4 = '';
      if (image_path4 != '') {
        List<String> parts4 = image_path4.split("/");
        fileName4 = parts4.last;
      }

      String fileName5 = '';
      if (image_path5 != '') {
        List<String> parts5 = image_path5.split("/");
        fileName5 = parts5.last;
      }
      String fileName6 = '';
      if (image_path6 != '') {
        List<String> parts6 = image_path6.split("/");
        fileName6 = parts6.last;
      }

      FormData formData = FormData.fromMap({
        'image_path1': image_path1 != '' ? await MultipartFile.fromFile(image_path1, filename: fileName1) : '',
        'image_path2': image_path2 != '' ? await MultipartFile.fromFile(image_path2, filename: fileName2) : '',
        'image_path3': image_path3 != '' ? await MultipartFile.fromFile(image_path3, filename: fileName3) : '',
        'image_path4': image_path4 != '' ? await MultipartFile.fromFile(image_path4, filename: fileName4) : '',
        'image_path5': image_path5 != '' ? await MultipartFile.fromFile(image_path5, filename: fileName5) : '',
        'image_path6': image_path6 != '' ? await MultipartFile.fromFile(image_path6, filename: fileName6) : '',
      });

// ตรวจสอบ fields
      formData.fields.forEach((field) {
        logger.i('Field: ${field.key}, Value: ${field.value}');
      });

      final response = await _dio.post(
        path,
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );

      return ApiResponse.fromDioResponse(response);
    } on DioException catch (e) {
      logger.e('==========PutWeightCarEvent====6====> $e');
      // return ApiResponse.error(e.toString());
      return handleDioError(e);
    } catch (e) {
      logger.e('==========PutWeightCarEvent====7====> $e');
      return ApiResponse.error(e.toString());
    }
  }

  @override
  Future<ApiResponse> getImageUrl({required String path}) async {
    try {
      final Dio _dioImage = Dio();
      final response = await _dioImage.get('${ServerConfig.baseUrlImage}${path}');

      return ApiResponse.fromDioResponse(
        response,
      );
    } on DioException catch (e) {
      return handleDioError(e);
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

      return ApiResponse.fromDioResponse(
        response,
      );
    } on DioException catch (e) {
      return handleDioError(e);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse> handleDioError(DioException e) async {
    logger.e('=======[error response]==1======> ${e.response}');
    logger.e('=======[error type]==2======> ${e.type}');

    String errorMessage = 'An error occurred';
    int errorCode = int.parse(e.response!.statusCode!.toString());

    final data = e.response?.data;

    if (data is Map<String, dynamic>) {
      // Assuming the model has a field named 'message' instead of 'error'
      ErrorMessageModel message = ErrorMessageModel.fromJson(data);
      errorMessage = message.message.toString(); // Change this to whatever the actual field is

      String resultMessage = 'code: ${e.response?.statusCode}\nmessage: ${errorMessage}';
      logger.e('=======[error type]===resultMessage=0====> ${message}');
      logger.e('=======[error type]===resultMessage=1====> ${errorMessage}');
      logger.e('=======[error type]===resultMessage=2====> ${resultMessage}');
      // logger.e('=======[error type]===resultMessage=3====> ${resultMessage}');
      // logger.e('=======[error type]===resultMessage=4====> ${resultMessage}');
      return ApiResponse.error(resultMessage, statusCode: errorCode);
    } else {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          errorMessage = 'Connection Timeout';
          // errorCode = 1;
          break;
        case DioExceptionType.sendTimeout:
          errorMessage = 'Send Timeout';
          // errorCode = 2;
          break;
        case DioExceptionType.receiveTimeout:
          errorMessage = 'Receive Timeout';
          // errorCode = 3;
          break;
        case DioExceptionType.badResponse:
          errorMessage = 'Received invalid status';
          // errorCode = e.response?.statusCode ?? 10;
          break;
        case DioExceptionType.cancel:
          errorMessage = 'Request to API server was cancelled';
          // errorCode = 4;
          break;
        case DioExceptionType.unknown:
          errorMessage = 'Network error';
          // errorCode = 5;
          break;
        case DioExceptionType.connectionError:
          errorMessage = 'Network error';
          // errorCode = 5;
          break;
        default:
          errorMessage = e.message ?? 'Unknown error';
        // errorCode = 6;
      }

      String resultMessage = 'code: ${e.response?.statusCode}\nmessage: ${errorMessage}';
      logger.e('=======[error type]===resultMessage==2===> ${resultMessage}');

      return ApiResponse.error(resultMessage, statusCode: errorCode);
    }
  }
}

class ErrorMessageModel {
  int? statusCode;
  String? message;

  ErrorMessageModel({this.statusCode, this.message});

  ErrorMessageModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    return data;
  }
}
