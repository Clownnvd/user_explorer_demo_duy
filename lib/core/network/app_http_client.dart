import 'package:dio/dio.dart';

class AppHttpClient {
  final Dio _dio;
  AppHttpClient(this._dio) {
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  Future<Response<dynamic>> get(String path, {Map<String, dynamic>? queryParameters}) {
    return _dio.get(path, queryParameters: queryParameters);
  }
}
