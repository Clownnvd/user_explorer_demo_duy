import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user_explorer/features/users/domain/usecases/get_users.dart';
import 'package:github_user_explorer/features/users/presentation/cubit/user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetUsers _getUsers;

  UserCubit(this._getUsers) : super(const UserState.initial());

  Future<void> fetchUsers({String? query}) async {
    emit(const UserState.loading());
    try {
      final users = await _getUsers(query: query);
      emit(UserState.loaded(users));
    } catch (e) {
      emit(UserState.error(e.toString()));
    }
  }
}
