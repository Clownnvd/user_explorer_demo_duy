import 'package:dio/dio.dart';
import 'package:github_user_explorer/core/network/base_response.dart';

abstract class BaseRepository {
  final Dio dio;

  BaseRepository(this.dio);

  Future<BaseResponse<T>> safeApiCall<T>(
    Future<Response<dynamic>> Function() request,
    T Function(dynamic data) mapper,
  ) async {
    try {
      final response = await request();
      final mappedData = mapper(response.data);

      return BaseResponse<T>(data: mappedData);
    } catch (e) {
      return BaseResponse<T>(error: e.toString());
    }
  }
}
