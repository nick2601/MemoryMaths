// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_board.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScoreBoardAdapter extends TypeAdapter<ScoreBoard> {
  @override
  final int typeId = 62;

  @override
  ScoreBoard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScoreBoard(
      highestScore: fields[0] as int,
      firstTime: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ScoreBoard obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.highestScore)
      ..writeByte(1)
      ..write(obj.firstTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScoreBoardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
