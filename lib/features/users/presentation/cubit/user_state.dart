import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_user_explorer/features/users/domain/entities/github_user.dart';

part 'user_state.freezed.dart';
//Định nghĩa các state của UserCubit
//Freezed union/sealed classes
//Mỗi state là 1 class riêng.
//Có when, map để pattern match state rất gọn và an toàn kiểu.
@freezed
class UserState with _$UserState {
  const factory UserState.initial() = _Initial;
  const factory UserState.loading() = _Loading;
  const factory UserState.loaded(List<GithubUser> users) = _Loaded;
  const factory UserState.error(String message) = _Error;
}
