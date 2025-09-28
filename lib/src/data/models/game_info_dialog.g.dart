// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_info_dialog.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameInfoDialogAdapter extends TypeAdapter<GameInfoDialog> {
  @override
  final int typeId = 5;

  @override
  GameInfoDialog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameInfoDialog(
      title: fields[0] as String,
      image: fields[1] as String,
      dec: fields[2] as String,
      correctAnswerScore: fields[3] as double,
      wrongAnswerScore: fields[4] as double,
      primaryColor: fields[5] as Color,
      backgroundColor: fields[6] as Color,
    );
  }

  @override
  void write(BinaryWriter writer, GameInfoDialog obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.dec)
      ..writeByte(3)
      ..write(obj.correctAnswerScore)
      ..writeByte(4)
      ..write(obj.wrongAnswerScore)
      ..writeByte(5)
      ..write(obj.primaryColor)
      ..writeByte(6)
      ..write(obj.backgroundColor);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameInfoDialogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameInfoDialogImpl _$$GameInfoDialogImplFromJson(Map<String, dynamic> json) =>
    _$GameInfoDialogImpl(
      title: json['title'] as String,
      image: json['image'] as String,
      dec: json['dec'] as String,
      correctAnswerScore: (json['correctAnswerScore'] as num).toDouble(),
      wrongAnswerScore: (json['wrongAnswerScore'] as num).toDouble(),
      primaryColor:
          ColorConverter.fromJson((json['primaryColor'] as num).toInt()),
      backgroundColor:
          ColorConverter.fromJson((json['backgroundColor'] as num).toInt()),
    );

Map<String, dynamic> _$$GameInfoDialogImplToJson(
        _$GameInfoDialogImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'image': instance.image,
      'dec': instance.dec,
      'correctAnswerScore': instance.correctAnswerScore,
      'wrongAnswerScore': instance.wrongAnswerScore,
      'primaryColor': ColorConverter.toJson(instance.primaryColor),
      'backgroundColor': ColorConverter.toJson(instance.backgroundColor),
    };
