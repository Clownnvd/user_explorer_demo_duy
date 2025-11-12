import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user_explorer/features/users/domain/usecases/get_users.dart';
import 'package:github_user_explorer/features/users/presentation/cubit/user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetUsers _getUsers;
  UserCubit(this._getUsers) : super(UserInitial());

  /// Fetch danh sách người dùng GitHub (có thể kèm query)
  Future<void> fetchUsers({String? query}) async {
    emit(UserLoading());
    try {
      final users = await _getUsers(query: query);
      emit(UserLoaded(users));

      // ✅ Log structured: thành công
      log(
        'Fetched ${users.length} users${query != null ? ' (query="$query")' : ''}',
        name: 'UserCubit',
      );
    } catch (e, st) {
      // ✅ Log structured: lỗi có stack trace
      log(
        'Error fetching users: $e',
        name: 'UserCubit',
        error: e,
        stackTrace: st,
      );
      emit(UserError(e.toString()));
    }
  }

  /// Theo dõi thay đổi state trong Cubit
  @override
  void onChange(Change<UserState> change) {
    super.onChange(change);
    log(
      'State change: ${change.currentState.runtimeType} → ${change.nextState.runtimeType}',
      name: 'UserCubit',
    );
  }
}
