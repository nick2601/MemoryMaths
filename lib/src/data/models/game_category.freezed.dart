// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GameCategory _$GameCategoryFromJson(Map<String, dynamic> json) {
  return _GameCategory.fromJson(json);
}

/// @nodoc
mixin _$GameCategory {
  /// Unique identifier for the game category
  @HiveField(0)
  int get id => throw _privateConstructorUsedError;

  /// Display name of the game category
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;

  /// Unique key identifier used for internal references
  @HiveField(2)
  String get key => throw _privateConstructorUsedError;

  /// Type of game category, defined in GameCategoryType enum
  @HiveField(3)
  GameCategoryType get gameCategoryType => throw _privateConstructorUsedError;

  /// Navigation route path for this game category
  @HiveField(4)
  String get routePath => throw _privateConstructorUsedError;

  /// Scoreboard associated with this game category
  @HiveField(5)
  ScoreBoard get scoreboard => throw _privateConstructorUsedError;

  /// Icon asset path for the game category
  @HiveField(6)
  String get icon => throw _privateConstructorUsedError;

  /// Serializes this GameCategory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GameCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameCategoryCopyWith<GameCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameCategoryCopyWith<$Res> {
  factory $GameCategoryCopyWith(
          GameCategory value, $Res Function(GameCategory) then) =
      _$GameCategoryCopyWithImpl<$Res, GameCategory>;
  @useResult
  $Res call(
      {@HiveField(0) int id,
      @HiveField(1) String name,
      @HiveField(2) String key,
      @HiveField(3) GameCategoryType gameCategoryType,
      @HiveField(4) String routePath,
      @HiveField(5) ScoreBoard scoreboard,
      @HiveField(6) String icon});
}

/// @nodoc
class _$GameCategoryCopyWithImpl<$Res, $Val extends GameCategory>
    implements $GameCategoryCopyWith<$Res> {
  _$GameCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? key = null,
    Object? gameCategoryType = null,
    Object? routePath = null,
    Object? scoreboard = null,
    Object? icon = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      gameCategoryType: null == gameCategoryType
          ? _value.gameCategoryType
          : gameCategoryType // ignore: cast_nullable_to_non_nullable
              as GameCategoryType,
      routePath: null == routePath
          ? _value.routePath
          : routePath // ignore: cast_nullable_to_non_nullable
              as String,
      scoreboard: null == scoreboard
          ? _value.scoreboard
          : scoreboard // ignore: cast_nullable_to_non_nullable
              as ScoreBoard,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameCategoryImplCopyWith<$Res>
    implements $GameCategoryCopyWith<$Res> {
  factory _$$GameCategoryImplCopyWith(
          _$GameCategoryImpl value, $Res Function(_$GameCategoryImpl) then) =
      __$$GameCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) int id,
      @HiveField(1) String name,
      @HiveField(2) String key,
      @HiveField(3) GameCategoryType gameCategoryType,
      @HiveField(4) String routePath,
      @HiveField(5) ScoreBoard scoreboard,
      @HiveField(6) String icon});
}

/// @nodoc
class __$$GameCategoryImplCopyWithImpl<$Res>
    extends _$GameCategoryCopyWithImpl<$Res, _$GameCategoryImpl>
    implements _$$GameCategoryImplCopyWith<$Res> {
  __$$GameCategoryImplCopyWithImpl(
      _$GameCategoryImpl _value, $Res Function(_$GameCategoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of GameCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? key = null,
    Object? gameCategoryType = null,
    Object? routePath = null,
    Object? scoreboard = null,
    Object? icon = null,
  }) {
    return _then(_$GameCategoryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      gameCategoryType: null == gameCategoryType
          ? _value.gameCategoryType
          : gameCategoryType // ignore: cast_nullable_to_non_nullable
              as GameCategoryType,
      routePath: null == routePath
          ? _value.routePath
          : routePath // ignore: cast_nullable_to_non_nullable
              as String,
      scoreboard: null == scoreboard
          ? _value.scoreboard
          : scoreboard // ignore: cast_nullable_to_non_nullable
              as ScoreBoard,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameCategoryImpl implements _GameCategory {
  const _$GameCategoryImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.name,
      @HiveField(2) required this.key,
      @HiveField(3) required this.gameCategoryType,
      @HiveField(4) required this.routePath,
      @HiveField(5) required this.scoreboard,
      @HiveField(6) required this.icon});

  factory _$GameCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameCategoryImplFromJson(json);

  /// Unique identifier for the game category
  @override
  @HiveField(0)
  final int id;

  /// Display name of the game category
  @override
  @HiveField(1)
  final String name;

  /// Unique key identifier used for internal references
  @override
  @HiveField(2)
  final String key;

  /// Type of game category, defined in GameCategoryType enum
  @override
  @HiveField(3)
  final GameCategoryType gameCategoryType;

  /// Navigation route path for this game category
  @override
  @HiveField(4)
  final String routePath;

  /// Scoreboard associated with this game category
  @override
  @HiveField(5)
  final ScoreBoard scoreboard;

  /// Icon asset path for the game category
  @override
  @HiveField(6)
  final String icon;

  @override
  String toString() {
    return 'GameCategory(id: $id, name: $name, key: $key, gameCategoryType: $gameCategoryType, routePath: $routePath, scoreboard: $scoreboard, icon: $icon)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameCategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.gameCategoryType, gameCategoryType) ||
                other.gameCategoryType == gameCategoryType) &&
            (identical(other.routePath, routePath) ||
                other.routePath == routePath) &&
            (identical(other.scoreboard, scoreboard) ||
                other.scoreboard == scoreboard) &&
            (identical(other.icon, icon) || other.icon == icon));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, key, gameCategoryType,
      routePath, scoreboard, icon);

  /// Create a copy of GameCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameCategoryImplCopyWith<_$GameCategoryImpl> get copyWith =>
      __$$GameCategoryImplCopyWithImpl<_$GameCategoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameCategoryImplToJson(
      this,
    );
  }
}

abstract class _GameCategory implements GameCategory {
  const factory _GameCategory(
      {@HiveField(0) required final int id,
      @HiveField(1) required final String name,
      @HiveField(2) required final String key,
      @HiveField(3) required final GameCategoryType gameCategoryType,
      @HiveField(4) required final String routePath,
      @HiveField(5) required final ScoreBoard scoreboard,
      @HiveField(6) required final String icon}) = _$GameCategoryImpl;

  factory _GameCategory.fromJson(Map<String, dynamic> json) =
      _$GameCategoryImpl.fromJson;

  /// Unique identifier for the game category
  @override
  @HiveField(0)
  int get id;

  /// Display name of the game category
  @override
  @HiveField(1)
  String get name;

  /// Unique key identifier used for internal references
  @override
  @HiveField(2)
  String get key;

  /// Type of game category, defined in GameCategoryType enum
  @override
  @HiveField(3)
  GameCategoryType get gameCategoryType;

  /// Navigation route path for this game category
  @override
  @HiveField(4)
  String get routePath;

  /// Scoreboard associated with this game category
  @override
  @HiveField(5)
  ScoreBoard get scoreboard;

  /// Icon asset path for the game category
  @override
  @HiveField(6)
  String get icon;

  /// Create a copy of GameCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameCategoryImplCopyWith<_$GameCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
