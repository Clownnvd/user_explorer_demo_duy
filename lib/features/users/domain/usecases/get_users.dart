import 'package:github_user_explorer/features/users/domain/entities/github_user.dart';
import 'package:github_user_explorer/features/users/domain/repositories/github_user_repository.dart';
//Đóng gói nghiệp vụ: lấy danh sách user.
class GetUsers {
  final GithubUserRepository _repo;
  GetUsers(this._repo);

  Future<List<GithubUser>> call({String? query}) => _repo.getUsers(query: query);
}
