import 'package:github_user_explorer/features/users/domain/entities/github_user.dart';
import 'package:github_user_explorer/features/users/domain/repositories/github_user_repository.dart';

/// Repo mock dùng khi emulator không gọi được https://api.github.com
/// hoặc khi bạn dạy thực hành offline.
class GithubUserRepositoryMock implements GithubUserRepository {
  @override
  Future<List<GithubUser>> getUsers({String? query}) async {
    // giả lập network
    await Future<void>.delayed(const Duration(milliseconds: 400));

    final q = (query ?? '').toLowerCase();

    final data = <GithubUser>[
      GithubUser(
        id: 1,
        login: 'flutterdev',
        avatarUrl: 'https://via.placeholder.com/150?text=flutter',
        htmlUrl: 'https://github.com/flutter',
      ),
      GithubUser(
        id: 2,
        login: 'dart-lang',
        avatarUrl: 'https://via.placeholder.com/150?text=dart',
        htmlUrl: 'https://github.com/dart-lang',
      ),
      GithubUser(
        id: 3,
        login: 'your-company',
        avatarUrl: 'https://via.placeholder.com/150?text=company',
        htmlUrl: 'https://github.com/your-company',
      ),
    ];

    // nếu có query thì lọc cho sinh động
    if (q.isNotEmpty) {
      return data.where((e) => e.login.toLowerCase().contains(q)).toList();
    }

    return data;
  }
}
