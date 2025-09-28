// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert_request.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AlertRequestAdapter extends TypeAdapter<AlertRequest> {
  @override
  final int typeId = 0;

  @override
  AlertRequest read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AlertRequest(
      type: fields[1] as String,
      gameCategoryType: fields[0] as GameCategoryType,
      score: fields[2] as double,
      coin: fields[3] as double,
      isPause: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, AlertRequest obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.gameCategoryType)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.score)
      ..writeByte(3)
      ..write(obj.coin)
      ..writeByte(4)
      ..write(obj.isPause);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlertRequestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
