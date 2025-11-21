import 'package:github_user_explorer/features/users/domain/entities/github_user.dart';
//UI / UseCase chỉ biết interface này, không biết cụ thể dùng API thật hay mock.
abstract class GithubUserRepository {
  Future<List<GithubUser>> getUsers({String? query});
}


