import 'package:dio/dio.dart';
import 'base_response.dart';
import 'error_mapper.dart';
//tầng xử lý API chung cho tất cả repository trong app
//Chuẩn hóa cách gọi API
// /Chuẩn hóa lỗi thông qua ErrorMapper
class BaseRepository {
  final Dio dio;

  BaseRepository(this.dio);

  Future<BaseResponse<T>> safeApiCall<T>(
    Future<dynamic> Function() call,
    T Function(dynamic json) mapper,
  ) async {
    try {
      final result = await call();

      /// Nếu DataSource trả Response
      if (result is Response) {
        return BaseResponse<T>(data: mapper(result.data));
      }

      /// Nếu DataSource trả raw JSON
      return BaseResponse<T>(data: mapper(result));
    } catch (error) {
      final msg = ErrorMapper.toMessage(error);
      return BaseResponse<T>(error: msg);
    }
  }
}
