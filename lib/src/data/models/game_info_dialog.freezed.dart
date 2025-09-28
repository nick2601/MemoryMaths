// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_info_dialog.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GameInfoDialog _$GameInfoDialogFromJson(Map<String, dynamic> json) {
  return _GameInfoDialog.fromJson(json);
}

/// @nodoc
mixin _$GameInfoDialog {
  /// The title of the game to be displayed
  @HiveField(0)
  String get title => throw _privateConstructorUsedError;

  /// Path to the game's instruction image or animation
  @HiveField(1)
  String get image => throw _privateConstructorUsedError;

  /// Description of how to play the game
  @HiveField(2)
  String get dec => throw _privateConstructorUsedError;

  /// Points awarded for correct answers
  @HiveField(3)
  double get correctAnswerScore => throw _privateConstructorUsedError;

  /// Points deducted for wrong answers
  @HiveField(4)
  double get wrongAnswerScore => throw _privateConstructorUsedError;

  /// Primary theme color
  @HiveField(5)
  @JsonKey(fromJson: ColorConverter.fromJson, toJson: ColorConverter.toJson)
  Color get primaryColor => throw _privateConstructorUsedError;

  /// Background theme color
  @HiveField(6)
  @JsonKey(fromJson: ColorConverter.fromJson, toJson: ColorConverter.toJson)
  Color get backgroundColor => throw _privateConstructorUsedError;

  /// Serializes this GameInfoDialog to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GameInfoDialog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameInfoDialogCopyWith<GameInfoDialog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameInfoDialogCopyWith<$Res> {
  factory $GameInfoDialogCopyWith(
          GameInfoDialog value, $Res Function(GameInfoDialog) then) =
      _$GameInfoDialogCopyWithImpl<$Res, GameInfoDialog>;
  @useResult
  $Res call(
      {@HiveField(0) String title,
      @HiveField(1) String image,
      @HiveField(2) String dec,
      @HiveField(3) double correctAnswerScore,
      @HiveField(4) double wrongAnswerScore,
      @HiveField(5)
      @JsonKey(fromJson: ColorConverter.fromJson, toJson: ColorConverter.toJson)
      Color primaryColor,
      @HiveField(6)
      @JsonKey(fromJson: ColorConverter.fromJson, toJson: ColorConverter.toJson)
      Color backgroundColor});
}

/// @nodoc
class _$GameInfoDialogCopyWithImpl<$Res, $Val extends GameInfoDialog>
    implements $GameInfoDialogCopyWith<$Res> {
  _$GameInfoDialogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameInfoDialog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? image = null,
    Object? dec = null,
    Object? correctAnswerScore = null,
    Object? wrongAnswerScore = null,
    Object? primaryColor = null,
    Object? backgroundColor = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      dec: null == dec
          ? _value.dec
          : dec // ignore: cast_nullable_to_non_nullable
              as String,
      correctAnswerScore: null == correctAnswerScore
          ? _value.correctAnswerScore
          : correctAnswerScore // ignore: cast_nullable_to_non_nullable
              as double,
      wrongAnswerScore: null == wrongAnswerScore
          ? _value.wrongAnswerScore
          : wrongAnswerScore // ignore: cast_nullable_to_non_nullable
              as double,
      primaryColor: null == primaryColor
          ? _value.primaryColor
          : primaryColor // ignore: cast_nullable_to_non_nullable
              as Color,
      backgroundColor: null == backgroundColor
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as Color,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameInfoDialogImplCopyWith<$Res>
    implements $GameInfoDialogCopyWith<$Res> {
  factory _$$GameInfoDialogImplCopyWith(_$GameInfoDialogImpl value,
          $Res Function(_$GameInfoDialogImpl) then) =
      __$$GameInfoDialogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String title,
      @HiveField(1) String image,
      @HiveField(2) String dec,
      @HiveField(3) double correctAnswerScore,
      @HiveField(4) double wrongAnswerScore,
      @HiveField(5)
      @JsonKey(fromJson: ColorConverter.fromJson, toJson: ColorConverter.toJson)
      Color primaryColor,
      @HiveField(6)
      @JsonKey(fromJson: ColorConverter.fromJson, toJson: ColorConverter.toJson)
      Color backgroundColor});
}

