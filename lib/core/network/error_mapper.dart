import 'package:dio/dio.dart';

class ErrorMapper {
  static String toMessage(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return "Kết nối tới máy chủ quá hạn.";

        case DioExceptionType.badResponse:
          final status = error.response?.statusCode;
          if (status == 401) return "Bạn chưa đăng nhập";
          if (status == 403) return "Bạn không có quyền truy cập";
          if (status == 404) return "Không tìm thấy tài nguyên.";
          if (status == 500) return "Lỗi máy chủ. Vui lòng thử lại.";
          return "Lỗi máy chủ ($status).";

        case DioExceptionType.unknown:
          return "Không có kết nối Internet.";

        default:
          return "Đã xảy ra lỗi không xác định.";
      }
    }

    return error.toString();
  }
}
