import 'package:demo/core/networking/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  static late Dio dio;

  static void init() {
    dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));

    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
  }

  static Future<Response<dynamic>> postData(
    String endpoint, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    String? token
  }) async {
    final response = dio.post(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: {'Authorization': "Bearer $token"})
    );
    return response;
  }

  static Future<Response<dynamic>>getData(
  String endpoint, {
        Map<String, dynamic>? queryParameters,
        String? token,
      })async{
    final response = dio.get(
      endpoint,
      queryParameters: queryParameters,
        options: Options(headers: {'Authorization': "Bearer $token"})
    );
    return response;
  }
}
