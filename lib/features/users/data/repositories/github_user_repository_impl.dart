import 'package:github_user_explorer/features/users/data/github_user_remote_data_source.dart';
import 'package:github_user_explorer/features/users/domain/entities/github_user.dart';
import 'package:github_user_explorer/features/users/domain/repositories/github_user_repository.dart';

import '../models/github_user_model.dart';

class GithubUserRepositoryImpl implements GithubUserRepository {
  final GithubUserRemoteDataSource _remote;
  GithubUserRepositoryImpl(this._remote);

  @override
  Future<List<GithubUser>> getUsers({String? query}) async {
    // Gọi remote datasource lấy về danh sách model
    final List<GithubUserModel> models = await _remote.getUsers(query: query);

    // Chuyển đổi model -> entity
    final List<GithubUser> entities = models.map((m) => m.toEntity()).toList();

    return entities;
  }
}
