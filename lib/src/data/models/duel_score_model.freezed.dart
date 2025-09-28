// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'duel_score_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DuelScoreModel _$DuelScoreModelFromJson(Map<String, dynamic> json) {
  return _DuelScoreModel.fromJson(json);
}

/// @nodoc
mixin _$DuelScoreModel {
  @HiveField(0)
  String? get title => throw _privateConstructorUsedError;
  @HiveField(1)
  String? get subTitle => throw _privateConstructorUsedError;
  @HiveField(2)
  int get score => throw _privateConstructorUsedError;

  /// Serializes this DuelScoreModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DuelScoreModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DuelScoreModelCopyWith<DuelScoreModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DuelScoreModelCopyWith<$Res> {
  factory $DuelScoreModelCopyWith(
          DuelScoreModel value, $Res Function(DuelScoreModel) then) =
      _$DuelScoreModelCopyWithImpl<$Res, DuelScoreModel>;
  @useResult
  $Res call(
      {@HiveField(0) String? title,
      @HiveField(1) String? subTitle,
      @HiveField(2) int score});
}

/// @nodoc
class _$DuelScoreModelCopyWithImpl<$Res, $Val extends DuelScoreModel>
    implements $DuelScoreModelCopyWith<$Res> {
  _$DuelScoreModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DuelScoreModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? subTitle = freezed,
    Object? score = null,
  }) {
    return _then(_value.copyWith(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      subTitle: freezed == subTitle
          ? _value.subTitle
          : subTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DuelScoreModelImplCopyWith<$Res>
    implements $DuelScoreModelCopyWith<$Res> {
  factory _$$DuelScoreModelImplCopyWith(_$DuelScoreModelImpl value,
          $Res Function(_$DuelScoreModelImpl) then) =
      __$$DuelScoreModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String? title,
      @HiveField(1) String? subTitle,
      @HiveField(2) int score});
}

/// @nodoc
class __$$DuelScoreModelImplCopyWithImpl<$Res>
    extends _$DuelScoreModelCopyWithImpl<$Res, _$DuelScoreModelImpl>
    implements _$$DuelScoreModelImplCopyWith<$Res> {
  __$$DuelScoreModelImplCopyWithImpl(
      _$DuelScoreModelImpl _value, $Res Function(_$DuelScoreModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of DuelScoreModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? subTitle = freezed,
    Object? score = null,
  }) {
    return _then(_$DuelScoreModelImpl(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      subTitle: freezed == subTitle
          ? _value.subTitle
          : subTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DuelScoreModelImpl implements _DuelScoreModel {
  const _$DuelScoreModelImpl(
      {@HiveField(0) this.title,
      @HiveField(1) this.subTitle,
      @HiveField(2) this.score = 0});

  factory _$DuelScoreModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DuelScoreModelImplFromJson(json);

  @override
  @HiveField(0)
  final String? title;
  @override
  @HiveField(1)
  final String? subTitle;
  @override
  @JsonKey()
  @HiveField(2)
  final int score;

  @override
  String toString() {
    return 'DuelScoreModel(title: $title, subTitle: $subTitle, score: $score)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DuelScoreModelImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subTitle, subTitle) ||
                other.subTitle == subTitle) &&
            (identical(other.score, score) || other.score == score));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, subTitle, score);

  /// Create a copy of DuelScoreModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DuelScoreModelImplCopyWith<_$DuelScoreModelImpl> get copyWith =>
      __$$DuelScoreModelImplCopyWithImpl<_$DuelScoreModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DuelScoreModelImplToJson(
      this,
    );
  }
}

abstract class _DuelScoreModel implements DuelScoreModel {
  const factory _DuelScoreModel(
      {@HiveField(0) final String? title,
      @HiveField(1) final String? subTitle,
      @HiveField(2) final int score}) = _$DuelScoreModelImpl;

  factory _DuelScoreModel.fromJson(Map<String, dynamic> json) =
      _$DuelScoreModelImpl.fromJson;

  @override
  @HiveField(0)
  String? get title;
  @override
  @HiveField(1)
  String? get subTitle;
  @override
  @HiveField(2)
  int get score;

  /// Create a copy of DuelScoreModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DuelScoreModelImplCopyWith<_$DuelScoreModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
