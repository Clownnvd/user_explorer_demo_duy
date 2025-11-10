import 'package:github_user_explorer/features/users/domain/entities/github_user.dart';

abstract class GithubUserRepository {
  Future<List<GithubUser>> getUsers({String? query});
}
