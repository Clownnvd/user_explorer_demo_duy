import 'package:github_user_explorer/core/errors/app_exception.dart';
import 'package:github_user_explorer/core/network/base_repository.dart';
import 'package:github_user_explorer/features/users/data/github_user_remote_data_source.dart';
import 'package:github_user_explorer/features/users/data/models/github_user_model.dart';
import 'package:github_user_explorer/features/users/domain/entities/github_user.dart';
import 'package:github_user_explorer/features/users/domain/repositories/github_user_repository.dart';

// repository thật
class GithubUserRepositoryImpl extends BaseRepository
    implements GithubUserRepository {
  final GithubUserRemoteDataSource _remote;

  GithubUserRepositoryImpl(this._remote) : super(_remote.client.dio);

  @override
  Future<List<GithubUser>> getUsers({String? query}) async {
    final result = await safeApiCall<List<GithubUser>>(
      () => _remote.getUsers(query: query),
      (data) {
        final items = data['items'] as List<dynamic>;
        return items
            .map((e) => GithubUserModel.fromJson(e).toEntity())
            .toList();
      },
    );

    if (result.hasError) {
      throw AppException(result.error ?? "Unknown error");
    }

    return result.data!;
  }
}
