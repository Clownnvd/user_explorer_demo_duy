import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user_explorer/features/users/domain/usecases/get_users.dart';
import 'package:github_user_explorer/features/users/presentation/cubit/user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetUsers _getUsers;
  UserCubit(this._getUsers) : super(UserInitial());

  Future<void> fetchUsers({String? query}) async {
    emit(UserLoading());
    try {
      final users = await _getUsers(query: query);
      emit(UserLoaded(users));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
