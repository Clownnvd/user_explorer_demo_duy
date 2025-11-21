import 'package:github_user_explorer/core/network/app_http_client.dart';
import 'package:dio/dio.dart';
//Gọi API → trả raw Response từ Dio → Repository xử lý tiếp
// giao tiếp trực tiếp với API Github
//chỉ gọi API + trả raw response.
//Đây là interface của Remote Data Source
//có 1 client và 1 getUsers
abstract class GithubUserRemoteDataSource {
  AppHttpClient get client;

  Future<Response> getUsers({String? query});
}

class GithubUserRemoteDataSourceImpl implements GithubUserRemoteDataSource {
  @override
  final AppHttpClient client;

  GithubUserRemoteDataSourceImpl(this.client);

  @override
  Future<Response> getUsers({String? query}) {
    return client.get(
      '/search/users',
      queryParameters: (query != null && query.isNotEmpty)
          ? {'q': query}
          : {'q': 'flutter'},
    );
  }
}