/// @nodoc
class __$$GameInfoDialogImplCopyWithImpl<$Res>
    extends _$GameInfoDialogCopyWithImpl<$Res, _$GameInfoDialogImpl>
    implements _$$GameInfoDialogImplCopyWith<$Res> {
  __$$GameInfoDialogImplCopyWithImpl(
      _$GameInfoDialogImpl _value, $Res Function(_$GameInfoDialogImpl) _then)
      : super(_value, _then);

  /// Create a copy of GameInfoDialog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? image = null,
    Object? dec = null,
    Object? correctAnswerScore = null,
    Object? wrongAnswerScore = null,
    Object? primaryColor = null,
    Object? backgroundColor = null,
  }) {
    return _then(_$GameInfoDialogImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      dec: null == dec
          ? _value.dec
          : dec // ignore: cast_nullable_to_non_nullable
              as String,
      correctAnswerScore: null == correctAnswerScore
          ? _value.correctAnswerScore
          : correctAnswerScore // ignore: cast_nullable_to_non_nullable
              as double,
      wrongAnswerScore: null == wrongAnswerScore
          ? _value.wrongAnswerScore
          : wrongAnswerScore // ignore: cast_nullable_to_non_nullable
              as double,
      primaryColor: null == primaryColor
          ? _value.primaryColor
          : primaryColor // ignore: cast_nullable_to_non_nullable
              as Color,
      backgroundColor: null == backgroundColor
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameInfoDialogImpl implements _GameInfoDialog {
  const _$GameInfoDialogImpl(
      {@HiveField(0) required this.title,
      @HiveField(1) required this.image,
      @HiveField(2) required this.dec,
      @HiveField(3) required this.correctAnswerScore,
      @HiveField(4) required this.wrongAnswerScore,
      @HiveField(5)
      @JsonKey(fromJson: ColorConverter.fromJson, toJson: ColorConverter.toJson)
      required this.primaryColor,
      @HiveField(6)
      @JsonKey(fromJson: ColorConverter.fromJson, toJson: ColorConverter.toJson)
      required this.backgroundColor});

  factory _$GameInfoDialogImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameInfoDialogImplFromJson(json);

  /// The title of the game to be displayed
  @override
  @HiveField(0)
  final String title;

  /// Path to the game's instruction image or animation
  @override
  @HiveField(1)
  final String image;

  /// Description of how to play the game
  @override
  @HiveField(2)
  final String dec;

  /// Points awarded for correct answers
  @override
  @HiveField(3)
  final double correctAnswerScore;

  /// Points deducted for wrong answers
  @override
  @HiveField(4)
  final double wrongAnswerScore;

  /// Primary theme color
  @override
  @HiveField(5)
  @JsonKey(fromJson: ColorConverter.fromJson, toJson: ColorConverter.toJson)
  final Color primaryColor;

  /// Background theme color
  @override
  @HiveField(6)
  @JsonKey(fromJson: ColorConverter.fromJson, toJson: ColorConverter.toJson)
  final Color backgroundColor;

  @override
  String toString() {
    return 'GameInfoDialog(title: $title, image: $image, dec: $dec, correctAnswerScore: $correctAnswerScore, wrongAnswerScore: $wrongAnswerScore, primaryColor: $primaryColor, backgroundColor: $backgroundColor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameInfoDialogImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.dec, dec) || other.dec == dec) &&
            (identical(other.correctAnswerScore, correctAnswerScore) ||
                other.correctAnswerScore == correctAnswerScore) &&
            (identical(other.wrongAnswerScore, wrongAnswerScore) ||
                other.wrongAnswerScore == wrongAnswerScore) &&
            (identical(other.primaryColor, primaryColor) ||
                other.primaryColor == primaryColor) &&
            (identical(other.backgroundColor, backgroundColor) ||
                other.backgroundColor == backgroundColor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, image, dec,
      correctAnswerScore, wrongAnswerScore, primaryColor, backgroundColor);

  /// Create a copy of GameInfoDialog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameInfoDialogImplCopyWith<_$GameInfoDialogImpl> get copyWith =>
      __$$GameInfoDialogImplCopyWithImpl<_$GameInfoDialogImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameInfoDialogImplToJson(
      this,
    );
  }
}

abstract class _GameInfoDialog implements GameInfoDialog {
  const factory _GameInfoDialog(
      {@HiveField(0) required final String title,
      @HiveField(1) required final String image,
      @HiveField(2) required final String dec,
      @HiveField(3) required final double correctAnswerScore,
      @HiveField(4) required final double wrongAnswerScore,
      @HiveField(5)
      @JsonKey(fromJson: ColorConverter.fromJson, toJson: ColorConverter.toJson)
      required final Color primaryColor,
      @HiveField(6)
      @JsonKey(fromJson: ColorConverter.fromJson, toJson: ColorConverter.toJson)
      required final Color backgroundColor}) = _$GameInfoDialogImpl;

  factory _GameInfoDialog.fromJson(Map<String, dynamic> json) =
      _$GameInfoDialogImpl.fromJson;

  /// The title of the game to be displayed
  @override
  @HiveField(0)
  String get title;

  /// Path to the game's instruction image or animation
  @override
  @HiveField(1)
  String get image;

  /// Description of how to play the game
  @override
  @HiveField(2)
  String get dec;

  /// Points awarded for correct answers
  @override
  @HiveField(3)
  double get correctAnswerScore;

  /// Points deducted for wrong answers
  @override
  @HiveField(4)
  double get wrongAnswerScore;

  /// Primary theme color
  @override
  @HiveField(5)
  @JsonKey(fromJson: ColorConverter.fromJson, toJson: ColorConverter.toJson)
  Color get primaryColor;

  /// Background theme color
  @override
  @HiveField(6)
  @JsonKey(fromJson: ColorConverter.fromJson, toJson: ColorConverter.toJson)
  Color get backgroundColor;

  /// Create a copy of GameInfoDialog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameInfoDialogImplCopyWith<_$GameInfoDialogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
