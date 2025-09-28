// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AlertResponseAdapter extends TypeAdapter<AlertResponse> {
  @override
  final int typeId = 1;

  @override
  AlertResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AlertResponse(
      exit: fields[0] as bool,
      restart: fields[1] as bool,
      play: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, AlertResponse obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.exit)
      ..writeByte(1)
      ..write(obj.restart)
      ..writeByte(2)
      ..write(obj.play);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlertResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
