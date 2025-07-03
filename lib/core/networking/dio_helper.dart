import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:medease1/core/networking/api_endpoints.dart';
import 'package:medease1/core/utils/service_locator.dart';
import 'package:medease1/core/utils/storage_helper.dart';
// import 'package:medease1/core/networking/api_interceptors.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHelper {
  static Dio? dio;

  DioHelper() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
    dio!.interceptors.add(PrettyDioLogger());
    dio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await sl<StorageHelper>().getData(key: "accesstoken");
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
            options.headers['cookie'] = "accessToken=$token";
          }

          return handler.next(options);
        },
      ),
    );
  }

  getResponse({required String endpoint, Map<String, dynamic>? query}) async {
    try {
      Response response = await dio!.get(endpoint, queryParameters: query);
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  postRequest({
    required String endpoint,
    required Map<String, dynamic> data,
  }) async {
    try {
      Response response = await dio!.post(endpoint, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  deleteRequest({required String endpoint}) async {
    try {
      Response response = await dio!.delete(endpoint);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
