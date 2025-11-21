import 'package:dio/dio.dart';
//là một wrapper (lớp bọc) quanh Dio
//Không để repository hoặc UI gọi
class AppHttpClient {
  final Dio dio;

  AppHttpClient(this.dio);

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return dio.post(path, data: data, queryParameters: queryParameters);
  }
}
