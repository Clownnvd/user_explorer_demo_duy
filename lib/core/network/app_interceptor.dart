import 'dart:developer';
import 'package:dio/dio.dart';

class AppInterceptor extends Interceptor {
  final Dio dio;

  AppInterceptor(this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log(
      '-- REQUEST --\n'
      'URL: ${options.uri}\n'
      'Method: ${options.method}\n'
      'Headers: ${options.headers}\n'
      'Data: ${options.data}',
      name: 'HTTP',
    );

    // Ví dụ: thêm token nếu có
    // options.headers['Authorization'] = 'Bearer YOUR_TOKEN';

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log(
      '-- RESPONSE --\n'
      'URL: ${response.realUri}\n'
      'Status: ${response.statusCode}\n'
      'Data: ${response.data}',
      name: 'HTTP',
    );

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    log(
      '-- ERROR --\n'
      'TYPE: ${err.type}\n'
      'URL: ${err.requestOptions.uri}\n'
      'Message: ${err.message}',
      name: 'HTTP',
    );

    // Nếu lỗi 401 -> refresh token (giả lập)
    if (err.response?.statusCode == 401) {
      try {
        log('Refreshing token...', name: 'HTTP');

        // 🔥 TẠO TOKEN MỚI (ví dụ demo)
        final newToken = await _fakeRefreshToken();

        // Gắn lại token vào header
        err.requestOptions.headers['Authorization'] = 'Bearer $newToken';

        // Retry request với token mới
        final retryResponse =
            await dio.fetch(err.requestOptions);

        return handler.resolve(retryResponse);
      } catch (_) {
        log('Token refresh failed', name: 'HTTP');
      }
    }

    // Retry nếu lỗi timeout hoặc network (tối đa 1 lần)
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout) {
      try {
        log('Retrying request...', name: 'HTTP');
        final retryResponse = await dio.fetch(err.requestOptions);
        return handler.resolve(retryResponse);
      } catch (_) {
        log('Retry failed', name: 'HTTP');
      }
    }

    return handler.next(err);
  }

  /// Fake refresh token (demo) — bạn có thể sửa lại tuỳ app của bạn
  Future<String> _fakeRefreshToken() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return 'NEW_TOKEN_ABC123';
  }
}
