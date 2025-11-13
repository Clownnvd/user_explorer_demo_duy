import 'package:github_user_explorer/core/network/base_repository.dart';
import 'package:github_user_explorer/features/users/data/github_user_remote_data_source.dart';
import 'package:github_user_explorer/features/users/data/models/github_user_model.dart';
import 'package:github_user_explorer/features/users/domain/entities/github_user.dart';
import 'package:github_user_explorer/features/users/domain/repositories/github_user_repository.dart';

class GithubUserRepositoryImpl extends BaseRepository
    implements GithubUserRepository {
  final GithubUserRemoteDataSource _remote;

  GithubUserRepositoryImpl(this._remote)
      : super(_remote.client.dio); 

  @override
  Future<List<GithubUser>> getUsers({String? query}) async {
    final result = await safeApiCall<List<GithubUser>>(
      () => _remote.client.get(
        '/search/users',
        queryParameters: (query != null && query.isNotEmpty)
            ? {'q': query}
            : {'q': 'flutter'},
      ),
      (data) {
        final items = data['items'] as List<dynamic>;
        return items
            .map((e) => GithubUserModel.fromJson(e).toEntity())
            .toList();
      },
    );

    if (result.hasError) throw Exception(result.error);

    return result.data!;
  }
}
