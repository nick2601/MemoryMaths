// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameCategoryAdapter extends TypeAdapter<GameCategory> {
  @override
  final int typeId = 4;

  @override
  GameCategory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameCategory(
      id: fields[0] as int,
      name: fields[1] as String,
      key: fields[2] as String,
      gameCategoryType: fields[3] as GameCategoryType,
      routePath: fields[4] as String,
      scoreboard: fields[5] as ScoreBoard,
      icon: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, GameCategory obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.key)
      ..writeByte(3)
      ..write(obj.gameCategoryType)
      ..writeByte(4)
      ..write(obj.routePath)
      ..writeByte(5)
      ..write(obj.scoreboard)
      ..writeByte(6)
      ..write(obj.icon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameCategory _$GameCategoryFromJson(Map<String, dynamic> json) => GameCategory(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      key: json['key'] as String,
      gameCategoryType:
          $enumDecode(_$GameCategoryTypeEnumMap, json['gameCategoryType']),
      routePath: json['routePath'] as String,
      scoreboard:
          ScoreBoard.fromJson(json['scoreboard'] as Map<String, dynamic>),
      icon: json['icon'] as String,
    );

Map<String, dynamic> _$GameCategoryToJson(GameCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'key': instance.key,
      'gameCategoryType': _$GameCategoryTypeEnumMap[instance.gameCategoryType]!,
      'routePath': instance.routePath,
      'scoreboard': instance.scoreboard,
      'icon': instance.icon,
    };

const _$GameCategoryTypeEnumMap = {
  GameCategoryType.CALCULATOR: 'CALCULATOR',
  GameCategoryType.GUESS_SIGN: 'GUESS_SIGN',
  GameCategoryType.SQUARE_ROOT: 'SQUARE_ROOT',
  GameCategoryType.MATH_PAIRS: 'MATH_PAIRS',
  GameCategoryType.CORRECT_ANSWER: 'CORRECT_ANSWER',
  GameCategoryType.MAGIC_TRIANGLE: 'MAGIC_TRIANGLE',
  GameCategoryType.MENTAL_ARITHMETIC: 'MENTAL_ARITHMETIC',
  GameCategoryType.QUICK_CALCULATION: 'QUICK_CALCULATION',
  GameCategoryType.FIND_MISSING: 'FIND_MISSING',
  GameCategoryType.TRUE_FALSE: 'TRUE_FALSE',
  GameCategoryType.MATH_GRID: 'MATH_GRID',
  GameCategoryType.PICTURE_PUZZLE: 'PICTURE_PUZZLE',
  GameCategoryType.NUMBER_PYRAMID: 'NUMBER_PYRAMID',
  GameCategoryType.DUAL_GAME: 'DUAL_GAME',
  GameCategoryType.COMPLEX_CALCULATION: 'COMPLEX_CALCULATION',
  GameCategoryType.CUBE_ROOT: 'CUBE_ROOT',
  GameCategoryType.CONCENTRATION: 'CONCENTRATION',
  GameCategoryType.NUMERIC_MEMORY: 'NUMERIC_MEMORY',
};
