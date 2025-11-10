import 'package:github_user_explorer/features/users/domain/entities/github_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'github_user_model.g.dart';

@JsonSerializable()
class GithubUserModel {
  final int id;
  final String login;

  @JsonKey(name: 'avatar_url')
  final String avatarUrl;

  @JsonKey(name: 'html_url')
  final String htmlUrl;

  const GithubUserModel({
    required this.id,
    required this.login,
    required this.avatarUrl,
    required this.htmlUrl,
  });

  /// fromJson sẽ được sinh trong file .g.dart
  factory GithubUserModel.fromJson(Map<String, dynamic> json) =>
      _$GithubUserModelFromJson(json);

  /// toJson cũng vậy
  Map<String, dynamic> toJson() => _$GithubUserModelToJson(this);

  /// tiện để mapping sang entity domain
  GithubUser toEntity() => GithubUser(
        id: id,
        login: login,
        avatarUrl: avatarUrl,
        htmlUrl: htmlUrl,
      );

  /// nếu ở tầng trên bạn đã có entity mà muốn lưu xuống data
  factory GithubUserModel.fromEntity(GithubUser user) => GithubUserModel(
        id: user.id,
        login: user.login,
        avatarUrl: user.avatarUrl,
        htmlUrl: user.htmlUrl,
      );
}
