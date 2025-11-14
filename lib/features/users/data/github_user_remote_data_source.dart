import 'package:github_user_explorer/core/network/app_http_client.dart';
import 'package:dio/dio.dart';

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
