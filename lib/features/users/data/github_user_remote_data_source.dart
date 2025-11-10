import 'package:github_user_explorer/core/network/app_http_client.dart';
import 'package:github_user_explorer/features/users/data/models/github_user_model.dart';

abstract class GithubUserRemoteDataSource {
  Future<List<GithubUserModel>> getUsers({String? query});
}

class GithubUserRemoteDataSourceImpl implements GithubUserRemoteDataSource {
  final AppHttpClient client;
  GithubUserRemoteDataSourceImpl(this.client);

  @override
  Future<List<GithubUserModel>> getUsers({String? query}) async {
    // https://api.github.com/search/users?q=flutter
    final res = await client.get(
      '/search/users',
      queryParameters:
          (query != null && query.isNotEmpty) ? {'q': query} : {'q': 'flutter'},
    );
    final items = res.data['items'] as List<dynamic>;
    return items.map((e) => GithubUserModel.fromJson(e)).toList();
  }
}
