import 'package:dio/dio.dart';
import 'package:github_user_explorer/core/errors/app_exception.dart';

class ApiResult<T> {
  final T? data;
  final String? error;

  const ApiResult._({this.data, this.error});

  bool get isSuccess => data != null;

  factory ApiResult.success(T data) => ApiResult._(data: data);

  factory ApiResult.failure(String error) => ApiResult._(error: error);
}

class AppHttpClientResult {
  final Dio _dio;

  AppHttpClientResult(this._dio);

  Future<ApiResult<Response>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final res = await _dio.get(path, queryParameters: queryParameters);
      return ApiResult.success(res);
    } on DioException catch (e) {
      throw AppException(e.message ?? "Network error");
    }
  }
}
