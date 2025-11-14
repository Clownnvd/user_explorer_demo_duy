import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user_explorer/core/errors/app_exception.dart';
import 'package:github_user_explorer/features/users/domain/repositories/github_user_repository.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GithubUserRepository repo;

  UserCubit(this.repo) : super(const UserState.initial());

  Future<void> fetchUsers({String? query}) async {
    emit(const UserState.loading());

    try {
      final users = await repo.getUsers(query: query);
      emit(UserState.loaded(users));
    } on AppException catch (e) {
      emit(UserState.error(e.message));
    } catch (e) {
      emit(UserState.error("Đã xảy ra lỗi không xác định"));
    }
  }
}
