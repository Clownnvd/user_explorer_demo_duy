// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'github_user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GithubUserModel _$GithubUserModelFromJson(Map<String, dynamic> json) {
  return _GithubUserModel.fromJson(json);
}

/// @nodoc
mixin _$GithubUserModel {
  int get id => throw _privateConstructorUsedError;
  String get login => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_url')
  String get avatarUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'html_url')
  String get htmlUrl => throw _privateConstructorUsedError;

  /// Serializes this GithubUserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GithubUserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GithubUserModelCopyWith<GithubUserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GithubUserModelCopyWith<$Res> {
  factory $GithubUserModelCopyWith(
          GithubUserModel value, $Res Function(GithubUserModel) then) =
      _$GithubUserModelCopyWithImpl<$Res, GithubUserModel>;
  @useResult
  $Res call(
      {int id,
      String login,
      @JsonKey(name: 'avatar_url') String avatarUrl,
      @JsonKey(name: 'html_url') String htmlUrl});
}

/// @nodoc
class _$GithubUserModelCopyWithImpl<$Res, $Val extends GithubUserModel>
    implements $GithubUserModelCopyWith<$Res> {
  _$GithubUserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GithubUserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? login = null,
    Object? avatarUrl = null,
    Object? htmlUrl = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      login: null == login
          ? _value.login
          : login // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: null == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
      htmlUrl: null == htmlUrl
          ? _value.htmlUrl
          : htmlUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GithubUserModelImplCopyWith<$Res>
    implements $GithubUserModelCopyWith<$Res> {
  factory _$$GithubUserModelImplCopyWith(_$GithubUserModelImpl value,
          $Res Function(_$GithubUserModelImpl) then) =
      __$$GithubUserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String login,
      @JsonKey(name: 'avatar_url') String avatarUrl,
      @JsonKey(name: 'html_url') String htmlUrl});
}

/// @nodoc
class __$$GithubUserModelImplCopyWithImpl<$Res>
    extends _$GithubUserModelCopyWithImpl<$Res, _$GithubUserModelImpl>
    implements _$$GithubUserModelImplCopyWith<$Res> {
  __$$GithubUserModelImplCopyWithImpl(
      _$GithubUserModelImpl _value, $Res Function(_$GithubUserModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of GithubUserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? login = null,
    Object? avatarUrl = null,
    Object? htmlUrl = null,
  }) {
    return _then(_$GithubUserModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      login: null == login
          ? _value.login
          : login // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: null == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
      htmlUrl: null == htmlUrl
          ? _value.htmlUrl
          : htmlUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GithubUserModelImpl implements _GithubUserModel {
  const _$GithubUserModelImpl(
      {required this.id,
      required this.login,
      @JsonKey(name: 'avatar_url') required this.avatarUrl,
      @JsonKey(name: 'html_url') required this.htmlUrl});

  factory _$GithubUserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GithubUserModelImplFromJson(json);

  @override
  final int id;
  @override
  final String login;
  @override
  @JsonKey(name: 'avatar_url')
  final String avatarUrl;
  @override
  @JsonKey(name: 'html_url')
  final String htmlUrl;

  @override
  String toString() {
    return 'GithubUserModel(id: $id, login: $login, avatarUrl: $avatarUrl, htmlUrl: $htmlUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GithubUserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.login, login) || other.login == login) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.htmlUrl, htmlUrl) || other.htmlUrl == htmlUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, login, avatarUrl, htmlUrl);

  /// Create a copy of GithubUserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GithubUserModelImplCopyWith<_$GithubUserModelImpl> get copyWith =>
      __$$GithubUserModelImplCopyWithImpl<_$GithubUserModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GithubUserModelImplToJson(
      this,
    );
  }
}

abstract class _GithubUserModel implements GithubUserModel {
  const factory _GithubUserModel(
          {required final int id,
          required final String login,
          @JsonKey(name: 'avatar_url') required final String avatarUrl,
          @JsonKey(name: 'html_url') required final String htmlUrl}) =
      _$GithubUserModelImpl;

  factory _GithubUserModel.fromJson(Map<String, dynamic> json) =
      _$GithubUserModelImpl.fromJson;

  @override
  int get id;
  @override
  String get login;
  @override
  @JsonKey(name: 'avatar_url')
  String get avatarUrl;
  @override
  @JsonKey(name: 'html_url')
  String get htmlUrl;

  /// Create a copy of GithubUserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GithubUserModelImplCopyWith<_$GithubUserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
