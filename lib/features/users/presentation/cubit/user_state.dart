import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_user_explorer/features/users/domain/entities/github_user.dart';

part 'user_state.freezed.dart';

@freezed
class UserState with _$UserState {
  const factory UserState.initial() = _Initial;
  const factory UserState.loading() = _Loading;
  const factory UserState.loaded(List<GithubUser> users) = _Loaded;
  const factory UserState.error(String message) = _Error;
}
