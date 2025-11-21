import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user_explorer/core/errors/app_exception.dart';
import 'package:github_user_explorer/features/users/domain/repositories/github_user_repository.dart';
import 'package:github_user_explorer/core/log.dart';
import 'user_state.dart';
//Nhận repository (mock hoặc real) từ DI.
//Không quan tâm API được gọi như nào.
//Quản lý state của màn hình danh sách users.
class UserCubit extends Cubit<UserState> {
  final GithubUserRepository repo;

  UserCubit(this.repo) : super(const UserState.initial());

  Future<void> fetchUsers({String? query}) async {
    AppLogger.debug("fetchUsers called | query: $query", name: "UserCubit");

    emit(const UserState.loading());

    try {
      final users = await repo.getUsers(query: query);

      AppLogger.info(
        "Loaded ${users.length} users",
        name: "UserCubit",
      );

      emit(UserState.loaded(users));

    } on AppException catch (e, s) {
      AppLogger.error(
        "AppException caught: ${e.message}",
        name: "UserCubit",
        error: e,
        stack: s,
      );

      emit(UserState.error(e.message));

    } catch (e, s) {
      AppLogger.error(
        "Unknown error during fetchUsers",
        name: "UserCubit",
        error: e,
        stack: s,
      );

      emit(UserState.error("Đã xảy ra lỗi không xác định"));
    }
  }
}
