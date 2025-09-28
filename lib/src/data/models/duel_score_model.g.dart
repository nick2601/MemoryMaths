// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duel_score_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DuelScoreModelAdapter extends TypeAdapter<DuelScoreModel> {
  @override
  final int typeId = 2;

  @override
  DuelScoreModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DuelScoreModel(
      title: fields[0] as String?,
      subTitle: fields[1] as String?,
      score: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, DuelScoreModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.subTitle)
      ..writeByte(2)
      ..write(obj.score);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DuelScoreModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DuelScoreModelImpl _$$DuelScoreModelImplFromJson(Map<String, dynamic> json) =>
    _$DuelScoreModelImpl(
      title: json['title'] as String?,
      subTitle: json['subTitle'] as String?,
      score: (json['score'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$DuelScoreModelImplToJson(
        _$DuelScoreModelImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'subTitle': instance.subTitle,
      'score': instance.score,
    };
