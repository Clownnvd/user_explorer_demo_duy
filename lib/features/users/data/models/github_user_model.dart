import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_user_explorer/features/users/domain/entities/github_user.dart';

part 'github_user_model.freezed.dart';
part 'github_user_model.g.dart';

@freezed
class GithubUserModel with _$GithubUserModel {
  const factory GithubUserModel({
    required int id,
    required String login,
    @JsonKey(name: 'avatar_url') required String avatarUrl,
    @JsonKey(name: 'html_url') required String htmlUrl,
  }) = _GithubUserModel;

  factory GithubUserModel.fromJson(Map<String, dynamic> json) =>
      _$GithubUserModelFromJson(json);
}

extension GithubUserModelMapper on GithubUserModel {
  GithubUser toEntity() => GithubUser(
        id: id,
        login: login,
        avatarUrl: avatarUrl,
        htmlUrl: htmlUrl,
      );

  static GithubUserModel fromEntity(GithubUser user) =>
      GithubUserModel(
        id: user.id,
        login: user.login,
        avatarUrl: user.avatarUrl,
        htmlUrl: user.htmlUrl,
      );
}
